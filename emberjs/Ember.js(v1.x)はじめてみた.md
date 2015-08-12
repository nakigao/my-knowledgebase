Ember.js(v1.x)はじめてみた.md
===

[Ember.js - A framework for creating ambitious web applications.](http://emberjs.com/)

暇ではないけど、暇なので...

## はじめに

React.js? Angular.js?

だめだね！__IE8__がサポートされないからね！

Backbone.js?

双方向バインディングとかあるのかね？ライブラリがたくさん必要？めんどくさいね！

Ember.js?

イイネ！モダンな設計思想だし、Github Starもいっぱいあるぞ！

...

Ember.jsをはじめるにあたり、IE8+問題にぶち当たります。

この辺は、1.x系ではサポートされているらしいので2.x系の採用は見送ります。

## Let's begin Ember.js(v1.x)

[実践入門 Ember.js：連載｜gihyo.jp … 技術評論社](http://gihyo.jp/dev/serial/01/emberjs/)

一通り勉強できそうなので、これを参考に。

## STEP1: Bower環境を作る

これないと色々めんどくさそうなので、先に構築

### 1. Node.jsのインストール

[Node.js](https://nodejs.org/)

### 2. npmの初期化(プロキシ環境下での実施の場合)

`power shell` 開いて、以下のコマンド

```
npm config set proxy http://proxy.server.url:99999
npm config list
```

### 3. bowerのインストール

`power shell` 開いて、以下のコマンド

```
npm install -g bower
```

### 4. PhpStormでのnode.jsの初期化

File > Setting > Plugin > Browse repositories ... > 検索窓"nodejs" > Install Plugin > PhpStorm再起動

再起動後...

File > Setting > Langeages & Frameworks > Node.js and NPM

Node interpreter > 入力"C:\Program Files\nodejs\node.exe"

Sources of Node.js Core Modules > ※適当にセットアップ(html経由でCore Moduleをインストールする)

この時点で、Packages を見るとbowerが追加されているはず

PhpStorm上でTerminalを開く > `bower --help`

※bowerにproxy設定が必要な場合

`.bowerrc` に以下の記述を追加

```
{
  "proxy" : "http://proxy.server.url:99999",
  "https-proxy" : "http://proxy.server.url:99999"
}
```

## STEP2: Ember.jsのインストール

PhpStorm上でTerminalを開く

```
bower init
bower install jquery#1.11.3 --save
bower install ember#1.13.6 --save
bower install json2 --save
```

`bower_components` フォルダにファイル群が配置されていればOK

ちなみにこのときの `bower.json`

```
{
  "name": "hello-ember",
  "version": "0.0.0",
  "license": "MIT",
  "dependencies": {
    "jquery": "1.11.3",
    "json2": "*",
    "ember": "1.13.6"
  }
}
```

## STEP3: Ember.jsのボイラープレート

ディレクトリ構成

```
$ tree
.
├── app.js
├── bower.json
├── bower_components
│   ├── ember
│   ├── jquery
│   └── json2
├── index.html
└── readme.md
```

`index.html` はこんな感じ

```
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>hello-emberjs</title>
    <script src="bower_components/jquery/dist/jquery.min.js"></script>
    <script src="bower_components/json2/json2.js"></script>
    <script src="bower_components/ember/ember-template-compiler.js"></script>
    <script src="bower_components/ember/ember.min.js"></script>
</head>
<body>
<script src="app.js" type="text/javascript"></script>
<script type="text/x-handlebars">
  <h1>Hi, {{name}}!</h1>
  My name is {{input value=name}}.
</script>
</body>
</html>
```

WEBブラウザ(特にIE8)でアクセスして表示されればOK
