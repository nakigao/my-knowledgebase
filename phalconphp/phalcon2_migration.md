:: phalcon2_migration.md
===

暇なので。

※2015/09/10現在、sqlite3 での migration は、未実装などが多く最後まで実行できませんでした(phalcon v2.0.7, phalcon-devtools v2.0.7)

※2015/09/11現在、sqlite3 での insert などで失敗します(phalcon v2.0.7, phalcon-devtools v2.0.7)

※2015/09/11現在、mysql での migration は、デフォルト値を全く反映しないので使えません(phalcon v2.0.7, phalcon-devtools v2.0.7)

## phpMyAdmin の設定ファイルの修正

`http://localhost/phpmyadmin` にアクセスして、照合順序を変更

`utf8mb4_general_ci` になっていればよい

データベース名 `test` を削除

無名ユーザーを削除

## MySQL の設定ファイルの修正

XAMPP の MySQL に関する設定ファイルは、以下にあるので編集 `C:\xampp\mysql\bin\my.ini`

```
## UTF 8 Settings
#init-connect=\'SET NAMES utf8\'
collation_server=utf8_general_ci
character_set_server=utf8
#skip-character-set-client-handshake
#character_sets-dir="C:/xampp/mysql/share/charsets"
```

※【注意】これ先にやらないと、文字コードがばらっばらになるよ

## DBの初期セットアップ

コマンドプロンプトで以下の内容を入力。

```
mysqladmin --user=root password "root"
```

XAMPP の再起動

## 初期テーブル作成

```
CREATE DATABASE master;
USE master;

DROP TABLE IF EXISTS tasks;
DROP TABLE IF EXISTS task_lists;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  user_id          VARCHAR(128) PRIMARY KEY UNIQUE                                NOT NULL,
  user_name        TEXT                                                           NOT NULL,
  user_email       TEXT                                                           NOT NULL,
  user_password    TEXT                                                           NOT NULL,
  user_description TEXT,
  created_user_id  VARCHAR(128) DEFAULT 'SYSTEM'                                  NOT NULL,
  created_at       DATETIME DEFAULT CURRENT_TIMESTAMP                             NOT NULL,
  updated_user_id  VARCHAR(128) DEFAULT 'SYSTEM'                                  NOT NULL,
  updated_at       DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE task_lists (
  task_list_id          VARCHAR(128) PRIMARY KEY UNIQUE                                NOT NULL,
  user_id               VARCHAR(128)                                                   NOT NULL,
  task_list_title       TEXT                                                           NOT NULL,
  task_list_description TEXT,
  task_list_priority    INTEGER,
  task_list_order       INTEGER,
  created_user_id       VARCHAR(128) DEFAULT 'SYSTEM'                                  NOT NULL,
  created_at            DATETIME DEFAULT CURRENT_TIMESTAMP                             NOT NULL,
  updated_user_id       VARCHAR(128) DEFAULT 'SYSTEM'                                  NOT NULL,
  updated_at            DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE tasks (
  task_id           VARCHAR(128) PRIMARY KEY UNIQUE                                NOT NULL,
  task_list_id      VARCHAR(128)                                                   NOT NULL,
  task_title        TEXT                                                           NOT NULL,
  task_content      TEXT,
  task_priority     INTEGER,
  task_order        INTEGER,
  completed         BOOLEAN DEFAULT FALSE                                          NOT NULL,
  completed_user_id VARCHAR(128),
  completed_at      DATETIME,
  created_user_id   VARCHAR(128) DEFAULT 'SYSTEM'                                  NOT NULL,
  created_at        DATETIME DEFAULT CURRENT_TIMESTAMP                             NOT NULL,
  updated_user_id   VARCHAR(128) DEFAULT 'SYSTEM'                                  NOT NULL,
  updated_at        DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
  FOREIGN KEY (task_list_id) REFERENCES task_lists (task_list_id)
);

# DROP TABLE IF EXISTS test_collate;
# CREATE TABLE test_collate (
#   id   INT,
#   val  VARCHAR(4),
#   note TEXT,
#   PRIMARY KEY (id)
# );
# 
# INSERT INTO test_collate VALUES (11, 'A', '半角大文字');
# INSERT INTO test_collate VALUES (12, 'a', '半角小文字');
# INSERT INTO test_collate VALUES (13, 'Ａ', '全角大文字');
# INSERT INTO test_collate VALUES (14, 'ａ', '全角小文字');
# 
# INSERT INTO test_collate VALUES (21, '1', '半角');
# INSERT INTO test_collate VALUES (22, '１', '全角');
# INSERT INTO test_collate VALUES (23, '一', '漢数字');
# INSERT INTO test_collate VALUES (24, '壱', '漢数字?');
# INSERT INTO test_collate VALUES (25, '①', '機種依存文字 丸数字');
# INSERT INTO test_collate VALUES (26, 'Ⅰ', '機種依存文字 ローマ数字 大');
# INSERT INTO test_collate VALUES (27, 'ⅰ', '機種依存文字 ローマ数字 小');
# 
# INSERT INTO test_collate VALUES (31, '*', '半角');
# INSERT INTO test_collate VALUES (32, '＊', '全角');
# 
# INSERT INTO test_collate VALUES (41, 'け', '全角ひらがな');
# INSERT INTO test_collate VALUES (42, 'ケ', '全角カタカナ');
# INSERT INTO test_collate VALUES (43, 'げ', '全角ひらがな 濁音');
# INSERT INTO test_collate VALUES (44, 'ゲ', '全角かたかな 濁音');
# INSERT INTO test_collate VALUES (45, 'ｹ', '半角カタカナ');
# INSERT INTO test_collate VALUES (46, 'ｹﾞ', '半角カタカナ 濁音');
# INSERT INTO test_collate VALUES (47, 'ヶ', '全角小書き');
# 
# INSERT INTO test_collate VALUES (51, 'は', '全角ひらがな');
# INSERT INTO test_collate VALUES (52, 'ハ', '全角カタカナ');
# INSERT INTO test_collate VALUES (53, 'ば', '全角ひらがな 濁音');
# INSERT INTO test_collate VALUES (54, 'バ', '全角カタカナ 濁音');
# INSERT INTO test_collate VALUES (55, 'ぱ', '全角ひらがな 半濁音');
# INSERT INTO test_collate VALUES (56, 'パ', '全角カタカナ 半濁音');
# INSERT INTO test_collate VALUES (57, 'ﾊ', '半角カタカナ');
# INSERT INTO test_collate VALUES (58, 'ﾊﾞ', '半角カタカナ 濁音');
# INSERT INTO test_collate VALUES (59, 'ﾊﾟ', '半角カタカナ 半濁音');
# 
# SELECT *
# FROM test_collate
# WHERE val = '１'
# ORDER BY id;
# 
# SELECT *
# FROM test_collate
# WHERE val = 'け'
# ORDER BY id;
```

