:: Windows7でvisitorsを利用して、IISのログを解析する
===

[Visitors - fast web log analyzer](http://www.hping.org/visitors/index_jp.php)

Awstatsの代替案として実験的に導入してみる

※ELK-Stack使えとか言わないこと

# 特徴

- 高速
- シンプルな出力
- 必要最小限のアクセス解析
- ローカルだけで完結可能 = 手軽

# 経緯

- アクセス解析においてメニューごと(フォルダ単位)での細かい解析が必要になった
- 上記解決するためには、現状の仕組み(Awstats)では対応しにくい(mendo-kusai)

※実際にやってみたら、フォルダ単位のスタッツ出ないじゃないか！コンチクショウ！

# 前提条件

- Windows7(32bit)
- Cygwin

# 準備

付属のパッケージマネージャ

`make` のインストール

```
[USERNAME@HOSTNAME ~]$ make -v
GNU Make 4.1
このプログラムは i686-pc-cygwin 用にビルドされました
Copyright (C) 1988-2014 Free Software Foundation, Inc.
ライセンス GPLv3+: GNU GPL バージョン 3 以降 <http://gnu.org/licenses/gpl.html>
これはフリーソフトウェアです: 自由に変更および配布できます.
法律の許す限り、　無保証　です.
```

`cc` のインストール ... `gcc-core` をインストールすればOK

```
[USERNAME@HOSTNAME ~]$ cc --version
cc (GCC) 4.9.2
Copyright (C) 2014 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

# コンパイル

`http://www.hping.org/visitors/index_jp.php` からソースコードのダウンロード

`visitors-0.7.tar.gz` の解凍

カレントディレクトリを解凍したディレクトリに指定して `make` 実行

... しばらく待つ ...

`visitor.exe` ができるのを確認

# テスト

```
[USERNAME@HOSTNAME /cygdrive/c/Users/USERNAME/Desktop/visitors_0.7]$ ./visitors.exe -v
Visitors 0.7
```

# ログファイルの加工(IISをApache形式に変換する)

※省略 ... utilityを用意してあるので利用すること

# レポート生成

以下のディレクトリ/ファイル構成を作る

```
[USERNAME@HOSTNAME /cygdrive/c/Users/USERNAME/Desktop/visitors.test]$ tree .
.
├── access.log
└── visitors.exe
```

以下のコマンドを実施

```
visitors -A access.log -o html > report.html
```
