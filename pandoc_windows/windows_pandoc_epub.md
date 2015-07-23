
:: windows_pandoc_pdf.md
===

これ結構よさげ

```
pandoc \
  -S \
  -f markdown_github \
  -t epub3 \
  --epub-stylesheet=markdown.css \
  --epub-metadata=meta.xml \
  --toc \
  -V fontsize:9pt \
  -V language:ja \
  -o output.epub \
  *.md
```
