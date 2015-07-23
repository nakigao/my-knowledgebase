
:: windows_pandoc_word.md
===

Windows で pandoc を利用して Microsoft Word のドキュメントを生成する方法

# インストール

[jgm/pandoc · GitHub](https://github.com/jgm/pandoc)

[Releases · jgm/pandoc · GitHub](https://github.com/jgm/pandoc/releases)

最新版を利用するようにします。

上記サイトから、msi形式をダウンロードし、インストール

`cmd.exe` を起動して、確認

```
[user@pc /cygdrive/c/Users/user/Desktop/pandoc_docx]$ pandoc -v
pandoc.exe 1.13.2
Compiled with texmath 0.8.0.1, highlighting-kate 0.5.11.1.
Syntax highlighting is supported for the following languages:
    abc, actionscript, ada, agda, apache, asn1, asp, awk, bash, bibtex, boo, c,
    changelog, clojure, cmake, coffee, coldfusion, commonlisp, cpp, cs, css,
    curry, d, diff, djangotemplate, dockerfile, dot, doxygen, doxygenlua, dtd,
    eiffel, email, erlang, fasm, fortran, fsharp, gcc, glsl, gnuassembler, go,
    haskell, haxe, html, ini, isocpp, java, javadoc, javascript, json, jsp,
    julia, latex, lex, lilypond, literatecurry, literatehaskell, lua, m4,
    makefile, mandoc, markdown, mathematica, matlab, maxima, mediawiki,
    metafont, mips, modelines, modula2, modula3, monobasic, nasm, noweb,
    objectivec, objectivecpp, ocaml, octave, opencl, pascal, perl, php, pike,
    postscript, prolog, pure, python, r, relaxng, relaxngcompact, rest, rhtml,
    roff, ruby, rust, scala, scheme, sci, sed, sgml, sql, sqlmysql,
    sqlpostgresql, tcl, tcsh, texinfo, verilog, vhdl, xml, xorg, xslt, xul,
    yacc, yaml, zsh
Default user data directory: C:\Users\user\AppData\Roaming\pandoc
Copyright (C) 2006-2014 John MacFarlane
Web:  http://johnmacfarlane.net/pandoc
This is free software; see the source for copying conditions.
There is no warranty, not even for merchantability or fitness
for a particular purpose.
```

# docxの作り方

以下のディレクトリ構成を作成

```
[user@pc /cygdrive/c/Users/user/Desktop/pandoc_docx]$ tree
.
├── 101_Windows_contacts_概要.md
├── 102_Windows_contacts_インストールガイド.md
├── 103_Windows_contacts_開発ガイド.md
├── 104_Windows_contacts_テストガイド.md
├── 105_Windows_contacts_運用保守ガイド.md
├── 106_Windows_contacts_トラブルシューティング.md
├── 110_Windows_contacts_その他(未整理).md
└── custom_template_v1.docx
```

以下のコマンドを実行(タイトルとファイル名は適宜変更のこと)

```
pandoc --reference-docx=custom_template_v1.docx -M title='XXXXX SYSTEM MANUAL - Windows contacts' -M author='XXXXX SYSTEM DEPT.' -toc -f markdown *.md -t docx -o 'XXXXX SYSTEM MANUAL - Windows contacts.docx'
```
