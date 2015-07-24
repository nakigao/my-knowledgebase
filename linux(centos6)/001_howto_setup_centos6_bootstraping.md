
:: 仮想マシンの設定からSSHの接続確認まで
===

仮想マシンの設定からSSHの接続確認まで

## 1. network設定

```
自動接続設定
  チェックON
HOST
  {HOST_NAME}.mydomain.local
手動
  XXX.XXX.XXX.XXX/255.255.255.0/XXX.XXX.XXX.1
DNS
  XXX.XXX.XXX.XXX,XXX.XXX.XXX.XXX
DOMAIN
  mydomain.local
```

## 2. rootパスワード

```
UID: root
PWD: {6文字以上のパスワード}
```

## 3. ストレージデバイスのカスタムパーティション設定

```
/dev/sda1   /boot   512MB
/dev/sda2   swap    1GB
/dev/sda3   /       残り
```

## 4. 再起動

初期化完了後に再起動
