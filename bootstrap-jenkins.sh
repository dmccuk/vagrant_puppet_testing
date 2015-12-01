#!/bin/sh

# Run on VM to bootstrap Jenkins node


wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
#sudo apt-get update
sudo apt-get install --force-yes -y jenkins ruby ruby-dev rake git
 
sudo gem install  --no-rdoc --no-ri puppet-lint
sudo gem install  --no-rdoc --no-ri puppet-parse
sudo gem install  --no-rdoc --no-ri ci_reporter
sudo gem install  --no-rdoc --no-ri rspec-puppet-utils
sudo gem install  --no-rdoc --no-ri puppetlabs_spec_helper
sudo service jenkins start

    # Configure /etc/hosts file
    echo "" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "# Host config for Puppet Master, Agent Nodes and Jenkins" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.5    puppet.example.com  puppet" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.10   node01.example.com  node01" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.20   node02.example.com  node02" | sudo tee --append /etc/hosts 2> /dev/null && \
    echo "192.168.32.30   jenkins.example.com  jenkins" | sudo tee --append /etc/hosts 2> /dev/null


    # Add agent section to /etc/puppet/puppet.conf
    echo "" && echo "[agent]\nserver=puppet" | sudo tee --append /etc/puppet/puppet.conf 2> /dev/null

    sudo puppet agent --enable
