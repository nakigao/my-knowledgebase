
:: PHPの設定
===

# 1. 標準インストール

```
[root@pc ~]#yum install -y php php-cli php-common php-gd php-mbstring php-mysql php-pdo
```

# 2. インストールパッケージ確認

```
[root@pc ~]# rpm -qa | grep php
php-pdo-5.3.3-40.el6_6.x86_64
php-gd-5.3.3-40.el6_6.x86_64
php-mysql-5.3.3-40.el6_6.x86_64
php-common-5.3.3-40.el6_6.x86_64
php-cli-5.3.3-40.el6_6.x86_64
php-5.3.3-40.el6_6.x86_64
php-mbstring-5.3.3-40.el6_6.x86_64
[root@pc ~]# php -v
PHP 5.3.3 (cli) (built: Oct 30 2014 20:12:53)
Copyright (c) 1997-2010 The PHP Group
Zend Engine v2.3.0, Copyright (c) 1998-2010 Zend Technologies0
```

# 3. php.iniの設定

```
[root@pc ~]#cp /etc/php.ini /etc/php.ini.dist
[root@pc ~]#vi /etc/php.ini
```

※アプリケーション側でやってるから、無設定でも大丈夫かも

