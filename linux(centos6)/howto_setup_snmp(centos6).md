
:: SNMPの設定
===

snmpdはsnmpget等の問い合わせに応答してサーバの状態を返すSNMPの常駐プログラムです。

サーバにsnmpdの設定を予め投入しておく事によって、統合監視ツールからの問い合わせに対して応答を返せるようになります。

# 1. snmpdインストール

```
[root@pc ~]#yum install -y net-snmp net-snmp-utils
```

# 2. snmpd設定

`/etc/snmp/snmpd.conf`を編集する

```
[root@pc ~]#cp /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.dist
[root@pc ~]#vi /etc/snmp/snmpd.conf
```

## 2-1. com2secの設定

基本的には全サーバー共通

```
#       sec.name  source          community
#com2sec notConfigUser  default       public
com2sec local localhost private
com2sec mynetwork xxx.xxx.xxx.0/24 yyyyyyyyyy
```

## 2-2. groupの設定

基本的には全サーバー共通

```
#group   notConfigGroup v1           notConfigUser
#group   notConfigGroup v2c           notConfigUser
group   MyROGroup       v1      mynetwork
group   MyROGroup       v2c     mynetwork
group   LocalGroup      v1      local
group   LocalGroup      v2c     local
```

## 2-3. viewの設定

基本的には全サーバー共通

```
#view    systemview    included   .1.3.6.1.2.1.1
#view    systemview    included   .1.3.6.1.2.1.25.1.1
view    all     included        .1      80
```

## 2-4. accessの設定

基本的には全サーバー共通

```
#access  notConfigGroup ""      any       noauth    exact  systemview none none
access MyROGroup       ""      any     noauth  exact   all     none    none
access LocalGroup      ""      any     noauth exact    all     none    none
```

## 2-5. diskの設定

サーバーのパーティションによって監視対象ディレクトリを設定し直す必要がある

変更例(/, /boot, /var, /homeの場合)

```
disk / 10000
disk /boot 10000
disk /var 10000
disk /home 10000
```

# 3. snmpd起動・確認・自動起動設定を設定

```
[root@pc ~]#service snmpd start
[root@pc ~]#chkconfig snmpd on
[root@pc ~]#snmpwalk -v 2c -c yyyyyyyyyy xxx.xxx.xxx.xxx

※ログが出ればOK?
```
