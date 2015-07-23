:: chef-zero_tutorial_at_windows7
===

暇な時間を利用しまして・・・。

[Learn Chef](https://learn.chef.io/)

## Chef Development kit の導入

[Chef Development Kit | Chef Downloads | Chef](https://downloads.chef.io/chef-dk/windows/#/)

266MBもある・・

適当にインストールする(全部OKで問題なし)

`powershell.exe` を実行して、以下のコマンドで確認

```
PS C:\Users\user> chef -v
Chef Development Kit Version: 0.6.2
chef-client version: 12.2.1
berks version: 3.2.4
kitchen version: 1.4.0
```

## Chef repository の初期化

```
PS C:\Users\user> chef generate repo chef-repo
```

ディレクトリ構成は以下のようにできあがる

```
[user@pc /cygdrive/c/Users/user/chef-repo]$ tree
.
├── chefignore
├── cookbooks
│   ├── example
│   │   ├── attributes
│   │   │   └── default.rb
│   │   ├── metadata.rb
│   │   └── recipes
│   │       └── default.rb
│   └── README.md
├── data_bags
│   ├── example
│   │   └── example_item.json
│   └── README.md
├── environments
│   ├── example.json
│   └── README.md
├── LICENSE
├── README.md
└── roles
    ├── example.json
    └── README.md
```

## knife-zero のインストール

gemのインストール

```
PS C:\Users\user\chef-repo> chef gem install knife-zero
```

設定ファイルをknife-zero用に最適化

```
vi .chef/knife.rb

※以下の設定追加

local_mode true

chef_repo_dir = File.absolute_path( File.dirname(__FILE__) + "/.." )
cookbook_path ["#{chef_repo_dir}/cookbooks"]
node_path     "#{chef_repo_dir}/nodes"
role_path     "#{chef_repo_dir}/roles"
ssl_verify_mode  :verify_peer
```

## knife-zero の初回実行(Nodeの登録とNodeへのchef-clientのインストール)

最初にGEST(Node)側のwgetのproxyを設定しておくこと

```
vi /etc/wgetrc

以下を追加

http_proxy = http://${USER}:${PASSWORD}@${PROXY_HOST}:${PROXY_PORT}/
https_proxy = http://${USER}:${PASSWORD}@${PROXY_HOST}:${PROXY_PORT}/
``

HOST(Server)でコマンド実行

```
PS C:\Users\user\chef-repo> chef exec knife zero bootstrap 10.1.73.52 -x root -P root -N 10.1.73.52
```

GEST(Node)側で確認

```
$ chef-client -v
Chef: 12.4.1
$ knife -v
Chef: 12.4.1
```

HOST(Server)側で確認

```
PS C:\Users\user\chef-repo> chef exec knife search node --local-mode
1 items found

Node Name:   10.1.73.52
Environment: _default
FQDN:
IP:          10.1.73.52
Run List:
Roles:
Recipes:
Platform:    centos 6.6
Tags:
```

## recipe 追加のサンプル(自前で作ったもの)

例えば、apacheのレシピを追加する場合

```
PS C:\Users\user\chef-repo> chef exec knife cookbook create apache
```

生成された雛形に設定を追記

```
vi C:\Users\user\chef-repo\cookbooks\apache\recipes\default.rb

以下を追加

package "httpd" do
  action :install
end

service "httpd" do
  action [ :enable, :start ]
end
```

設定を適応

```
PS C:\Users\user\chef-repo> chef exec knife zero bootstrap 10.1.73.52 -x root -P root -N 10.1.73.52 -r 'recipe[apache]'
```
