+++ 
date = 2020-08-23T20:18:51+09:00
title = "起動しないバグを修正した Slack Bot「鳩bot」 v2.0.1をリリース"
url = "hato-bot-201-released"
description = "起動しないバグを修正した Slack Bot「鳩bot」 v2.0.1をリリースしました。"
categories = ["リリース情報"]
tags = ["hato-bot"]
+++

前のリリース告知から日が経っていませんが、Slack用のbot「鳩bot」のv2.0.1をリリースしました。  
このバージョンでは新規デプロイした際に起動しないバグを修正しました。

GitHubからダウンロードできます。  
動かし方についてはリンク先のReadmeをご確認ください。  

[dev-hato/hato-bot at v2.0.1](https://github.com/dev-hato/hato-bot/tree/v2.0.1)

## v2.0.0からの変更点

- docker-compose up で鳩botが起動しない問題を修正しました。(#281)
- post_command.py が動作しない問題を修正しました。(#270)
- 初回起動時に不要なテーブルをデータベースに作成する問題を修正しました。(#231)

## v1.1.0からの変更点

- 大きな変更点としては、新Slack API(Event API)に対応しました。  
これにより、以前のバージョンとBotの動かし方が結構変わっています。

- 新機能として `amesh [地名]` で地名の雨雲情報を取得できるようになりました。

![iamge](/img/post/2020-08-15-hato-amesh.png)

- `天気` コマンドはライブドアのAPIが提供終了となってしまったため廃止しました。

その他の詳しい変更履歴については[CHANGELOG.md at v2.0.1](https://github.com/dev-hato/hato-bot/blob/v2.0.1/CHANGELOG.md)をご確認ください。
