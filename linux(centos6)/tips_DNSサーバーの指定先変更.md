
:: DNSサーバーの指定先変更.md
===

DNSサーバーのIPが変更された場合は、以下の方法でDNSサーバーの指定を変更する

STEP1: DNS設定変更

```
[root@pc ~]# vi /etc/resolv.conf
※変更されたDNSのIPを変更する
```
STEP2: ゲートウェイ設定変更

```
[root@pc ~]# vi /etc/sysconfig/network-scripts/ifcfg-eth0
※変更されたDNSのIPを変更する
```

最後にネットワークの再起動

```
[root@pc ~]# service network restart
```
