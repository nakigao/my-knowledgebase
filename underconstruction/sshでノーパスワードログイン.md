
:: sshでノーパスワードログイン
=====

シェルでsshを打つときなど。

sample)
ローカル: user@localhost
リモート: root@xxx.xxx.xxx.xxx

# ローカル側

パスフレーズをなくすために、全てエンターでOK

## 1. 秘密鍵+公開鍵を生成

```
$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/user/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/user/.ssh/id_rsa.
Your public key has been saved in /home/user/.ssh/id_rsa.pub.
The key fingerprint is:
c3:ae:2c:8a:b7:9d:0c:d4:9d:c3:42:67:a1:64:32:2e user@pc
The key's randomart image is:
+---[RSA 2048]----+
|  o o .          |
| . = . .         |
|E . o o          |
| . o = o         |
|  . o = S        |
| .   . o .       |
|  .     .        |
| ..+.o .         |
|..oo+.o          |
+-----------------+
```

## 2. 公開鍵をリモートサーバーへ転送

```
$ ssh-copy-id -i ~/.ssh/id_rsa.pub root@xxx.xxx.xxx.xxx
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
root@xxx.xxx.xxx.xxx's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'root@xxx.xxx.xxx.xxx'"
and check to make sure that only the key(s) you wanted were added.
```

## 3. SSHで接続

```
$ ssh root@xxx.xxx.xxx.xxx
Last login: Tue Feb 24 16:35:07 2015 from xxx.xxx.xxx.xxx
[root@pc ~]#
```

# トラブルシューティング

## WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!

サーバーを立て直したり(IPやHOSTNAMEは流用)、NICを差し替えたりするとこういう警告がでる。

(または本当にセキュリティエラーの可能性があるので要注意)

クライアント側で以下のコマンドを実行した後、再び認証を行うことで解決できる。

```
※この例では「xxx.xxx.xxx.xxx」で動いていたテストサーバーを破棄して別のサーバーを新規に立てた場合に発生していた

[user@pc /cygdrive/c/Users/user]$ ssh-keygen -R xxx.xxx.xxx.xxx
# Host xxx.xxx.xxx.xxx found: line 68
/home/user/.ssh/known_hosts updated.
Original contents retained as /home/user/.ssh/known_hosts.old

[user@pc /cygdrive/c/Users/user]$ ssh-copy-id -i ~/.ssh/id_rsa.pub root@xxx.xxx.xxx.xxx
```

再び認証する際に、以下のコマンドを実行してリモートサーバーが本当に正しいのか確認する

```
[root@pc ~]# ssh-keygen -lf /etc/ssh/ssh_host_rsa_key.pub
```


