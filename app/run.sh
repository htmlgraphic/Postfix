#!/bin/bash


StartPostfix ()
{
	echo "=> Adding the following credentials $USER:$PASS"
	echo "=> Log Key: $LOG_TOKEN"
	#$allow_networks = "";
}


# output logs to logentries.com
cat <<EOF > /etc/rsyslog.d/logentries.conf
\$template Logentries,"$LOG_TOKEN %HOSTNAME% %syslogtag%%msg%\n"

*.* @@api.logentries.com:10000;Logentries
EOF


# myhostname should match the name that is given to the container via the 'docker run' command.
# This will help any internal email route proper outbound.
postconf -e \
	myhostname=post-office.htmlgraphic.com \
	mydomain=htmlgraphic.com \
	mydestination="localhost.localdomain localhost" \
	mynetworks="172.17.0.0/18 50.28.0.151 54.225.164.191 104.236.40.133 107.170.0.0/18 10.7.0.0/16 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128" \
	smtpd_relay_restrictions="permit_mynetworks permit_sasl_authenticated defer_unauth_destination permit" \
	mail_spool_directory="/var/spool/mail/" \
	virtual_alias_maps=hash:/etc/postfix/virtual \
	smtp_sasl_auth_enable=yes \
	smtp_sasl_password_maps=static:$USER:$PASS \
	smtp_sasl_security_options=noanonymous \
	smtp_tls_security_level=encrypt \
	header_size_limit=4096000 \
	relayhost=[smtp.sendgrid.net]:587

# Postfix is not using /etc/resolv.conf is because it is running inside a chroot jail, needs its own copy.
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf

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


# Display Postfix credentials for build testing
#
StartPostfix


# Spin everything up
#
/usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
