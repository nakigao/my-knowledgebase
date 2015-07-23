#!/usr/bin/env bash
exit 0;

# bashへのproxy設定

$ export FTP_PROXY='ftp://proxy.url.to:portnumber'
$ export HTTP_PROXY='http://proxy.url.to:portnumber'
$ export HTTPS_PROXY='http://proxy.url.to:portnumber'
$ export RSYNC_PROXY='http://proxy.url.to:portnumber'

#... DO SOMETHING ...

$ unset FTP_PROXY
$ unset HTTP_PROXY
$ unset HTTPS_PROXY
$ unset RSYNC_PROXY

#yumへのproxy設定

$ vi /etc/yum.conf

echo 'timeout=300' >> /etc/yum.conf
echo 'proxy=http://proxy.url.to:portnumber' >> /etc/yum.conf


#wgetへのproxy設定

$ vi /etc/wgetrc

+ftp_proxy = ftp://proxy.url.to:portnumber
echo 'http_proxy = http://proxy.url.to:portnumber' >> /etc/wgetrc
echo 'https_proxy = ftp://proxy.url.to:portnumber' >> /etc/wgetrc
echo 'use_proxy = on' >> /etc/wgetrc

#gitへのproxy設定

git config --global http.proxy http://proxy.url.to:portnumber
git config --global https.proxy http://proxy.url.to:portnumber

#rpmへのproxy設定

rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm --httpproxy http://proxy.url.to:portnumber --httpport http://proxy.url.to:portnumber
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm --httpproxy http://proxy.url.to:portnumber --httpport http://proxy.url.to:portnumber
