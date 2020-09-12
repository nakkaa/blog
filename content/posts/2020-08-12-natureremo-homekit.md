+++ 
date = 2020-08-12T19:14:53+09:00
title = "NatureRemoのエアコンと照明をHomeKit対応した"
url = "natureremo-homekit-docker"
description = "スマートリモコン「Nature Remo」に登録しているエアコンと照明をHomekit対応(RaspberryPi上にDocker使ってHomebridgeを構築)してみました。  "
categories = ["computer"]
tags = ["docker","raspberry-pi","homebridge"]
+++


## はじめに

スマートリモコン「Nature Remo」に登録しているエアコンと照明をHomekitに対応してみました。  
対応するとスマートスピーカーがなくても音声(Hey Siri)でエアコンと照明を操作できます。  
今回はRaspberryPi上にDocker(Homebridge)を使って構築します。

完成後のイメージは以下の画像みたいな感じ。

{{< tweet 1293106528514260992 >}}

## 作業環境

作業環境は以下の通りです。

* Raspberry Pi 2 Model B
  * Raspbian GNU/Linux 10 (buster)
  * Docekr 19.03
  * docker-compose 1.26.0

* Nature Remo (第一世代)

* macOS 10.15.6 (Raspberry PiへSSH接続可能なPC)

## Dockerとdocker-composeのインストール

事前にDockerとdocker-composeをRaspberry Piにインストールします。

## Homebridgeのインストールと起動

Dockerを使って[Homebridge](https://homebridge.io/)をRaspberry Pi上にインストールします。

まずは[Install Homebridge on Docker · homebridge/homebridge Wiki](https://github.com/homebridge/homebridge/wiki/Install-Homebridge-on-Docker#step-2-create-docker-compose-manifest)
にあるように `dokcer-compose.yml` を作成します。

```yml
version: '2'
services:
  homebridge:
    image: oznu/homebridge:latest
    container_name: homebridge
    restart: always
    network_mode: host
    environment:
      - TZ=Australia/Sydney
      - PGID=1000
      - PUID=1000
      - HOMEBRIDGE_CONFIG_UI=1
      - HOMEBRIDGE_CONFIG_UI_PORT=8080
    volumes:
      - ./homebridge:/homebridge
```

Homebridgeを起動します。

```sh
docker-compose up -d
```

## Homebridge Config UI Xへアクセス

Homebridgeの設定画面(Homebridge Config UI X)へアクセスします。  
ブラウザを開き `http://<Raspberry PiのIPアドレス>:8080` へアクセスします。  

ログイン画面が表示されたらユーザー名とパスワードにそれぞれ `admin` と入力してログインします。

ページに表示されているQRコードをiPhoneのホームアプリで登録します。

## Nature Remoのエアコンを登録

[homebridge-nature-remo-cloud-aircon:](https://github.com/kmaehashi/homebridge-nature-remo-cloud-aircon#readme)をインストールします。

Homebridge 設定画面上部の「プラグイン」をクリックし、検索ボックスに「nature remo aircon」と入力します。

「インストール」をクリックします。

設定画面上部の「コンフィグ」をクリックし `accessories` 配下に以下を記載します。

`accessToken` の部分は [Home](https://home.nature.global/) からアクセストークンを取得してください。

```json
{
    "accessory": "remo-sensor",
    "name": "Remo",
    "deviceName": "Remo",
    "mini": false,
    "schedule": "*/5 * * * *",
    "accessToken": "<Nature Remoのアクセストークン>",
    "sensors": {
        "temperature": true,
        "humidity": true,
        "light": true
    }
}
```

記載が完了したら、画面右上の電源マークを押して再起動します。  

ホームアプリを開いてエアコンのタイルが表示されていれば完了です。

## Nature Remoの照明を登録

[iizus/homebridge-nature-remo-cloud](https://github.com/iizus/homebridge-nature-remo-cloud#readme)
をインストールします。

Homebridge 設定画面上部の「プラグイン」をクリックし、検索ボックスに「nature remo cloud」と入力します。

「インストール」をクリックします。

設定画面上部の「コンフィグ」をクリックし `accessories` 配下に以下を記載します。

```json
{
    "accessory": "NatureRemoCloud",
    "accessToken": "<Nature Remoのアクセストークン>",
    "id": "<appliance_id>",
    "type": "light",
    "name": "電気"
}
```

`id` の部分は操作する機器の `appliance_id` を指定します。idの確認方法は以下の通りです。

まず以下のようなシェルスクリプト( `get_id.sh` )を用意します。

```sh
#!/bin/bash

TOKEN=<Nature Remoのアクセストークン>

curl -X GET "https://api.nature.global/1/appliances" \
-H "Authorization: Bearer ${TOKEN}" |jq . > memo.json
```

`get_id.sh` を実行します。

```sh
chmod +x ./get_id.sh && ./get_id.sh
```

`memo.json` を開きます。

```sh
less memo.json
```

typeが `LIGHT` のidが指定する `appliance_id` です。

```json
[
  {
    "id": "3561fefa-d499-40c0-86c5-c6b25931038c", <-- このIDではない。
    "device": {
        (snip)
    },
    "model": {
      "id": "815ee7e2-b676-4956-9198-50b3ec9f54b9", <--このIDを指定する。
      "manufacturer": "yamazen",
      "remote_name": "lc5006-ch1",
      "name": "YAMAZEN LIGHT 002",
      "image": "ico_light"
    },
    "type": "LIGHT",
    "nickname": "照明",
    "image": "ico_light",
    （snip）
```

記載が完了したら、画面右上の電源マークを押して再起動します。  

ホームアプリを開いて照明のタイルが表示されていれば完了です。お疲れ様でした。

## あとがき

2年ほど前にHomebridgeを触った時は、Raspberry Piにnpmをインストールして、  
ターミナルでconfig.jsonファイルを編集してと面倒な作業が多くてすぐに運用をやめてしまいました。  

今回はDockerを使って再挑戦しましたが、思ったより簡単に構築できて感動しています。  
`docker-compose up -d` するだけでHomebridge環境が動くのはとても楽。
ありがとうDockerとHomebridgeコミュニティの皆様。  

GUIもあるのでブラウザ上でconfig.jsonの編集ができたり、プラグインを検索してインストールできるのは便利です。

次回はCO2センサをHomekitに対応させたいなあ。。。

## 参考サイト

* [2020年最新版！ Homebridge + NatureRemoでイケイケStayHome - Qiita](https://qiita.com/sskmy1024y/items/181640b20653ae595b0a)
