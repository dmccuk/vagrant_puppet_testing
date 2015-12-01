#!/bin/sh

# Run on VM to bootstrap Jenkins node


wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
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

#    sudo puppet agent --enable
cat > /var/lib/jenkins/.ssh/id_rsa <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEAzKNGnOlHSALNREiOn+QIIqTQn6H5jVlOLCfO1Et0UV8q+s3x
z3oZZegfbWJxfxT2+JiHtSx0fTU/CNF1bsvsizS1Dn+kbI9M3043FNxyD3FD61zJ
Gp4+WB5AyhrW94DMbOSQDlNkdvzfa/17ie0vyDggtAG0kF6Xe38FVfyxYNZgkjiJ
M412r5fTsnXxw1gPlN5WSO/wuKYDXLeoJShKZoN5RjsEW5NjS+XgiBkofz5TWgzu
8spCyclnN5/iI9uQGAzKMafi2Vpb+gb0xDH2kJXaCMJuH2DLVqOXmhjjIqhp6IlZ
xOLIp6pbVsIELgKRwh6zeTSJgytmPHUiLN+rjQIDAQABAoIBAEJ8phujG3rFFkYi
QNyoLRB8dh/3c2o+Ysyr3mJRZahugDteoDsl04ytn1Bd1LxSZm+ctzLhD7QCkcle
rIXkEaWk6VKdnCF9aZ9//Rt1CEYGKegVjG1ujpj4s1o24DMoEMMse7V72L9kJ38h
q3rDqmul+NIjX7QsV5FTUrt+T29DgqI5/w7LjC5DXR4XqAjKfK04N8auZv7yyWjF
7WCdpPzHDV39kT79/5ca+iVGCdifJJJAzJx8V8E067NQsTcpadsghJC2e9sIUqUK
yGGnS8GYYZG108pjXoqPD8Q3T2rcFwrbM6lPDB3Nnu43qcb1/s9A1OVu1JAbSQdg
ldDK/uECgYEA9YJis/aTUDjGMUCin1huykgWnVKyNN06fYaxjiyVsC0UW54q1ocA
KjUF8MZCBOeT/lItOfWa7oOkxHojsbDT+u8RVSUt6JOv/Bh3rzeTIP3dkH0AuYIO
s1J7vJoubZ0EQP9v+aWa6LstHb8foxkh8fuB5Zob8KTGpZNS/iYVoTUCgYEA1WHM
dr32NQOP/GGV4l9Wzd6hEcl6duogXUnlFdENvnfCaFdX517VY5zNGArXFumcx7wg
TociXaUmj3oXzhrrY560T3aBHL9C4wI1UAD69aOZH1VAu08AsFIwH4m1G0oWKRdu
icyB/MrK7DNMJvrvZAs+GW5fzs2vDSpVklexQ/kCgYEA78Q6qQ7yp7IKvScmqwAu
kxb8HwEYUVCNQvI8jWE1fy1HaIJ7y69kldPazV6SM0AG5KVUzfnzKWUfkVLHcU4E
eFjqUIFS6ITzpfwvRsu7wMitjeLGxmUh/jdb6MGa/ioOcXwF24XEV+4VDawONbbh
0/WQ0q9DAi2qYyISN2ryTNECgYEAkuSsmOHU6FH3gUq8oAX5/+dPAqusvsgWV6JT
Ll2oFILlNmdKgGDsjZKYLgDoaUGRSH7dzrGAmu7iSMtIL/6gJQhQIJP39g5EwXn3
sYe7O/bPpp5N3aRZWQh7UHrATnUGJGuZEQvUQG5qm4gE2KDOxBRpP6CYHAnEhE+s
cP4lbiECgYEAxz28Ri3ONcvkSad/ODp4hI/51eAyhyruV8X6eJH1M1b8P32w6SBu
NOqDbEvmKoO6BX8CsRHI7Fb3RWmffv3BgU/ibjfwP+oN084K4Tx9kmb2Mpi2Ho3l
lPQ0/jYS2+RUTlP3ZVpDeMobyoE+UA+TSID2qSM+R+xd2oyQhc/fvf4=
-----END RSA PRIVATE KEY-----
EOF

cat > /var/lib/jenkins/.ssh/id_rsa.pub <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMo0ac6UdIAs1ESI6f5AgipNCfofmNWU4sJ87US3RRXyr6zfHPehll6B9tYnF/FPb4mIe1LHR9NT8I0XVuy+yLNLUOf6Rsj0zfTjcU3HIPcUPrXMkanj5YHkDKGtb3gMxs5JAOU2R2/N9r/XuJ7S/IOCC0AbSQXpd7fwVV/LFg1mCSOIkzjXavl9OydfHDWA+U3lZI7/C4pgNct6glKEpmg3lGOwRbk2NL5eCIGSh/PlNaDO7yykLJyWc3n+Ij25AYDMoxp+LZWlv6BvTEMfaQldoIwm4fYMtWo5eaGOMiqGnoiVnE4sinqltWwgQuApHCHrN5NImDK2Y8dSIs36uN jenkins@jenkins
EOF

#export JENKINS_HOME=`grep jenkins /etc/passwd | awk -F: '{print $6}'`
#cd $JENKINS_HOME/plugins
#curl -O http://updates.jenkins-ci.org/download/plugins/git
#curl http://jenkins.example.com:8080/reload
