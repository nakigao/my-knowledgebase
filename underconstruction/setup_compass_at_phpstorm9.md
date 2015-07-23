:: setup_compass_at_phpstorm9
===

暇です。

compassをphpstorm9で使えるようにしますから！

# 環境

- Windows Server 2008
- IIS7
- PHP5.3.x
- SlimFramework 2.6.2
- Ruby 2.2.x
- Compass 1.0.3
- Sass 3.4.15

# プロジェクトスケルトンの生成

正直なんでもいいですが・・・、せっかくなのでSlimFramework(v2)と一緒に導入するつもりで構造を構築っと

[Slim Framework](http://www.slimframework.com/) ... php5.3で動かすのでv2より上は使えないです、ぐぎぎ

[PHP Template Engine | Smarty](http://www.smarty.net/) ... 既存コードがSmartyで生成されてるので、テンプレートはこれで

プロジェクトスケルトンは以下の構成で。

```
.
├── bin
│   └── sync-local-to-development.bat
├── config
│   └── config.conf
├── controller
├── model
├── public_html
│   ├── index.php
│   └── web.conf
├── vendor
│   ├── Slim
│   └── Smarty
└── view
```

あとは適当なIISサーバーに仮想ディレクトリ(`\path_to_directory\public_html`)を張るります

WEBからアクセスして、slimのwelcomeページが見えたらOK

its easy :)

# Compass の初期化

`\path_to_directory\public_html` でCompassのスケルトンを作成

```
cd \path_to_directory\public_html
compass create assets --sass-dir "scss" --css-dir "css" --javascripts-dir "js" --images-dir "img" --relative-assets
```

# PhpStorm 上での Compass 初期化

```
File > Settings > Languages & Frameworks > Compass
    Enable Compass support ... check ON
    Compass executable file: ... C:\Ruby22\bin\compass.bat
    Config path: ... C:\Users\user\Documents\PhpstormProjects\contacts2015\public_html\assets\config.rb
```

# PhpStorm 上での File Watchers の設定

PhpStormに付属してるので、適当に設定します

※適当なScssファイルを開くと、設定ダイアログを開くリンクが出てくるので、クリックする

File > Settings > Tools > File Watchers > +

```
※変更が必要なところ
Program: compass.bat
Arguments: compile
Working directory: $FileParentDir$
```

後は、適当にSCSSファイルを編集すればOK

