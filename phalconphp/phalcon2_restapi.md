:: phalcon2_restapi.md
===

暇です。

Phalcon2 で REST API Server を作ってみたい

## 環境

- Php(5.5.x) with Phalcon(2.0.x)
- PhpStorm(9.0.x)
- composer

## 設計

作ったことないから、適当に・・・

```
アクセスを想定するURL: api.mydomain.com/v1/xxxxxxxxxx
```

XAMPPでサーバー2本立てにすると面倒くさい話になるので、今回はフロントエンドサーバーと同一のURLで行う

### TIPS

メソッドごとに認証が必要なリソースの場合、認証が必要なメソッドに関しては認証情報から引ける情報は含めないようにする

```
例)
GET     /blogs/:blog_id/articles/:id.:format
POST    /articles
PUT     /articles/:id
DELETE  /articles/:id
```

## プロジェクトセットアップ

FullStackよりもMicroが的確らしいので、devtoolsでmicroprojectをセットアップ

```
/cygdrive/c/php/5.5.26/php.exe vendor/phalcon/devtools/phalcon.php project v1 --type=micro
```

適当にデプロイ

`http://localhost/v1/` でアクセスして表示されればOK

## コーディング規約

CakePHPと違って、命名規則やらフォルダの規則やらが無いのでちょっと戸惑う

ベストプラクティスが見当たらなかったので、適当に・・・

### 命名規則

- ファイル名       ... lowerCamel
- 変数名           ... lowerCamel
- クラスファイル名 ... UpperCamel、複数形
- クラス名         ... UpperCamel、複数形
- URL              ... lowerCamel、複数形

### 設計規則

- 操作するモデル毎にキック用ファイルを生成する ... 例えばUsersモデルを操作する場合は、キック用としてusers.phpを用意し、そこにルーティングを記述する

## 実際の開発

いざ開発 ... といってもDB用意してないのでなにもできない感じ

キック用ファイルは基本的にはこんな内容になる

`v1/users.php`

```
<?php
/**
 * Local variables
 * @var \Phalcon\Mvc\Micro $app
 */

use Phalcon\Http\Response;

/**
 * get all entry
 */
$app->get('/users', function () {
    $response = new Response();
    $response->setStatusCode(200, "OK");
    $response->setJsonContent(
        array(
            'status' => 'OK',
            'body' => Users::sayHello(),
            'message' => 'success to access'
        )
    );
    return $response;
});

/**
 * search entry with name
 */
$app->get('/users/search/{name}', function ($name) {

});

/**
 * get specific entry
 */
$app->get('/users/{id:[0-9]+}', function ($id) {

});

/**
 * add entry
 */
$app->post('/users', function () {
    // TODO: token必須
});

/**
 * update entry
 */
$app->put('/users/{id:[0-9]+}', function () {
    // TODO: token必須
});

/**
 * delete entry
 */
$app->delete('/users/{id:[0-9]+}', function () {
    // TODO: token必須
});
```

モデルファイルはこう

`v1/models/Users.php`

```
<?php
use Phalcon\Mvc\Model;

class Users extends Model
{
    /**
     * Gets internal database connection
     *
     * @return \Phalcon\Db\AdapterInterface
     */
    public function getConnection()
    {
        // TODO: Implement getConnection() method.
    }

    /**
     * Assigns values to a model from an array returning a new model
     *
     * @param array $result
     * @param \Phalcon\Mvc\ModelInterface $base
     * @return \Phalcon\Mvc\ModelInterface $result
     */
    public function dumpResult($base, $result)
    {
        // TODO: Implement dumpResult() method.
    }

    /**
     * Returns DependencyInjection connection service
     *
     * @return string
     */
    public function getConnectionService()
    {
        // TODO: Implement getConnectionService() method.
    }

    /**
     * Reset a model instance data
     */
    public function reset()
    {
        // TODO: Implement reset() method.
    }

    /**
     * Forces that a model doesn't need to be checked if exists before store it
     *
     * @param boolean $forceExists
     */
    public function setForceExists($forceExists)
    {
        // TODO: Implement setForceExists() method.
    }

    /**
     *
     */
    public function validation()
    {
        // to do something
    }

    /**
     * test method
     *
     * @return string
     */
    public static function sayHello()
    {
        return array('0' => 'Hello!');
    }
}
```

