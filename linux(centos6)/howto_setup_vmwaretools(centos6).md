
:: VMWare Toolsのセットアップ
===

# 1. そもそもこれは何

VMWareのHOSTSERVER側で、起動/停止を自動化するために必要なユーティリティツール

# 2. VMwareTools インストール(VMwareゲストOSの時)

## 2-1. TeratermでSSH接続

## 2-2. rootでログイン

## 2-3. rootのホームディレクトリに移動

## 2-4. VMWare Clientのコンソールを開く

- メニュー > 仮想マシン > ゲスト > vmware toolsのインストール・アップデート
- ※実際には仮想CDにvmware-toolsの入っているISOがセットされる

## 2-5. 仮想CDをマウント

```
# mount /dev/cdrom /media/
```

## 2-6. /media/の中を確認して解凍

```
# ls /media/
# tar xzvf /media/VMwareTools-9.0.5-1065307.tar.gz
```

## 2-7. 解凍されたディレクトリに移動し、インストール用のperlスクリプトを実行

```
# ls
# cd vmware-tools-distrib/ (解凍されて出来たディレクトリ)
# ./vmware-install.pl (インストール用perlスクリプト)
```

## 2-8. 全てにENTER押下

確認や選択・指定のプロンプトがでてくるが全てデフォルトのままで進めればインストールが終了

# 3. VMWareのトラブルシューティング

## 3-1. Kernelを上げてvmware-toolsが動かなくなりました

以下を実行すること。

```
# vmware-config-tools.pl
```
