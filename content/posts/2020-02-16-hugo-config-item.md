---
title: HugoのConfigでわからない項目があったのでまとめた
author: なっかあ
type: post
date: 2020-02-16T10:30:49+00:00
url: /hugo-config-item/
categories:
  - コンピュータ
tags:
  - Hugo

---
最近このブログをHugoへ移行するために、Hugoでサイトを立てて弄り回しているのですが、Configでよくわからない項目があったので調べてみました。  
(本当は公式ドキュメントから探すのが筋なのですが、一部先人のブログを参考にしています。)

## copyright

サイトのCopyright表記を指定する。

## disqusShortname

disqusのアカウント名を指定すると、コメント欄(disqus)が使えるようになる。

[Comments | Hugo][1]

## hasCJKLanguage

`hasCJKLanguage` を有効化すると、記事一覧ページのサマリ(概要)が短くなるらしい。  
[Hugoのサマリー機能を理解する。そしてブログのパフォーマンス改善へ。 | Goldstine研究所][2]

デフォルトはfalseのため、日本語を使う場合はtrueにした方が良さそうです。

## languageCode

サイトのlanguageCodeを指定します。デフォルトは空です。  
RSS templateで使用されるらしい。他にも複数言語対応サイトを作る時にも使うと便利なようです。(知らんけど)

日本語を使う場合は `ja` を指定します。

## pygmentsCodeFences

有効化することで、コードブロックを言語ごとにシンタックスハイライト(カラーリング)できるらしい。

  
[hugo で Fence Code Blocks (&#8220;\`)を有効化する &#8211; Qiita][3]  
[Hugoでシンタックスハイライト | Baby Steps][4]

## pygmentsUseClasses

シンタックスハイライトのスタイルをcssで指定できるらしい。`pygmentsCodeFences` の有効化が前提？

[Syntax Highlighting | Hugo][5]

## rssLimit

RSSフィードに表示する項目の最大数を指定します。デフォルトは無制限です。

## summaryLength

サマリに表示する単語のテキストの長さ(文字数？)です。デフォルトは70です。

## uglyURLs

有効化すると、`/filename/` ではなく`/filename.html` 形式のURLが作成されます。デフォルトはfalseです。

## theme

使用するテーマを指定します。デフォルトは空です。

`hogehoge` を指定すると、themesディレクトリ配下のhogehogeが使われる。

## title

サイトのタイトルを指定します。

## 参考サイト

* [Configure Hugo | Hugo][6]

 [1]: https://gohugo.io/content-management/comments/
 [2]: https://blog.mosuke.tech/entry/2017/08/06/hugo_summary/
 [3]: https://qiita.com/hfm/items/3df99e0f94162d454f7a
 [4]: https://tech-babysteps.net/hugo-syntax-highlighting/
 [5]: https://gohugo.io/content-management/syntax-highlighting/
 [6]: https://gohugo.io/getting-started/configuration/