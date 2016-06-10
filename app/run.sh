#!/bin/bash


OutputLog ()
{
	echo "=> Adding environmental variables:"
	echo "=> SMTP: $SASL_USER:$SASL_PASS"
	echo "=> Log Key: $LOG_TOKEN"
}


# output logs to logentries.com
cat <<EOF > /etc/rsyslog.d/logentries.conf
\$template Logentries,"$LOG_TOKEN %HOSTNAME% %syslogtag%%msg%\n"

*.* @@api.logentries.com:10000;Logentries
EOF


# Postfix is not using /etc/resolv.conf is because it is running inside a chroot jail, needs its own copy.
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf

# mailname should match the system hostname
echo $HOSTNAME.$DOMAIN > /etc/hostname
cp /etc/hostname /etc/mailname

# Map root user to an actual email
mv /opt/app/virtual /etc/postfix/virtual && sudo postmap /etc/postfix/virtual


postconf -e "myhostname = $HOST.$DOMAIN"
postconf -e "append_dot_mydomain = yes"
postconf -e "mydomain = $DOMAIN"
postconf -e "mydestination = localhost.$DOMAIN localhost"
postconf -e "mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 172.17.0.0/18 $SMTP_ALLOW_IP"
postconf -e "smtpd_banner = $(cat /etc/hostname) ESMTP"
postconf -e "smtpd_relay_restrictions = permit_mynetworks permit_sasl_authenticated defer_unauth_destination permit"
postconf -e "virtual_alias_maps = hash:/etc/postfix/virtual"
postconf -e "smtp_sasl_auth_enable = yes"
postconf -e "smtp_sasl_password_maps = static:$SASL_USER:$SASL_PASS"
postconf -e "smtp_sasl_security_options = noanonymous"
postconf -e "smtp_tls_security_level = encrypt"
postconf -e "header_size_limit = 4096000"
postconf -e "relayhost = [smtp.sendgrid.net]:587"


# These are required when postfix runs chrooted
#
[[ -z $(ls /var/spool/postfix/etc) ]] && {
	for n in hosts localtime nsswitch.conf resolv.conf services
	do
		cp /etc/$n /var/spool/postfix/etc
	done
}


# These also need setgid to stop 'postfix check' worrying.
#
[[ -z $(find /usr/sbin/ -name postqueue -o -name postdrop -perm -2555) ]] && \
	chmod g+s /usr/sbin/post{drop,queue}


# Display system credentials for build testing
#
OutputLog


# Spin everything up
#
/usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
