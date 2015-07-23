
:: Windows_Cygwinセットアップ.md
===

WindowsでLinuxマシンと通信するために・・・

# 1. インストール

[Cygwin](https://www.cygwin.com/)

# 2. オススメパッケージ

```
yum -y install ssh rsync tree chere
```

# 3. Tips

## 3-1. 右クリックコンテキストメニューに「Bash prompt here」を追加

```
※Cygwinを管理者権限で実行

$ chere -i -f -t mintty
```

## 3-2. cmd.exeでいうところの「open .」をする方法

```
$ cygstart .
```

## 3-3. コピペのショートカット

```
Shift + Insert
```

