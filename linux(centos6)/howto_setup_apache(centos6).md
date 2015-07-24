
:: 008_Apacheの設定.md
===

# 1. 標準インストール

PHPがインストールされていれば、勝手に入る

# 2. httpd.conf設定

```
[root@pc ~]# cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.dist
[root@pc ~]# vi /etc/httpd/conf/httpd.conf

~中略~
ServerAdmin xxxxxxxxxxxxxxxx@mail.mydomain.com
~中略~
AddLanguage ja .ja ... を先頭に
~中略~
LanguagePriority ja en ca cs da de el eo es et fr he hr it ko ltz nl nn no pl pt pt-BR ru sv zh-CN zh-TW
~中略~
AddDefaultCharset Off
~省略~
```

# 3. 再起動

```
[root@pc ~]# service httpd restart
```

# 4. WEBブラウザでアクセス

[http://{DNS_NAME}/]http://{DNS_NAME}/

Apacheのテストページが出ればOK
