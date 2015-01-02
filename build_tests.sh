#!/usr/bin/env bash

curl -L "https://shunit2.googlecode.com/files/shunit2-2.1.6.tgz" | tar zx

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
    echo 'Allow 54.225.164.191 this network to send email.'
    test=$(/usr/sbin/postconf mynetworks | grep '54.225.164.191' | wc -l)
    assertEquals $test 1
    echo -e '\n'
}

testPostfixMyNetworks2()
{
    echo 'Allow 104.236.0.0/18 this network to send email.'
    test=$(/usr/sbin/postconf mynetworks | grep '104.236.0.0/18' | wc -l)
    assertEquals $test 1
    echo -e '\n'
}

testPostfixMyNetworks3()
{
    echo 'Allow 10.132.0.0/16 this network to send email.'
    test=$(/usr/sbin/postconf mynetworks | grep '10.132.0.0/16' | wc -l)
    assertEquals $test 1
    echo -e '\n'
}

testPostfixMyNetworks4()
{
    echo 'Allow 50.28.0.151 this network to send email.'
    test=$(/usr/sbin/postconf mynetworks | grep '50.28.0.151' | wc -l)
    assertEquals $test 1
    echo -e '\n'
}



. shunit2-2.1.6/src/shunit2