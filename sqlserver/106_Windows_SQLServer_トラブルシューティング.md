
:: 106_Windows_SQLServer_トラブルシューティング.md
===

システムのトラブルシューティング

- template version ... 1.0.0
- template last update ... 2015/04/16

# SQLServerの保存領域があがりすぎて、処理が行われない

SQLServerのトランザクションログ(ジャーナルログ)と呼ばれるものが膨れ上がっています。

`E:\Microsoft SQL Server\MSSQL.1\MSSQL\Data\xxx_log.ldf` を見てみる

容量が大きすぎる場合、SQLServerにログインして、以下のコマンドを入力する

```
USE xxx ;
BACKUP LOG xxx WITH TRUNCATE_ONLY;
DBCC SHRINKDATABASE (xxx_log);
```

※「xxx」の部分はログを削除したいDBの名称が入る

再び確認すると容量が減少する

※ -> ストアドに登録しちゃってもよい

