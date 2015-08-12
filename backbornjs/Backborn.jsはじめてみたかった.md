Backborn.jsはじめてみたかった.md
===

[Backbone.js](http://backbonejs.org/)

暇ではないけど、暇なので...

最終目標は、「Backbone + Marionette + stickit + Handlebars」

## はじめに

AngularJS?

だめだね！__IE8__がサポートされないからね！

~~エンタープライズ思考はもうほんと狂ってますよ~~

## Let's begin Backbone.js

[Hello Backbone.js Tutorial](http://jasongiedymin.github.io/hello-backbonejs/)

ここのサイトがとてもよさげです

... BEGIN TUTORIAL ...

```
まず抑えるべきは・・・

- Model
- Collection
- View

ViewがControllerみたいな役割を担っているのかこれ <- eventなどの追加をrenderでやってるため

思ったこと、これはFlash(ActionScript)の考え方に似ているのかも

Flash(ActionScript): インスタンスの中にそのインスタンスに対する挙動を定義する(インスタンスがスクリプトを持つ)
Backbone.js: Viewの中にそのViewに対する挙動を定義する(Viewがイベント定義などを持つ)

sync が出てきたが、おまじない程度の解説だった
```

... END TUTORIAL ...

写コードして、全部で1時間くらいかな

必要最低限の開発の流れだけ把握

## 「IMASARA」感が漂う・・・

今やるなら、他にもたくさん選択肢がある

- React.js
- Angular.js
- Ember.js

エンタープライズで使うには、以下の要件が必要

- IE8+

モダンブラウザの利用が期待できない環境であれば `Ember.js(v1.x)` が有力候補になりそう
