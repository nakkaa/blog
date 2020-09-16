+++ 
date = 2020-09-16T22:47:24+09:00
title = "MacのmanをGoogle翻訳にかけるコマンドを作ろうとした話"
url = "mac-man-translate-ja"
description = "Macのmanコマンドの内容をGoogle翻訳にかけるコマンドを作ろうとしたがうまくいかなかった"
categories = ["computer"]
tags = ["macos","man",]
+++

macOSのmanコマンドの内容をGoogle翻訳にかけるコマンドを作ろうとしたが、うまくいかなかった話です。

## 作業環境

- macOS 10.15.6 Catalina
- curl, jq コマンドが使用可能であること

## 背景

manコマンドの結果が英語だと読むハードルが高いという話を聞き、
「だったらmanの内容をGoogle翻訳にかけるコマンドを作ればいいじゃん。」と思ったのがきっかけです。  

巷にはmanコマンドを日本語化する方法もあります。  
しかしmacOSだと(GNUではないコマンドもあるので)不正確なマニュアルを使うことになりそうだったので嫌だなあと思い今回は不採用としました。

{{<tweet 1305875741943324672>}}

### manコマンドとは何か

そもそも、manコマンドとは何かという方もいらっしゃるかもしれないので簡単に説明すると、  
コマンドの“レファレンスマニュアル”を表示するためのコマンドです。
([【 man 】コマンド（基本編）――コマンドのレファレンスマニュアルを表示する：Linux基本コマンドTips（86） - ＠IT](https://www.atmarkit.co.jp/ait/articles/1702/16/news016.html)より)

例えば、 `man ls` と入力することで `ls` コマンドの使い方(マニュアル)を表示してくれます。便利です。  
ただ、macOSの場合は英語で表示されるので、母語が日本語の人にはとっつきづらい印象があるようです。

## GASでGoogle翻訳を使う

今回は、以下のような仕組みで実現しようと考えました。

1. (macOS側で)manコマンドの内容をGoogle翻訳へPOSTする。
2. (macOS側で)Google翻訳の結果をjsonで受け取る。
3. (macOS側で)翻訳結果をターミナルに表示する。

ただ、Google翻訳のAPIは従量課金制のため、以下のサイトを参考にGASを使うことにしました。

[Google翻訳APIを無料で作る方法 - Qiita](https://qiita.com/satto_sann/items/be4177360a0bc3691fdf)

この記事ではGETリクエストで受け付けていますが、manコマンドの結果は文字列が長いのでGETでパラメータを付与できません。  
そこでPOSTリクエストを使います。

```js
function doPost(e) {
    // リクエストパラメータを取得する
  var params = JSON.parse(e.postData.getDataAsString());
  var text = params.text;
  var dec = Utilities.base64Decode(text)
  var dec2 =Utilities.newBlob(dec).getDataAsString()
    //  LanguageAppクラスを用いて翻訳を実行
    var translatedText = LanguageApp.translate(dec2, "en", "ja");
    var translatedText2 = Utilities.base64Encode(translatedText, Utilities.Charset.UTF_8)
    // レスポンスボディの作成
    var body;
    if (translatedText) {
        body = {
          code: 200,
          text: translatedText2
        };
    } else {
        body = {
          code: 400,
          text: "Bad Request"
        };
    }
    // レスポンスの作成
    var response = ContentService.createTextOutput();
    // Mime TypeをJSONに設定
    response.setMimeType(ContentService.MimeType.JSON);
    // JSONテキストをセットする
    response.setContent(JSON.stringify(body));

    return response;
}
```

jsonで受け取る方法は以下のサイトを参考にしました。

- [Google Apps ScriptのdoPostでJSONなパラメータのPOSTリクエストを受ける - Qiita](https://qiita.com/shirakiya/items/db22de49f00710478cfc)

また、manコマンドのテキストはそのまま投げられないため、BASE64エンコードをしてからGASへ投げるようにしています。  
BASE64のエンコードとデコードについては以下のサイトを参考にしました。

- [タイトル思考中・・・ぷらすあるふぁ:GASでbase64エンコードデコード - livedoor Blog（ブログ）](http://blog.livedoor.jp/yami1plus/archives/52340063.html)

GASのURLにcurlでPOSTリクエストを投げると、翻訳結果が取れるようになったはずです。  
早速、POSTするためのシェルスクリプト(ファイル名は `manj.sh` )を用意して実行します。

```sh
#!/bin/bash

cmd=$1
text=`man ${cmd} |base64`

ja=`curl -L -Ss https://script.google.com/macros/s/AKfycbwhIko5MFRJpB7wG6IqeblFxqCyF9ow4sPtVXwAElzFO-J47kw/exec -d '{"text":"'$text'"}'`

echo ${ja} |jq .text | cut -d '"' -f2 |base64 -d |less
```

実行コマンド

```sh
./manj base64
```

実行するとターミナルに以下のような結果が表示されます。

{{<tweet 1305897405032742913>}}

```text
base64（1）BSD General Commands Manual base64（1）

N NA AM ME E
     b ba as se e6 64 4-Base64表現を使用してエンコードおよびデコード

S SY YN NO OP PS SI IS S
     b ba as se e6 64 4 [--h h | --D D | --d d] [--b b _ c_ o_ u_ n_ t] [--i i _ i_ n_ p_ u_ t_ __ f_ i_ l_ e] [--o o _ o_ u_ t_ p_ u_ t_ __ f_ i_ l_ e]

D DE ES SC CR RI IP PT TI IO ON N
     RFC 4648で指定されているように、b ba as se e6 64 4はBase64データをエンコードおよびデコードします。
     オプション、b ba as se e6 64 4は標準データから生データを読み取り、エンコードされたデータをaとして書き込みます
     stdoutへの連続ブロック。

NS SのO OP PT TI IO
     次のオプションを使用できます。
     --b b _ c_ o_ u_ n_ t
     ---b br re ea ak k = = _ c_ o_ u_ n_ t _ c_ o_ u_ n_ t文字ごとに改行を挿入します。デフォルト
                          は0で、途切れのないストリームを生成します。

     --d d
     --D D
     ---d de ec co od de e着信Base64ストリームをバイナリデータにデコードします。

     --h h
     ---h he el lp p使用法の要約を出力して終了します。

     --i i _ i_ n_ p_ u_ t_ __ f_ i_ l_ e
     ---i in np pu ut t = = _ i_ n_ p_ u_ t_ __ f_ i_ l_ e _ i_ n_から入力を読み取るp_ u_ t_ __ f_ i_ l_ e。デフォルトはstdinです。パス-
                          ing--もstdinを表します。

     --o o _ o_ u_ t_ p_ u_ t_ __ f_ i_ l_ e
     ---o ou ut tp pu ut t = = _ o_ u_ t_ p_ u_ t_ __ f_ i_ l_ e
                          出力を_ o_ u_ t_ p_ u_ t_ __ f_ i_ l_ eに書き込みます。デフォルトはstdoutです。
                          passing--stdoutも表します。

S SE EE E A AL LS SO O
     openssl（1）、w wi ik ki ip pe ed di ia ap pa a g ge e <http://en.wikipedia.org/wiki/Base64>、R RF FC C
     4 46 64 48 8 <http://tools.ietf.org/html/rfc4648>

Mac OS X 10.7 2011年2月8日Mac OS X 10.7
```

## あとがき

確かにmanの内容にGoogle翻訳を適用することはできました。が、可読性に難ありです。  
使い勝手をよくするには、翻訳する文章を指定するなど工夫が必要ですね。  
余力があったらトライしてみようと思います。(多分しない)

思わぬ収穫だったのは、GASでGoogle翻訳を使うのが思った以上にお手軽だったことです。  
GASを使えば、[hato-bot](https://github.com/dev-hato/hato-bot)に翻訳機能を搭載することも簡単にできそうですね。
