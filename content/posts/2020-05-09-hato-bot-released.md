+++ 
draft = true
date = 2020-05-09T16:05:45+09:00
title = "愛嬌のあるSlack用のbot「鳩bot」をリリースした"
description = "愛嬌のあるSlack用のbot「hato-bot」の正式版をリリースしたのでお知らせします。"
url = "hato-bot-released" 
categories = ["リリース情報"]
+++

愛嬌(？)のあるSlack用のbot「鳩bot」をリリースしました。  

# 主にできること

* 東京都心の雨雲情報を表示できます。(緯度経度を指定すれば特定の場所を表示可能です。)  
![](/img/post/2020-05-09-hato1.png)

* 直近に発生した地震情報を表示できます。  
![](/img/post/2020-05-09-hato2.png)

* メンションされた文字を突然の死吹き出しでデコレーションできます。  
![](/img/post/2020-05-09-hato3.png)

# ダウンロード

GitHubでダウンロードできます。  

[nakkaa/hato-bot: 愛嬌のあるSlack用botです。](https://github.com/nakkaa/hato-bot)

# インストール方法

Herokuを使うと楽に導入できます。  
今回はHerokuを使った方法を説明します。

## 必要なもの

* Herokuのアカウント
* Slack API Token (Botを動かすために必要。取得方法は [Slack APIのTokenの取得・場所（Legacy tokens） - Qiita](https://qiita.com/ykhirao/items/0d6b9f4a0cc626884dbb) 等を参照してください。)
* Yahoo API Token (雨雲情報を表示するために必要。取得方法は [ご利用ガイド - Yahoo!デベロッパーネットワーク](https://developer.yahoo.co.jp/start/) を参照してください。)

## Herokuへデプロイする

1. [GitHub](https://github.com/nakkaa/hato-bot)のREADME.mdにある `Deploy to Heroku` ボタンを押下します。
1. Herokuのページへ遷移します。以下のパラメータを埋めます。
    * `App name` にはわかりやすい名前(例えばhato-bot)を入力します。
    * `SLACKBOT_API_TOKEN` にSlack API Tokenを入力します。
    * `YAHOO_API_TOKEN` にYahoo API Tokenを入力します。
1. `Deploy app` を押下します。
1. Herokuの Resourcesタブを押下し、Free Dynosのスイッチをオン(右側に倒す)にします。
1. Slackのworkspaceにアクセスし、Botへメンションします。反応があればインストール成功です。お疲れ様でした。