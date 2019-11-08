#!/usr/bin/env bash
. /etc/environment

#### Extra breathing room
echo -e '\n'

testPostfixUsername()
{
	test=0
	echo 'Testing Postfix username, currently set to "'${SASL_USER}'"'
	if [ ! -z "${SASL_USER}" ]; then
		test=$(/usr/sbin/postconf smtp_sasl_password_maps | grep "${SASL_USER}" | wc -l)
	else
		echo 'ENV $SASL_USER is not set';
	fi
	assertEquals 1 $test
	echo -e '\n'
}


testPostfixPassword()
{
	echo 'Testing Postfix password, currently set to "'${SASL_PASS}'"'
	if [ ! -z "${SASL_PASS}" ]; then
		test=$(/usr/sbin/postconf smtp_sasl_password_maps | grep "${SASL_PASS}" | wc -l)
	else
		echo 'ENV $SASL_PASS is not set';
	fi
	assertEquals 1 $test
	echo -e '\n'
}



testPostfixRelay()
{
	echo 'Relay through SendGrid.'
	test=$(/usr/sbin/postconf relayhost | grep 'sendgrid' | wc -l)
	assertEquals $test 1
	echo -e '\n'
}


testPostfixMyNetworks1()
{
	echo 'Allow 192.168.0.1 to send email.'
	test=$(/usr/sbin/postconf mynetworks | grep '192.168.0.1' | wc -l)
	assertEquals $test 1
	echo -e '\n'
}

testPostfixMyNetworks2()
{
	echo 'Allow 192.168.0.2 to send email.'
	test=$(/usr/sbin/postconf mynetworks | grep '192.168.0.2' | wc -l)
	assertEquals $test 1
	echo -e '\n'
}

testPostfixMyNetworks3()
{
	echo 'Allow 192.168.0.3 to send email.'
	test=$(/usr/sbin/postconf mynetworks | grep '192.168.0.3' | wc -l)
	assertEquals $test 1
	echo -e '\n'
}



. /opt/tests/shunit2-2.1.7/shunit2
