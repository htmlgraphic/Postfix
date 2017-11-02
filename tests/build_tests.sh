#!/usr/bin/env bash

curl -L "https://shunit2.googlecode.com/files/shunit2-2.1.6.tgz" | tar zx

	#### Extra breathing room
	echo -e '\n'

testPostfixUsername()
{
	echo 'Testing Postfix username.'
	test=$(/usr/sbin/postconf smtp_sasl_password_maps | grep 'p08tf1X' | wc -l)
	assertEquals $test 1
	echo -e '\n'
}


testPostfixPassword()
{
	echo 'Testing Postfix password.'
	test=$(/usr/sbin/postconf smtp_sasl_password_maps | grep 'p@ssw0Rd' | wc -l)
	assertEquals $test 1
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



. shunit2-2.1.6/src/shunit2
