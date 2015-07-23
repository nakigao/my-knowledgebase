
:: Linux_gitlab
===

# 1. 参考にしたもの

[https://about.gitlab.com/downloads/]https://about.gitlab.com/downloads/
[http://d.hatena.ne.jp/toritori0318/20140523/1400863038]http://d.hatena.ne.jp/toritori0318/20140523/1400863038

# 2. パーミッションに関して

`/var` がデフォルト保存先になっているみたいなので、ここの領域を大きく確保する

# 3. GitLabにrootログインするまで

## 3-1. 必要なライブラリのセットアップ

```
sudo yum install openssh-server
sudo yum install postfix
sudo yum install cronie
sudo service postfix start
sudo chkconfig postfix on
```

## 3-2. rpmのダウンロード

```
curl -O https://downloads-packages.s3.amazonaws.com/centos-6.6/gitlab-7.7.1_omnibus.5.4.1.ci-1.el6.x86_64.rpm
    ※Windows環境でRPMをダウンロードして、SCPでコピーしてもいい
```

## 3-3. rpmでのインストール

```
[root@pc ~]# rpm -ivh gitlab-7.7.1_omnibus.5.4.1.ci-1.el6.x86_64.rpm
Thank you for installing GitLab!
Configure and start GitLab by running the following command:

sudo gitlab-ctl reconfigure

GitLab should be reachable at http://pc.domain.local
Otherwise configure GitLab for your system by editing /etc/gitlab/gitlab.rb file
And running reconfigure again.
```

## 3-4. 設定ファイルの編集

```
# vi /etc/gitlab/gitlab.rb
```

## 3-5. Configure and start GitLab

```
sudo gitlab-ctl reconfigure
sudo lokkit -s http -s ssh
    ※これはなぜか走らなかった・・・ipv6tablesを設定でfalseにしていたからかなぁ
```

## 3-6. Browse to the hostname and login

```
アクセス：
http://gitlab.url.to/

初期rootユーザー:
Username: root
Password: xxxxxxxxxxxxxxx
```

## 3-7. パスワード変更

```
Username: root
Password: xxxxxxxxxxxxxxx
```

# 4. 初期設定の修正

保存先とか修正する場合は、GitLabの設定ファイルを編集。
非推奨のばっかりなんだよねぇ・・・

# 5. ユーザーの追加

適当にSignInするだけ

# 6. リポジトリの追加(rootで作成する場合)

```
project path:
xxxxxxxxxx

namespace:
Administrator

visibility level:
internal
```

# 7. プロジェクトへのユーザーの追加(プロジェクトマスターがやる)

プロジェクト > edit > teamタブ選択 > new project member
