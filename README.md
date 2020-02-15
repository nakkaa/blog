# Project 1042 Blog

* 静的サイトジェネレータ [Hugo](https://gohugo.io) の味見用リポジトリです。

## 動作環境

* Hugo v0.64.1 以上

## ブログの始め方 (Memo for me)

* brewでHugoをインストールします。
```
brew install hugo
```

* 記事を作成します。
```
hugo new posts/my-first-post.md
```

* 好きなエディタで記事を編集します。

* 記事が完成したら動作確認します。以下のコマンドを叩いて http://localhost:1313/ へアクセスしてください。
```
hugo server -D
```

* 問題がなければ、 `git commit` して `git push` します。

* Netlifyへデプロイされブログが見られます。

## 運用ルール

* Todoについてはissueを立てる。
* ドキュメントの日本語訳メモはWikiに記載する。