## DB接続設定(mysql)

mysql を利用する場合は、以下の変更を加える

`v1/config/config.php` の編集

```
<?php

defined('APP_PATH') || define('APP_PATH', realpath('.'));

return new \Phalcon\Config(array(
    'database' => array(
        'adapter'    => 'Mysql',
        'host'       => 'localhost',
        'username'   => 'root',
        'password'   => 'root',
        'dbname'     => 'master',
        'charset'    => 'utf8',
    ),
    'application' => array(
        'modelsDir'      => APP_PATH . '/models/',
        'migrationsDir'  => APP_PATH . '/migrations/',
        'viewsDir'       => APP_PATH . '/views/',
        'baseUri'        => '/v1/',
    )
));
```

## DB接続設定(sqlite3)

SQLite3を利用する場合は、以下の変更を加える

`v1/config/config.php` の編集

```
<?php

defined('APP_PATH') || define('APP_PATH', realpath('.'));

return new \Phalcon\Config(array(
    'database' => array(
        'adapter'    => 'Sqlite',
        'host'       => '',
        'username'   => '',
        'password'   => '',
        'dbname'     => __DIR__ . '/../../db/master.sqlite3',
        'charset'    => 'utf8',
    ),
    'application' => array(
        'modelsDir'      => APP_PATH . '/models/',
        'migrationsDir'  => APP_PATH . '/migrations/',
        'viewsDir'       => APP_PATH . '/views/',
        'baseUri'        => '/v1/',
    )
));
```

`v1/config/services.php` の編集

```
/**
 * Database connection is created based in the parameters defined in the configuration file
 */
$di->set('db', function () use ($config) {
    return new \Phalcon\Db\Adapter\Pdo\Sqlite(array(
        'dbname' => '../../db/master.sqlite3'
    ));
});
```

## 初期Migrationの実行

プロジェクトディレクトリへの移動

Migrationの実行(環境の都合上、cygwinで実施)

```
/cygdrive/c/xampp/php/php.exe ../vendor/phalcon/devtools/phalcon.php migration generate --version=0.0.1
```

以下のファイルができあがる

```
$ tree
.
├── app.php
├── config
├── migrations
│   └── 0.0.1
│       ├── task_lists.php
│       ├── tasks.php
│       └── users.php
├── models
├── public
└── views
```

## スキーマの更新

今回は、モックデータをあらかじめ挿入する体で・・・

`migrations/0.0.1/users.php` 内の `up()` 関数の最後尾に以下のスクリプトを挿入

```
// add mock data
self::$_connection->insert(
    'users',
    array(
        'xxxxxxxxxxxxxxxxxxxx',
        'xxxxxxxxxxxxxxxxxxxx',
        'xxxxxxxxxxxxxxxxxxxx',
        'xxxxxxxxxxxxxxxxxxxx',
    ),
    array(
        'user_id',
        'user_name',
        'user_email',
        'user_password',
    )
);
```

あとは、コマンドラインに戻って以下のコマンド

```
/cygdrive/c/xampp/php/php.exe ../vendor/phalcon/devtools/phalcon.php migration run
```

あらかじめモックデータの入ったテーブルが出来上がる
