---
title: SlackのBot開発で大なり小なり記号が拾えずつまずいた話
author: なっかあ
type: posts
date: 2019-09-30T12:43:05+09:00
url: /slack-dainari-syonari/
categories:
  - プログラミング

---
SlackのBot開発についての話です。

## 背景の説明

Botに「ユーザのメッセージに大なり記号（あるいは小なり記号）が含まれた時に反応を返す」処理をさせたかったのですが、うまくいかずにつまずいた話です。

## 解決策 文字のエスケープをする

結論から書きますが、Slackで大なり小なり記号(>,<)を扱う時は、`&gt`、`&lt` にエスケープする必要があるようです。

後から知ったのですが、[Formatting text for app surfaces | Slack](https://api.slack.com/reference/surfaces/formatting#how_to_escape_characters) に書かれていました。(How to escape charactersの部分です。)

面倒くさがらずドキュメントを読んでおけばよかったなとも思いますが、膨大なドキュメントからお目当の情報を探すの難しくないです？世の中のエンジニアさんはどうやって効率よくドキュメントを引っ張ってきてるんだろう。

## 感想

エスケープしたら無事に動くようになりました。最初は正規表現周りかと思って調べてたがまさかSlackの仕様とは思いませんでした。。。その日のうちに自己解決できてよかったです。
