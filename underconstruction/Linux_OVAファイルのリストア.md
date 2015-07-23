
:: Linux_OVAファイルのリストア.md
===

```
※注意: 
OVFテンプレートをエクスポートする際は、ドライブのデバイスタイプを「クライアントデバイス」に変更のこと
ISOが指定されたままだと、エクスポートは成功しても、インポート時点で必ず失敗する
```

サーバーのフルバックアップを新しいマシンに適応する方法について

vSphere > ファイル > OVFテンプレートのデプロイ ... 選択

デプロイダイアログ ... 以下の入力になるように設定

```
OVFファイル: リストアしたいOVA(OVF)ファイル
ダウンロードサイズ: ※適当に
ディスク上のサイズ: ※適当に
名前: リストアする仮想PCの名称
ホスト/クラスタ: ※適当に
ディスク プロビジョニング: シック プロビジョニング(Lazy Zeroed)
ネットワークのマッピング: 「※OVFファイルを取ったときのネットワーク」～「※新しくリストアする先のネットワーク」
```

# 1. ブート後の最適化

## 1-1. `/etc/udev/rules.d/70-persistent-net.rules`

`ATTR{address}` 部分を新しいNICのMACに変更する

```
[root@pc ~]# vi /etc/udev/rules.d/70-persistent-net.rules
SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="XX:XX:XX:XX:XX:XX", ATTR{type}=="1", KERNEL=="eth*", NAME="eth0"
```

## 1-2. `/etc/sysconfig/network-script/ifcfg-eth0`

以下の項目を適宜変更する

- IPADDR
- GATEWAY
- HWADDR

```
[root@pc ~]# vi /etc/sysconfig/network-script/ifcfg-eth0
DEVICE=eth0
TYPE=Ethernet
UUID=4cb8fc58-088d-47a8-961f-d4a4bc4771ad
ONBOOT=yes
NM_CONTROLLED=yes
BOOTPROTO=none
IPADDR=XXX.XXX.XXX.XXX
PREFIX=24
GATEWAY=XXX.XXX.XXX.XXX
DNS1=XXX.XXX.XXX.XXX
DOMAIN=mydomain.local
DEFROUTE=yes
IPV4_FAILURE_FATAL=yes
IPV6INIT=no
NAME="System eth0"
HWADDR=XX:XX:XX:XX:XX:XX
```

## 1-3. `/etc/hosts`

一番上の項目を適宜変更

```
[root@pc ~]# vi /etc/hosts
XXX.XXX.XXX.XXX  xxxxxxxxxx.mydomain.local xxxxxxxxxx
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
```

## 1-4. `/etc/sysconfig/network`

以下の項目を変更

- HOSTNAME
- GATEWAY

```
[root@pc ~]# vi /etc/sysconfig/network
NETWORKING=yes
HOSTNAME=xxxxxxxxxx.mydomain.local
GATEWAY=XXX.XXX.XXX.XXX
NETWORKING_IPV6=no
```

後は `reboot` すればOK
