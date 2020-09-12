+++ 
date = 2020-09-12T15:15:46+09:00
title = "Hugo Coderに目次(ToC)を実装する"
url = "hugo-coder-toc"
description = "Hugoに目次(ToC)を追加しました。"
categories = ["blog"]
tags = ["hugo"]
+++

このブログで使っているHugo ([hugo-coder](https://github.com/luizdepra/hugo-coder))
に目次(ToC)を追加しました。  
その時の作業手順を記載します。(10分程度で実現できます。)

今回主に参考にしたのは以下のサイトです。

- [hugoで目次(tableOfContents)を表示する方法](https://note.mokuzine.net/hugo-toc/)
- [Hugo の目次について考える · k-kaz](https://k-kaz-git.github.io/post/hugo-custom-tableofcontents/#400%E5%AD%97%E6%9C%AA%E6%BA%80%E3%81%AE%E5%A0%B4%E5%90%88%E3%81%AF%E7%9B%AE%E6%AC%A1%E3%82%92%E5%87%BA%E3%81%95%E3%81%AA%E3%81%84)
- [各ページに目次を表示する (.TableOfContents) | まくまくHugo/Goノート](https://maku77.github.io/hugo/template/table-of-contents.html#%E3%83%86%E3%83%B3%E3%83%97%E3%83%AC%E3%83%BC%E3%83%88%E3%81%AE%E8%A8%98%E8%BF%B0%E6%96%B9%E6%B3%95v060%E4%BB%A5%E9%99%8D)

公式ドキュメントも参考にしました。

- [Table of Contents | Hugo](https://gohugo.io/content-management/toc/#template-example-toc-partial)

## Hugo Coder(テーマ)に目次表示機能を追加

Hugo Coderに目次表示機能を追加します。  
機能自体はHugo側で用意されているので、HTMLテンプレートを作るだけで済みます。

hugo-coder(テーマ)配下に移動します。  
`layouts/partial/toc.html` というファイルを新規作成し、以下のコードを記載します。

```html
<div class="page-toc">
  <details>
    <summary>目次</summary>
    {{ .TableOfContents }}
  </details>
</div>  
```

次にブログ記事に目次を表示するよう `layouts/posts/single.html` に以下を追記します。  
私は `{{ .Content }}` の手前に記載しました。

```html
    {{ partial "toc.html" . }}
    {{ .Content }}
```

## CSSで見た目を調整

[hugoで目次(tableOfContents)を表示する方法](https://note.mokuzine.net/hugo-toc/)
を参考に、目次の見た目をCSSファイルで調整します。  

CSSファイルはテーマではなくブログ側の `static/css/custom.css` に以下を追記します。

```css
.page-toc {
    margin: 1em;
    padding: 1em;
    width: auto;
    border: 1px solid #ddd;
}
```

これで完成です。

## あとがき

目次の表示はテーマの改造が必要と知って面倒くさがっていたのですが、
思ったより簡単に実現できました。(もっと早くにやっていればよかったです。)  

Hugoも最近は日本語の情報が増えてだいぶ楽になったなと感じました。  
情報を残してくださった先人の方々ありがとうございます。
