
:: 002_CentOSの初期設定.md
===

## 1. NETWORKの確認

```
[root@pc ~]# tail /etc/sysconfig/network
NETWORKING=yes
HOSTNAME=pc.mydomain.local
GATEWAY=xxx.xxx.xxx.xxx
NETWORKING_IPV6=no
```

## 2. ファイアーウォールの無効化と不要デーモンの停止

- 社内で使うのでファイアーウォールを無効化する
- 丁寧に構築するのであれば必要なポートだけ空ける様に設定する
- 現状ip6は使っていないのでこれも無効化にする

```
[root@pc ~]# chkconfig ip6tables off
[root@pc ~]# chkconfig iptables off
[root@pc ~]# chkconfig auditd off
[root@pc ~]# chkconfig netfs off
[root@pc ~]# chkconfig udev-post off
[root@pc ~]# chkconfig --del ip6tables
```

## 3. yumレポジトリ変更

epelベースに変更かな

```
TODO
```

## 4. yumの最新化

リポジトリから最新のアップデートを取得

```
[root@pc ~]# yum clean all
[root@pc ~]# yum -y update
[root@pc ~]# yum -y upgrade
```

## 5. 管理ユーザー作成

rootのままだとあれなので、sudoers を追加。

```
TODO
```

## 6. SELinux無効化

SElinux設定ファイル編集します(/etc/sysconfig/selinux にシンボリックリンクがはられている)。

```
[root@pc ~]#cp /etc/selinux/config /etc/selinux/config.dist
[root@pc ~]#vi /etc/selinux/config
SELINUX=enforcing → SELINUX=disabled へ変更
```

## 7. 起動時のSELinux無効化

起動オプションの変更。

```
[root@pc ~]#cp /boot/grub/grub.conf /boot/grub/grub.conf.dist
[root@pc ~]#vi /boot/grub/grub.conf

各kernel行の最後に空白を空けて、 selinux=0 を追加

注意:
インストール直後は1行しかないがアップデートによりkernelが追加されている場合は複数行を修整する。
現行をアップデートしておけば以降kernelが追加されても同一オプションがコピーされる。
```

## 8. IPV6無効化

```
[root@pc ~]#cp /etc/sysconfig/network /etc/sysconfig/network.dist
[root@pc ~]#echo NETWORKING_IPV6=no>>/etc/sysconfig/network
[root@pc ~]#cp /etc/modprobe.d/ipv6disabled.conf /etc/modprobe.d/ipv6disabled.conf.dist
[root@pc ~]#echo options ipv6 disable=1>/etc/modprobe.d/ipv6disabled.conf
```

# 9. 再起動して反映

```
[root@pc ~]#reboot
```

# 10. 標準ツール類のインストール

yumで必要最低限のツールをインストールする

```
yum -y groupinstall "Development Tools"
yum -y install tmpwatch mailx tree wget
```
