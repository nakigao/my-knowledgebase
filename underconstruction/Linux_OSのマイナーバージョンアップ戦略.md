
:: Linux_OSのマイナーバージョンアップ戦略.md
===

トラブルなければ、定型処理でOK

```
# アップデート前の稼働中プロセス確認
pstree | grep "実行中" > before_server_status_$(date +%Y%m%d%I%M%S).log

# パッケージの最新化
yum -y upgrade

# 再起動
reboot

# VMWareToolsの再設定(カーネルの更新が入ると必要になる)
/usr/bin/vmware-config-tools.pl -d

# 停止時バックアップ用に終了
poweroff

# vSphere Clientでバックアップ ... 他のマニュアル参照
名称は `_20150324` のようにYMDでポストフィックスをつける

# vSphere Clientでバックアップ

# アップデート後の稼働中プロセス確認
pstree > after_server_status_$(date +%Y%m%d%I%M%S).log

# アップデート前後でのプロセス比較
diff -uB before after
```
