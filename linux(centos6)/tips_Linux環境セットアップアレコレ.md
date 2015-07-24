
:: Linux_環境セットアップ
===

# 1. サーバーを落とすコマンド

```
# poweroff
```

または

```
# sync ... 10s待つ
# sync ... 10s待つ
# halt
```

# 2. ディスク構成に関して

```
tmpfs ... /dev/shm
```

これは、on-memory領域のこと。メモリの最大要領によって自動的に変更される

# 3. tty

## 3-1. ttyとはなんぞや

Linux

標準出力するための仮想コンソールのこと

SSH接続したときなどは、ttyを用いて標準出力に出力を行っている

## 3-2. ttyの設定を調整した理由

仮想コンソールに関するメモリ対策で、ttyは常駐するので無駄にメモリが使われる

# 4. TIPS

## 4-1. SWAPPING防止でon-memory領域を使うこと

on-memory領域を大きく取り、そこにSQLite3の保存領域などを保持することで、物理ディスク(HDD/SSD)へのアクセスを少なくさせる。

当然、on-memory領域は電源のOFF時に消滅するので、shutdown前か、cronなどで定期的に保存する仕組みをおいておく必要がある

## 4-2. OS起動時のnetwork設定確認

ifconfigでネットワークインターフェイスを確認すること

確認点1: OS起動時にSETUPしたアドレスがeth0に渡っているかどうか

# 5. 設定ファイル一覧

```
/boot/grub/grub.conf
/etc/yum.repos.d/CentOS-Base.repo
/etc/seliunx/config
/etc/sysconfig/init
/etc/ntp.conf
/etc/snmp/snmpd.conf
/etc/postfix/main.cf
```

# 6. バックアップ規則

```
original.conf -> original.conf.dist

$ cp -p foo.txt{,.dist}
$ cp -p foo.txt{,.`date +%Y%m%d`}
```
