:: insall_compass_at_Windows7
===

暇です。compassいれますから！

# Rubyのインストール

[Downloads](http://rubyinstaller.org/downloads/)　から適当なバージョンをダウンロード。

※最新か安定版でよし

# Ruby - gem のアップデート

プロキシ環境下ならば

```
gem update --system -p http://proxy.host.name:port_number
```

# compass(sassも含む) のインストール

プロキシ環境下ならば

```
gem install compass --system -p http://proxy.host.name:port_number
```

# インストールの確認

```
PS C:\Users\username> compass -v
Compass 1.0.3 (Polaris)
Copyright (c) 2008-2015 Chris Eppstein
Released under the MIT License.
Compass is charityware.
Please make a tax deductable donation for a worthy cause: http://umdf.org/compass

PS C:\Users\username> sass -v
Sass 3.4.15 (Selective Steve)
```

its easy :)
