+++ 
date = 2020-09-12T17:10:22+09:00
title = "Hugo Coderで関連記事を表示する"
url = "hugo-coder-related-page"
description = ""
categories = ["blog"]
tags = ["hugo"]
+++

このブログで使っているHugo([hugo-coder](https://github.com/luizdepra/hugo-coder))で関連記事を表示するようにしました。
その時の作業手順を記載します。(15分程度で実現できます。)

## 参考サイト

- [Related Content | Hugo](https://gohugo.io/content-management/related/)

## 関連記事リストを作成

まずはpartials配下に関連記事を表示するパーツを作成します。  
テーマフォルダに `layouts/partials/related.html` を作成し、以下のHTMLを記載してください。

```html
{{ $related := .Site.RegularPages.Related . | first 5 }}
{{ with $related }}
<h2>関連記事</h2>
<ul>
    {{ range . }}
    <li><a href="{{ .RelPermalink }}">{{ .Title }}</a></li>
    {{ end }}
</ul>
{{ end }}
```

次に `layouts/posts/single.html` を開きます。  
先ほど作成したrelated.htmlを読み込ませるため `{{ .Content }}` の下に以下を追記します。

```go
{{ partial "related.html" . }}
```

これで完成です。

## 関連度合いの重みづけ

Hugoの設定ファイル `config.toml` で関連記事の表示の重みづけを行えます。  
私は以下のようなカテゴリよりタグを優先した重み付けを設定しています。  
運営するサイトに合わせて好きな値にカスタマイズしてください。

```toml
[related]
  includeNewer = true
  threshold = 80
  toLower = true

[[related.indices]]
  name = "tags"
  weight = 80

[[related.indices]]
  name = "categories"
  weight = 60

[[related.indices]]
  name = "date"
  weight = 10
```

以下、簡単な説明です。

- includeNewerは
現在のページよりも新しいページを関連記事に含めるかを指定する項目です。含める場合はtrueを指定します。
- toLowerはインデックスとクエリの両方でキーワードを小文字にするかを指定する項目です。
私は小文字にするためtrueとしています。
- thresholdは関連性を調整するための値です。0から100を指定します。値が小さいほど一致は多くなりますが、関連性も低くなります。私はデフォルト値を指定しています。

- nameはインデックス名です。カテゴリやタグや日付を指定できます。
- weightはこのパラメータがどの程度重要かを示す整数の値です。

## あとがき

Hugoの内部処理が優秀なのか、それっぽい関連記事を表示してくれて満足です！
