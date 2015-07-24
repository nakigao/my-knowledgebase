
:: ntp設定
===

サーバー間のtimestampをそろえるために、社内NTPサーバーを登録。

# 1. NTPサーバーの追加

```
[root@pc ~]#yum install -y ntp
[root@pc ~]#cp /etc/ntp.conf /etc/ntp.conf.dist
[root@pc ~]#vi /etc/ntp.conf

※デフォルトサーバーを削除し、指定したいNTPサーバーを追加

server xxx.xxx.xxx.xxx iburst
```

# 2. ntpd起動・確認・自動起動設定を設定

```
[root@pc ~]#service ntpd start
[root@pc ~]#chkconfig ntpd on
[root@pc ~]#chkconfig ntpdate on
```

tips: CentOS6からは起動時の時刻あわせのためntpdateもONにする

# 3. 設定反映確認

```
[root@pc ~]#ntpq -p
```