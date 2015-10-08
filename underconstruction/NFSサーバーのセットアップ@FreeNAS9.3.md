NFSサーバーのセットアップ@FreeNAS9.3
===

SSR-L の RescueCD は nfs のマウントが可能なため、バックアップ先は NFS のストレージが望ましい。

## 大まかな流れ

1.FreeNAS を通常インストールする
2.FreeNAS の WEBGUI の Wizard に従って、NFS の共有プールを作成する
3.Sharing > *作成した共有プール*選択 > EDIT > Advanced Mode > Maproot User > root に設定する
4.FreeNAS のコンソールで `rpcinfo -s xxx.xxx.xxx.xxx | egrep 'nfs|mountd'` で NFS が起動しているか確認(version も確認可能)
5.マウントする側のサーバーにログインし、`mount -t nfs -o nolock xxx.xxx.xxx.xxx:/mnt/path/to /mnt/nfs` でマウントしてみる






