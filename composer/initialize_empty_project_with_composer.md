:: initialize_empty_project_with_composer
===

暇です。プロジェクトはポシャリましたが、せっかく調査したのでメモ

# Requestments

- Windows7
- PHP 5.5.x
- PhpStorm 9.0
- Composer.phar 1.0.x

# Download Composer.phar

Install from [Composer](https://getcomposer.org/download/) , then php.exe and composer.pahr located in same directory

# Initialize empty project

File > New Project ...

```
Project name    : hogemoge-composer-project
Location        : /path/to/hogemoge-composer-project
Project type    : Empty project
```

まっさらなディレクトリが作成される

# Initialize composer

ディレクトリのトップで右クリック

Composer > init composer

```
Path to PHP executable:     /path/to/php.exe
Path to composer.phar:      /path/to/composer.phar
```

`composer.json` が生成される。

`composer.json` を右クリック > Add dependency...

ダイアログで適当なパッケージ名を選択し、Install押下

完了したら、Update押下

後は、勝手に定義の追加してくれる

Its easy :)