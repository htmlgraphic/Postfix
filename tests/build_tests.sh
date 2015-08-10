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
	echo 'Allow 172.17.0.0/18 to send email.'
	test=$(/usr/sbin/postconf mynetworks | grep '172.17.0.0/18' | wc -l)
	assertEquals $test 1
	echo -e '\n'
}

testPostfixMyNetworks2()
{
	echo 'Allow 50.28.0.151 to send email.'
	test=$(/usr/sbin/postconf mynetworks | grep '50.28.0.151' | wc -l)
	assertEquals $test 1
	echo -e '\n'
}

testPostfixMyNetworks3()
{
	echo 'Allow 54.225.164.19 to send email.'
	test=$(/usr/sbin/postconf mynetworks | grep '54.225.164.191' | wc -l)
	assertEquals $test 1
	echo -e '\n'
}

testPostfixMyNetworks4()
{
	echo 'Allow 104.236.40.133 to send email.'
	test=$(/usr/sbin/postconf mynetworks | grep '104.236.40.133' | wc -l)
	assertEquals $test 1
	echo -e '\n'
}

testPostfixMyNetworks5()
{
	echo 'Allow 107.170.0.0/18 to send email.'
	test=$(/usr/sbin/postconf mynetworks | grep '107.170.0.0/18' | wc -l)
	assertEquals $test 1
	echo -e '\n'
}

testPostfixMyNetworks6()
{
	echo 'Allow 10.7.0.0/16 to send email.'
	test=$(/usr/sbin/postconf mynetworks | grep '10.7.0.0/16' | wc -l)
	assertEquals $test 1
	echo -e '\n'
}

testPostfixMyNetworks6()
{
	echo 'Allow 67.53.191.246 to send email.'
	test=$(/usr/sbin/postconf mynetworks | grep '67.53.191.246' | wc -l)
	assertEquals $test 1
	echo -e '\n'
}



. shunit2-2.1.6/src/shunit2
