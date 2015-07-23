
:: IISサーバーセットアップ
===

# 1. IISの標準構成

1. IISサーバーのセットアップ ... 公式マニュアル通り
2. 「Visual Studio 2012 更新プログラム 3 の Visual C++ 再頒布可能パッケージ」のインストール
3. PHPのセットアップ ... `php.ini` を他のところからコピーが無難
4. IISにPHPを紐付け ... 公式マニュアル通り
5. `phpinfo.php` を配置 ... `C:\inetpub\wwwroot`
6. WEBページへのアクセス ... `http://localhost/phpinfo.php`

# 2. IISのWEBROOTを変更する

※TODO: まだ書いてません

# 3. IISにPORT8080をオープンする

開発サーバーは、ポート指定をして8080でアプリを開くようにしている。

本番サーバーなどでは、この設定は行わず `Default Server` で環境を構築する。

1. 管理ツール
2. セキュリティが強化されたWindowsファイアウォール
3. 受信の規則
4. 新しい規則
5. ポート[check]
6. 次へ
7. TCP[check]
8. 特定のローカルポート[8080]
9. 次へ
10. 接続を許可する[check]
11. 次へ
12. ドメイン[check]
13. プライベート[check]
14. パブリック[check]
15. 次へ
16. 名前[World Wide Web Services (HTTP 8080 Traffic-In)]

# 4. IISサーバーにWindows認証を追加

1. IISマネージャ    [開く]
2. サーバーマネージャー > 役割 > Webサーバー(IIS)  [クリック]
3. [機能ビュー]の[認証]    [ダブルクリック]
4. 役割サービスの追加   [選択]
5. Windows認証[check]
6. 次へ
7. インストール

# 5. サーバーの再起動

サイト > 認証アイコン[DoubleClick]

# 6. 動作確認

- `phpinfo.php` で見る
    - `$_SERVER['REMOTE_USER']` ... 認証されていれば値が入ってくる
    - `$_SERVER['LOGON_USER']` ... 認証されていれば値が入ってくる
    - `$_SERVER['AUTH_USER']` ... 認証されていれば値が入ってくる
- FIREFOXで確認する
    - Windows認証がデフォルトで動かないので、認証のダイアログが出てくる = OK

# 7. TIPS

## 7-1. PHPのバージョンは、コンパイラのbit数を合わせる

## 7-2. IISでのPHPはNTSでOK

FastCGIがシングルスレッドしか使用しないためIISでのPHPはNONE-THREAD-SAFEでよろしい

## 7-3. portベースのアプリケーションセットアップ

googleすればいけます
