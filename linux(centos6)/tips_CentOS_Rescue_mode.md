
:: CentOS Rescue Mode
===

# 1. こんなときに使える

- ネットワークにつながらない
- パスワード忘れた
- もうどうしようもない

# 2. 特徴

- ネットワークの機能が使えない
- (物理)consoleからアクセスする

# 3. Rescue mode への入り方

1. VMWareで、BIOSモードで起動[選択]
2. BIOS > CD Boot[選択]
3. OSのリブート
4. Rescue installed system[選択]

# 4. Rescue mode に入ったら

1. Choose a Language = English
2. Keyboard Type = jp106
3. Setup Networking = No
4. Rescue = Continue
5. OK
6. OK
7. shell Start shell
8. `#chroot /mnt/sysimage`
9. 後は問題のファイルを編集することが可能！

※仕組みとしては、ディスクシステムをメモリ上に展開(!)して編集を可能にしているらしい
