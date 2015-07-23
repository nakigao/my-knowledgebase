
:: SQLServerセットアップ
===

# 1. 前提環境

1. 管理ツール > サーバーマネージャー > 機能 > 機能の追加[Click]
2. `.NET Framework 3.5.1`[選択]
3. [http://www.microsoft.com/en-us/download/confirmation.aspx?id=22](http://www.microsoft.com/en-us/download/confirmation.aspx?id=22) から `SQL Server 2008 SP1`[ダウンロード]
4. `dotnetfx35setup.exe`[DClick]
5. `SQLEXPRWT_x64_JPN.exe`[ダウンロード]
6. インストールツールを実行
    1. setup.exe[DClick]
    2. 自動更新[OFF]
    3. サーバー構成 > 認証 > SQL認証[click] ... ※Windows認証だけだと、外からアクセスする際に不都合がある
    4. データディレクトリ > データの格納先
    5. デフォルトから、E:ドライブの任意のディレクトリに変更
    6. 以降は「次へ」を繰り返す
7. 再起動
8. サーバーの更新プログラムをインストール
9. TCP/IP接続の設定 ... 参考:[SQL Server 2012 Express Edition にTCP/IP接続する方法 - SQL Server Documents - Project Group](http://www.projectgroup.info/documents/MSSQL/MSSQL-20120002.html)
    1. SQL Server Configuration Manager[実行]
    2. ログイン ... SQL認証 > ID:sa PASS：いつもの
    3. SQL Server 構成マネージャー > SQL Native Client 11.0 > クライアントプロトコル > TCP/IP[有効化]
    4. SQL Server 構成マネージャー > SQL Native Client 11.0 > クライアントプロトコル > TCP/IP[右クリック] > プロパティ > 規定ポート[1433]
10. ClientPCにもSQLServerExpress(management studio)をインストール
11. 接続テスト

# 2. 既存DBのインポート

(参考)[データベースのバックアップの復元 (SQL Server Management Studio)](https://msdn.microsoft.com/ja-jp/library/ms177429.aspx)

1. backup file のコピー(※リモートサーバーのどこかに配置する)
2. 接続ユーザーはー、saユーザーにする
3. リストアするDBの名前で、DBを作成する(ない場合)
4. データの増加戦略は「10%で増加」
5. オプションタブ > 既存上書き[ON]
