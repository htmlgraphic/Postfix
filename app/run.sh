#!/bin/bash


OutputLog ()
{
	echo "=> Adding environmental variables:"
	echo "=> SMTP: $USER:$PASS"
	echo "=> Log Key: $LOG_TOKEN"
}


# output logs to logentries.com
cat <<EOF > /etc/rsyslog.d/logentries.conf
\$template Logentries,"$LOG_TOKEN %HOSTNAME% %syslogtag%%msg%\n"

*.* @@api.logentries.com:10000;Logentries
EOF


postconf -e "myhostname = $(cat /etc/hostname)"
postconf -e "mydestination = $myhostname localhost.$mydomain localhost"
postconf -e "mynetworks = 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128 172.17.0.0/18 50.28.0.151 54.225.164.191 67.53.191.246 184.60.94.26 104.236.40.133 107.170.0.0/18 10.7.0.0/16"
postconf -e "smtpd_banner = $HOST ESMTP $mail_name (Ubuntu)"
postconf -e "smtpd_relay_restrictions = permit_mynetworks permit_sasl_authenticated defer_unauth_destination permit"
postconf -e "virtual_alias_maps = hash:/etc/postfix/virtual"
postconf -e "smtp_sasl_auth_enable = yes"
postconf -e "smtp_sasl_password_maps = static:$USER:$PASS"
postconf -e "smtp_sasl_security_options = noanonymous"
postconf -e "smtp_tls_security_level = encrypt"
postconf -e "header_size_limit = 4096000"
postconf -e "relayhost = [smtp.sendgrid.net]:587"

# Postfix is not using /etc/resolv.conf is because it is running inside a chroot jail, needs its own copy.
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf
# mailname should match the system hostname
cp /etc/hostname /etc/mailname

# Map root user to an actual email
mv /opt/app/virtual /etc/postfix/virtual && sudo postmap /etc/postfix/virtual


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
