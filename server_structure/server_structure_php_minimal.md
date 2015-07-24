:: server_structure_php_minimal.md
===

暇なので、スケーリング可能(極力ステートレス)なサーバー構成を考えてみました

この辺りのノウハウはほぼゼロなのでご了承ください

## ソフトウェアの構成

```
USER                                ???
└── REVERSE PROXY SERVER        haproxy, load-balancer
    ├── DB SERVER               mysql[3306]
    └── WEB SERVER              apache, php[80], node.js[8088]
        ├── STORAGE SERVER      redis[6379]
        └── SESSION SERVER      static-files
```

balancing(スケールアップ)は、HAProxy任せで。

SessionはRedis(スケールアップは考慮しない)

StorageはGlasterFSとかでクラスタリングするんだっけ？

## サーバー性能リスト

サーバーの性能要件もほしいですね ※ストレージはどれもそこまで必要ないので無視

- minimal
    - CPU:      1[core]1[cpu]
    - MEMORY:   512[mb]
- small
    - CPU:      2[core]1[cpu]
    - MEMORY:   1[gb]
- medium
    - CPU:      3[core]1[cpu]
    - MEMORY:   2[gb]
- large
    - CPU:      4[core]1[cpu]
    - MEMORY:   4[gb]
- more
    - CPU:      6[core]1[cpu]
    - MEMORY:   8[gb]

## サーバー性能目安

```
USER                                ???
└── REVERSE PROXY SERVER        minimal
    ├── DB SERVER               large - more
    └── WEB SERVER              small - medium
        ├── STORAGE SERVER      small
        └── SESSION SERVER      medium - more
```

## お予算感(さくらVPSの場合) ※2015年7月現在

```
USER                                ???
└── REVERSE PROXY SERVER        \635
    ├── DB SERVER               \3600 - \7200
    └── WEB SERVER              \900 - \1580
        ├── STORAGE SERVER      \900
        └── SESSION SERVER      \1580 - \7200

合計: \7615 - \17515
```

## お予算感(AWSの場合) ※2015年7月現在

計算めんどくちゃあああああ

※やめました


---

あとは、実際にできるか1つ1つ検証ですかねぇ・・

NEXT TASKS:

- 最小構成
- HAProxyでSSL
- PHP + NODE連携
- HAProxy + WEB Server
- HAProxy + DB Server
