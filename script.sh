#!/bin/bash
yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils gcc
wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.20.2-1.el7.ngx.src.rpm -q
sudo rpm -i nginx-1.20.2-1.el7.ngx.src.rpm
wget https://github.com/openssl/openssl/archive/refs/heads/OpenSSL_1_1_1-stable.zip -q
unzip -q ./OpenSSL_1_1_1-stable.zip
sudo yum-builddep -y /root/rpmbuild/SPECS/nginx.spec
sudo sed -i "s/--with-debug/--with-openssl=\/home\/vagrant\/openssl-OpenSSL_1_1_1-stable/" /root/rpmbuild/SPECS/nginx.spec
sudo rpmbuild -bb /root/rpmbuild/SPECS/nginx.spec
sudo ls -la /root/rpmbuild/RPMS/x86_64/
sudo yum localinstall -y /root/rpmbuild/RPMS/x86_64/nginx-1.20.2-1.el7.ngx.x86_64.rpm
sudo systemctl start nginx
systemctl status nginx
sudo mkdir /usr/share/nginx/html/repo
sudo cp /root/rpmbuild/RPMS/x86_64/nginx-1.20.2-1.el7.ngx.x86_64.rpm /usr/share/nginx/html/repo/
sudo wget https://downloads.percona.com/downloads/percona-distribution-mysql-ps/percona-distribution-mysql-ps-8.0.28/binary/redhat/7/x86_64/percona-orchestrator-3.2.6-2.el7.x86_64.rpm -O /usr/share/nginx/html/repo/perconaorchestrator-3.2.6-2.el7.x86_64.rpm
ls -la /usr/share/nginx/html/repo/
sudo createrepo /usr/share/nginx/html/repo/
sudo sed -i "s/index  index.html index.htm;/index  index.html index.htm;\n\tautoindex on;/" /etc/nginx/conf.d/default.conf 
sudo nginx -t
sudo nginx -s reload
echo -e "[otus]\nname=otus-linux\nbaseurl=http://localhost/repo\ngpgcheck=0\nenabled=1" | sudo tee /etc/yum.repos.d/otus.repo
yum repolist enabled | grep otus
yum list | grep otus
sudo yum -y install epel-release
sudo yum -y install percona-orchestrator.x86_64