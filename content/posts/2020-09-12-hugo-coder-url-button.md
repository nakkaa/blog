+++ 
date = 2020-09-12T15:55:20+09:00
title = "HugoにURLとタイトルをコピーするボタンを表示する"
url = "hugo-url-copy-button"
description = "clipboard.jsを使ってHugoに記事のURLとタイトルをクリップボードにコピーするボタンを追加しました。"
categories = ["blog"]
tags = ["hugo"]
+++

[clipboard.js](https://clipboardjs.com/)を使って
Hugo([hugo-coder](https://github.com/luizdepra/hugo-coder))に
記事のURLとタイトルをクリップボードにコピーするボタンを追加しました。  

## 参考サイト

以下のサイトを参考にしました。

- [clipboard.jsでテキストをクリップボードにコピーする方法 | Webクリエイターボックス](https://www.webcreatorbox.com/tech/clipboardjs)
- [Hugoで作ったサイトにシェアボタンを足した | AABrain](https://aakira.app/blog/2018/08/share/)
- [clipboard.js — Copy to clipboard without Flash](https://clipboardjs.com/)

## 導入の背景

少し前から当ブログにもシェアボタンを追加しました。  
Twitterやはてブはシェアボタンが用意されているのですが、私が愛用しているMastodonには公式が提供しているシェアボタンはありません。  
一応、[Mastodhare](https://mastoshare.net)というサービスもあるのですが、
証明書の有効期限切れで使えないことがしばしばありまして。。。  

記事のタイトルとURLをコピーできるボタンを追加した方が良いのではと思い、重い腰を上げました。

## clipboardjsの準備

クリップボードへのコピーを実現するためにclipboard.jsを使います。  
テーマの `layouts/_default/baseof.html` を開き、 `</body>` タグの直前に以下を記載します。

```html
<script src="https://cdn.jsdelivr.net/npm/clipboard@2/dist/clipboard.min.js"></script>
<script>
    new ClipboardJS('.share-url');
</script>
```

## ボタンの設置

`layouts/partials/sharebutton.html` というファイルを新規作成し、以下のHTMLを記載します。

```html
<div class="sns_button link">
    <button title="記事のタイトルとURLをコピー" class="share-url" data-clipboard-text="{{ .Title }} {{ .Permalink }}">
    <i class="fas fa-link"></i>
    </button>
</div>
```

最後にボタンの見た目を調整します。  
[Hugoで作ったサイトにシェアボタンを足した | AABrain](https://aakira.app/blog/2018/08/share/)を参考に、
テーマではなくブログ側のCSSファイル `static/css/custom.css` を編集します。

```css
.share-url{
    display: table-cell;
    width: 44px;
    height: 44px;
    text-align: center;
    vertical-align: middle;
    cursor: pointer;
    border: none;
    background: none;
    background-color: #42464c;
    color:#fff;
}
```

これにて完成です。
