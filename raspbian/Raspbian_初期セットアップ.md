
:: Raspbian_初期セットアップ.md
===

Raspberry Pi 2 (以下、Raspi)標準OS

Windowsで下準備した。

参考文献: [RaspberryPi - Raspberry piで先にやること - Qiita](http://qiita.com/JO3QMA/items/b0892ce38f9220abea29)

# 1. 準備するもの

以下のものがあれば一通り動く

## 1-1. ハード

- Raspberry Pi 2 Model B
- Micro SD Card
    - higher 8GB
    - higher class 4
- USB HUB
    - セルフパワー式
    - 接続口は4つくらいあると楽しいかも
- USB(micro-B) + USB(A)ケーブル
- HDMIケーブル
- LANケーブル
    - CAT6
- キーボード
    - USB接続

## 1-2. ソフト

- [Downloads | Raspberry Pi](http://www.raspberrypi.org/downloads/)
    - RASPBIANのOS-imgファイル
    - 公式サイトまたはミラーサイトからどうぞ
- [Win32 Disk Imager | SourceForge.net](http://sourceforge.net/projects/win32diskimager/)
    - SDカードへの書き込みユーティリティ

# 2. OSインストール

- `Win32 Disk Imager` に OSイメージファイルを書き込んで、RaspberryPi2に差し込む
- 電源以外を各機器と接続する
- 最後に、電源を接続する

あとは、勝手に起動する

# 3. 初期設定(raspi-config)

OS付属の便利なユーティリティ

後から起動できる(`$ sudo raspi-config`)ので、とりあえず以下の項目だけ

- 1. Expand Filesystem > YES
- 2. Change User Password > 必ず変える
- 4. Internationalisation Options > I1 Change Locale > ja_JP.UTF-8 UTF-8
- 4. Internationalisation Options > I2 Change Timezone > アジア > Tokyo
- 4. Internationalisation Options > I3 Change Keyboard Layout
- 8. Advanced Options > A4 SSH > Enabled

設定が完了すると、勝手に再起動する

# 4. RaspiのIPアドレスを取得

以下のユーザーでRaspiに直接ログイン

```
UID: pi
PSW: raspberry
```

次からはメインの端末からSSH接続するので、PiのIPアドレスを取得する

```
pi@raspberrypi ~ $ ifconfig eth0
eth0      Link encap:イーサネット  ハードウェアアドレス b8:27:eb:d1:55:ce
          inetアドレス:192.168.0.7 ブロードキャスト:192.168.0.255  マスク:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  メトリック:1
          RXパケット:194 エラー:0 損失:0 オーバラン:0 フレーム:0
          TXパケット:101 エラー:0 損失:0 オーバラン:0 キャリア:0
      衝突(Collisions):0 TXキュー長:1000
          RXバイト:16449 (16.0 KiB)  TXバイト:11954 (11.6 KiB)
```

上記の場合は、`192.168.0.7`

※ルーター付属のDHCPで設定しているので、ルーター再起動またはPi起動のたびに変わるはず

# 4. クライアントからSSH接続

後の作業は、メインの端末からできるのでディスプレイはとっぱらってOK

```
$ ssh pi@192.168.0.7
```

# 5. パッケージ管理ツールの最新版への更新

`aptitude` を使います。`apt-get` よりよいらしいです。

```
pi@raspberrypi ~ $ sudo aptitude update
pi@raspberrypi ~ $ sudo aptitude full-upgrade
pi@raspberrypi ~ $ sudo aptitude clean
```

# 6. CLIの日本語化

boxboxboxboxbox...

気になるので、直しておきましょう

```
pi@raspberrypi ~ $ sudo aptitude -y install ttf-kochi-gothic xfonts-intl-japanese xfonts-intl-japanese-big xfonts-kaname
pi@raspberrypi ~ $ sudo aptitude install jfbterm
pi@raspberrypi ~ $ jfbterm
```

起動のたびに `jfbterm` に切り替える必要があるんだけど、CygwinやらTerminalからいく場合は、ホストのフォントで描画されるので、あんまり気にしなくていい

TODO: デフォルトシェルの変更をかえるか？

```
pi@raspberrypi ~ $ dpkg -L jfbterm
```

# 7. 不要なパッケージのアンインストール

※Server用途に使うだけなので、GUIのツールなどは全てアンインストール

```
pi@raspberrypi ~ $ sudo aptitude -y purge alsa-utils console-setup dbus-x11 debian-reference-en desktop-base desktop.* dillo gconf-service gconf2-common gksu gnome-icon-theme gnome-themes-standard gnome.* gsfonts gtk.* gtk2-engines gvfs-backends gvfs-fuse gvfs.* idle idle3 libgtk.* libqt.* libraspberrypi-dev libraspberrypi-doc libx11-6 libx11-data libx11-xcb1 libxcb.* libxfont.* libxt.* lightdm lxde lxde-icon-theme lxde.* lxmenu.* lxpanel lxpolkit lxtask menu-xdg midori mupdf netsurf-gtk omxplayer openbox penguinspuzzle python-pygame python-tk python3-tk raspberrypi-artwork scratch shared-mime-info tcl.* x11-common x11-utils x11.* xarchiver xauth xdg-.* xdg-utilse xinit xkb-data xserver-xorg xserver-xorg-video-fbdev xserver.* zenity
```

# 8. 不要なディレクトリなどの削除

※Server用途に使うだけなので、不要なものは全てアンインストール

```
pi@raspberrypi ~ $ sudo rm -rf /usr/share/doc/* /opt/vc/src/hello_pi/hello_video/test.h264 /home/pi/python_games
pi@raspberrypi ~ $ find /usr/share/locale/* -maxdepth 0 -type d |grep -v en |xargs sudo rm -rf
pi@raspberrypi ~ $ find /usr/share/man/* -maxdepth 0 -type d |grep -Pv 'man\d' |xargs sudo rm -rf
```

REF: [Minimalist Raspberry Pi Server Image | Richard's Ramblings](http://www.richardsramblings.com/2013/02/minimalist-raspberry-pi-server-image/)
