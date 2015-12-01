#!/bin/bash

# test that PUPPET-MASTER was installed
vagrant ssh puppet.example.com -c 'sudo service puppetmaster status' 
vagrant ssh puppet.example.com -c 'sudo service puppetmaster stop'
vagrant ssh puppet.example.com -c 'sudo puppet master --verbose --no-daemonize'
# Ctrl+C to kill puppet master
vagrant ssh puppet.example.com -c 'sudo service puppetmaster start'
# Check for 'puppet' cert
vagrant ssh puppet.example.com -c 'sudo puppet cert list --all'

# On the PUPPET-NODES:
# test that agent was installed
vagrant ssh node01.example.com -c 'sudo service puppet status'
vagrant ssh node02.example.com -c 'sudo service puppet status'
vagrant ssh jenkins.example.com -c 'sudo service puppet status'
# initiate certificate signing request (CSR)
vagrant ssh node01.example.com -c 'sudo puppet agent --test --waitforcert=60'; sudo vagrant ssh puppet.example.com -c 'sudo puppet cert sign --all' 
vagrant ssh node02.example.com -c 'sudo puppet agent --test --waitforcert=60'; sudo vagrant ssh puppet.example.com -c 'sudo puppet cert sign --all'
vagrant ssh jenkins.example.com -c 'sudo puppet agent --test --waitforcert=60'; sudo vagrant ssh puppet.example.com -c 'sudo puppet cert sign --all'

sleep 5
# Back on the PUPPET-MASTER:
vagrant ssh puppet.example.com -c 'sudo puppet cert list' # should see 'node01.example.com' cert waiting for signature
vagrant ssh puppet.example.com -c 'sudo puppet cert sign --all' # sign the agent node certs
vagrant ssh puppet.example.com -c 'sudo puppet cert list --all' # check for signed certs

