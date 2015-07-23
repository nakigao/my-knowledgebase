:: chef-zero_with_berkshelf_at_windows7
===

暇な時間を利用しまして・・・。

[Berkshelf](http://berkshelf.com/)

## Chef Development kit の導入

[Chef Development Kit | Chef Downloads | Chef](https://downloads.chef.io/chef-dk/windows/#/)

266MBもある・・

適当にインストールする(全部OKで問題なし)

`powershell.exe` を実行して、以下のコマンドで確認

```
PS C:\Users\user> berks -v
3.2.4
```

## Berkshelf の初期化

```
PS C:\Users\user> mkdir berks-sample
PS C:\Users\user> cd C:\Users\user\berks-sample
PS C:\Users\user> berks cookbook webserver
```

ディレクトリ構成は以下のようにできあがる(cookbooks/myappの部分)

```
[user@pc /cygdrive/c/Users/user/berks-sample]$ tree
.
└── webserver
    ├── attributes
    ├── files
    │   └── default
    ├── libraries
    ├── providers
    ├── recipes
    ├── resources
    └── templates
        └── default
```

## パッケージと依存関係の定義

```
vi C:\Users\user\berks-sample\webserver\Berksfile

※以下を追記

source "https://supermarket.chef.io"

metadata

cookbook "apache"

cookbook "php"
cookbook "php-redis"

cookbook "nodejs"
```

## パッケージの取得

cookbookの該当設定のディレクトリに移動して

```
cd C:\Users\user\berks-sample\webserver
chef exec berks install
```

`Berksfile.lock` が生成されていればOKです

※実体は、ユーザーのホームディレクトリ `.berkshelf` にありそう

### トラブルシュート1: Windowsで実行した際に、ホスト名が解決できないエラー

プロキシ設定環境ですか？

必要な場合は、以下の2つを環境変数に追加

```
HTTP_PROXY=http://proxy.host.name
HTTPS_PROXY=https://proxy.host.name
```

### トラブルシュート2: Windowsで実行した際に、文字コードに関するエラー

berksにデフォルトエンコーディングの設定を追加。

世界はUTF8ですよ。

```
vi C:\opscode\chefdk\bin\berks

※3行目に以下の設定を追加

Encoding.default_external = 'utf-8'
```

## berks install したgem群を、実際のサーバー(Node)に適応する

`Berkfile` と `metadeta.rb` をcookbooksを適応したいchef-repoにコピーする

```
[user@pc /cygdrive/c/Users/user/chef-berks-repo]$ tree -a -L 1
.
├── .chef
├── Berksfile           ※Add
├── Berksfile.lock      ※Add
├── chefignore
├── cookbooks
├── data_bags
├── environments
├── LICENSE
├── metadata.rb         ※Add
├── README.md
└── roles
```

berks経由でcookbookをインストールする(cookbooksに入っていたものは全てなくなるので注意)

```
PS C:\Users\user\chef-berks-repo> chef exec berks vendor cookbooks
```

## chef-knife への recipe 追加

HOST(Server)側で以下のコマンド

```
PS C:\Users\user\chef-berks-repo> chef exec knife node run_list add 10.1.73.52 '''recipe[apache]'''
```

※一度作成すると `node/10.1.73.52.json` の中に `run_list` の項目が追加されているので、後の設定追加は手動でよろしい

## knife-zero での Node　側の　recipe 更新

HOST(Server)側で以下のコマンド

```
PS C:\Users\user\chef-berks-repo> chef exec knife zero converge 'name:10.1.73.52' -x root -P root --attribute ipaddress
```

しばらく待つと完了する。

### トラブルシュート「なんかtar.gzの取得でこけてるぽいぞ」

```
10.1.73.52 [2015-07-23T22:48:34+09:00] ERROR: undefined method `cheffish' for nil:NilClass
10.1.73.52 [2015-07-23T22:48:34+09:00] FATAL: Chef::Exceptions::ChildConvergeError: Chef run process exited unsuccessfully (exit code 1)
```

んー？

```
10.1.73.52 [2015-07-23T23:41:49+09:00] ERROR: remote_file[/var/chef/cache/phpredis.tar.gz] (php-redis::default line 1) had an error: SocketError: Error connecting to https://github.com/nicolasff/phpredis/archive/master.tar.gz - getaddrinfo: No address associated with hostname
DEBUG: received packet nr 1723 type 94 len 156
INFO: channel_data: 0 127b
10.1.73.52 [2015-07-23T23:41:49+09:00] FATAL: Chef::Exceptions::ChildConvergeError: Chef run process exited unsuccessfully (exit code 1)
```

どうもProxy周りみたい。

NODE(GUEST)側でproxyの設定を追加する

```
vi /etc/chef/client.rb

https_proxy "http://proxy.url.to"
```










※※※　ここから難い・・・・ロールで適応する方法がついぞわからなかった　※※※










ロールの設定を追加

```

knife cookbook create roles

[chef-soloのレシピのカスタマイズの記録 | DEVLAB](http://devlab.isao.co.jp/chef-solo_custom-recipe/)

PS C:\Users\user\chef-berks-repo> chef exec knife role create webserver

以下を追加

{
  "name": "webserver",
  "description": "",
  "json_class": "Chef::Role",
  "default_attributes": {

  },
  "override_attributes": {

  },
  "chef_type": "role",
  "run_list": [
    "recipe[apache]",
    "recipe[php]"
  ],
  "env_run_lists": {

  }
}
```

Nodeへのロール追加

```

PS C:\Users\user\chef-berks-repo>

chef exec knife node run_list add 10.1.73.52 'role[webserver]'

chef exec knife zero bootstrap 10.1.73.52 -x root -P root -N 10.1.73.52

chef exec knife zero converge 'name:10.1.73.52' -x root -P root -a ipaddress

```

ERROR: Error connecting to https://github.com/nicolasff/phpredis/archive/master.tar.gz, retry 1/5