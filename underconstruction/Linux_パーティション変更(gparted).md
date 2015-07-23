
:: Linux_パーティション変更(gparted).md
===

GParted is a free partition editor for graphically managing your disk partitions

GUIのツールなので1GBくらい必要とのこと

[GParted -- A free application for graphically managing disk device partitions](http://gparted.org/index.php)

# 1. 使いどころ

- LinuxOSにおいて、ディスクパーティッションを増やしたい

# 2. 下準備

## VMware上の操作

サマリ > 設定の変更 > ハードウェア > ※ハードディスク選択 > ディスクプロビジョニングを増やす

サマリ > 設定の変更 > ハードウェア > ※CD/DVDドライブ > データストアISOファイル > `[iso] tools/gparted-live-0.19.0-1-i486.iso`選択

サマリ > 設定の変更 > ハードウェア > デバイスのステータス > パワーオン時に接続

サマリ > 設定の変更 > オプション > 詳細 > 起動オプション > 強制的にBIOSセットアップ > 次回仮想マシンの起動時に、強制的にBIOSセットアップ画面に入るON

サマリ > パワーオン

## BIOS画面

CD-ROM起動を優先度1にする > Save and exit

## GParted起動

※GUIに従ってやればOK




