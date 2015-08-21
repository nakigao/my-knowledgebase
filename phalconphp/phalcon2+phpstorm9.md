:: phalcon2+phpstorm9.md
===

暇です。

Phalcon2 の空プロジェクトを PhpStorm9 でセットアップしたい

開発環境

- Php with Phalcon2
- PhpStorm9
- composer

## Composerで空プロジェクト作成

依存関係の処理は全部Composerに任せたい

PhpStormのIDE上でcomposer initまでやっちゃう

## phalcon-devtoolsをインストール

PhpStormのTerminalでやってもいいんだけど、Cygwin環境と競合することがあるので、Cygwinでやる

Cygwinのカレントディレクトリをプロジェクトのルートにする

`composer.json` を以下のようにする

```
{
  "name": "vendor_name/package_name",
  "description": "description_text",
  "minimum-stability": "stable",
  "license": "proprietary",
  "authors": [
    {
      "name": "author's name",
      "email": "email@example.com"
    }
  ],
  "require": {
    "phalcon/devtools": "v2.0.7"
  }
}
```

※Proxy環境下なので、追加で以下の設定を行う

```
set HTTP_PROXY_REQUEST_FULLURI=
set HTTPS_PROXY_REQUEST_FULLURI=
set http_proxy=http://url.to.proxy:99999
set https_proxy=
```

Composer経由でのインストール

```
/cygdrive/c/5.5.26/php.exe /cygdrive/c/php/5.5.26/composer.phar install
```

エラーがでなければOK

## プロジェクト雛形を生成

プロジェクト名は「todo」

```
/cygdrive/c/php/5.5.26/php.exe vendor/phalcon/devtools/phalcon.php create-project todo
```

これで以下のフォルダ構成が出来上がる

```
$ tree
.
├── composer.json
├── composer.lock
├── todo
│   ├── app
│   │   ├── cache
│   │   ├── config
│   │   │   ├── config.php
│   │   │   ├── loader.php
│   │   │   └── services.php
│   │   ├── controllers
│   │   │   ├── ControllerBase.php
│   │   │   └── IndexController.php
│   │   ├── migrations
│   │   ├── models
│   │   └── views
│   │       ├── index
│   │       │   └── index.volt
│   │       ├── index.volt
│   │       └── layouts
│   ├── index.html
│   └── public
│       ├── css
│       ├── files
│       ├── img
│       ├── index.php
│       ├── js
│       └── temp
└── vendor(省略)
```

## ファイルタイプの追加

Phalconのデフォルトであるvoltテンプレートが、Phpstormだと認識されない

In PHPStorm, click File->Settings

On the left side of the options click File Types

On the list that appears on the right, scroll down and select Twig

In the bottom panel, click the + button to add a new wildcard and add

*.volt

※とはいえ・・voltの構文がAngularとバッティングするらしいので、voltはあんまりつかわない作戦でいこう

## Vagrant? 今の僕には理解できないので、サクッとXAMPP環境をセットアップ

PHPのversionは5.5で

Phalconの環境をセットアップする

Phalcon 2.0.7 - Windows x86 for PHP 5.5.0 (vc11)

このDLLを `C:\xampp\php\ext` に配置

`C:\xampp\php\php.ini` に `extension=php_phalcon.dll` の一文を追加

XAMPP > APACHE 再起動

`http://localhost/dashboard/phpinfo.php` にアクセスして、phalconで検索して、出てきてればセットアップOK

## 作成されたフォルダを適当にデプロイ

XAMPP > APACHE のデフォルト公開フォルダは `C:\xampp\htdocs` なのでここに先ほどのプロジェクト群をデプロイするっと・・・

`http://localhost/todo/` にアクセスして確認
