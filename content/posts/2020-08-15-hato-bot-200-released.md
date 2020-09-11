+++ 
date = 2020-08-15T16:03:14+09:00
title = "Slack Bot「鳩bot」 v2.0.0をリリースしました"
url = "hato-bot-200-released"
description = "愛嬌のあるSlack用のbot「hato-bot」のv2.0.0をリリースしましたのでお知らせします。"
categories = ["Release"]
tags = ["hato-bot"]
+++

愛嬌のあるSlack用のbot「鳩bot」のv2.0.0をリリースしました。  

GitHubからダウンロードできます。  
Botの動かし方についてはリンク先のReadmeに詳しく書いてあります。

[dev-hato/hato-bot at v2.0.0](https://github.com/dev-hato/hato-bot/tree/v2.0.0)

## 以前のバージョンからの変更点

- 大きな変更点としては、新Slack API(Event API)に対応しました。  
これにより、以前のバージョンとBotの動かし方が結構変わっています。

- 新機能として `amesh [地名]` で地名の雨雲情報を取得できるようになりました。

![iamge](/img/post/2020-08-15-hato-amesh.png)

- `天気` コマンドはライブドアのAPIが提供終了となってしまったため廃止しました。

その他の詳しい変更履歴については[CHANGELOG.md at v2.0.0](https://github.com/dev-hato/hato-bot/blob/v2.0.0/CHANGELOG.md)をご確認ください。

## v2.0.0 リリースを終えて

新Slack APIに対応をしてくださった@Goryudyumaさん、PRレビューやCI周りの改善をしてくださった@massongitさん、  
Docker対応してくださった @fono09さん本当にありがとうございました。  
(私のPRレビューが遅くてリリースが遅れてしまったので申し訳なく思っています。。。)

今回はリリース前に動作確認をしたのでリリース後に慌てて修正を入れるということはありませんでした。  
(手動で確認しないと `docker-compose build` が動かないことに気づけなかったので気付ける仕組みが欲しいですね。。。)

あと毎回言ってる気がしますが、ユーザがコマンドを叩いてbotが期待値を返しているかの一連のシナリオの試験を自動化したい。。。

まあ、今月もリリースできたので全て良しということで。ではでは。

~~次回のリリースではDiscord対応できたらいいな。。。~~
