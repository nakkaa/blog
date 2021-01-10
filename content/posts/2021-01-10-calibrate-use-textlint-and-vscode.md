+++ 
date = 2021-01-10T15:36:15+09:00
title = "MacでVS Codeとtextlintを使って文章校正を楽に行う"
url = "calibrate-use-textlint-and-vscode"
description = "VS CodeとTextlintを使って文章校正(スペルミスや禁止ワードの指摘)を楽に行う話"
categories = ["computer"]
tags = ["macos","textlint","vscode"]
+++

あけましておめでとうございます。今年もよろしくお願いします。

さて、今回は(N番煎じが否めませんが)VS Codeとtextlintを使って文章校正(誤字やスペルミスや禁止Wordの指摘)を楽にしようという内容の記事です。  
本当は2021年の目標などを書きたかったのですが、また後日ということで。

## 記事を書くまでの背景

急いでいる方は次の見出しまで読み飛ばしてしまって大丈夫です。

ここ半年ほど、仕事で後輩の書いた文章のレビューをする機会が増えました。  
レビュー時に本当は「こうしたら、読みやすい文章になるんじゃないか？」的なアドバイスをしたいのですが、
誤字脱字やスペルミスや禁止Wordを使用している等の指摘で時間を取られてしまい、なかなかできずにいました。  
レビューの時間も多い時は2〜3時間かかるため、レビュワーもレビュイーも結構な負担になっていたと思います。

そのことを知人に相談したところ、「textlintを使えば、負担は減るのではないか？」と助言をもらいました。
そこで、まずは私用のMacに導入してみることにしました。

## 前提条件

- macOS 10.15 Catalina
- VS CodeおよびHomebrewがインストールされていること。

## textlintのインストール

まずはtextlintを動かすためにNode.jsをインストールします。今回はHomebrew経由で導入します。  
インストールしたら、使用するNode.jsのバージョンを指定します。

```sh
brew install nodebrew
nodebrew install v14.15.4
nodebrew use v14.15.4
```

次にtextlintおよびtextlintのルールセットをインストールします。  
ルールセットは、文章を校正する時に使うルールの一覧のようなものです。校正対象の文章によっていくつか種類があります。  
今回は、[技術文書向けのtextlintルールプリセット](https://github.com/textlint-jatextlint-rule-preset-ja-technical-writing)を含め4種類のルールをインストールします。

```sh
npm init -y
npm install --save-dev \
    textlint \
    textlint-rule-preset-ja-technical-writing \
    textlint-rule-spellcheck-tech-word \
    textlint-rule-ng-word \
    textlint-rule-en-spell
```

インストールが完了したら、設定ファイル `.textlintrc` を作成します。  
私は以下のように書きました。

```json
{
    "rules": {
        "preset-ja-technical-writing": true,
        "spellcheck-tech-word": true,
        "en-spell": true,
        "ng-word": {
            "words": ["なので", "したい"]
        },
        "prh": {
            "rulePaths": ["./prh.yml"]
        }
    }
}
```

`prh.yml` を使うことでルールを拡張できます。  
今回はBitBucketのつづりを誤ると警告を出すルールを追加しました。

```yml
version: 1
rules:
  - expected: BitBucket
    specs:
      - from: bitbucket
        to: BitBucket
      - from: Bitbucket
        to: BitBucket
    prh: BitBucketとしてください。
```

## textlintの動作確認

textlintの動作確認をします。  
事前に以下の内容が書かれた `text.txt` ファイルを作成します。

```text
bitbucketからcloneしてPerfomance testをやろうと思います。
```

textlintを実行します。

```sh
./node_modules/.bin/textlint ./test.txt

/Users/nakkaa/textlint/test.txt
  1:1   ✓ error  bitbucket => BitBucket
BitBcuketとしてください。                prh
  1:19  ✓ error  Perfomance => Performance                en-spell
  1:39  error    弱い表現: "思います" が使われています。  ja-technical-writing/ja-no-weak-phrase

✖ 3 problems (3 errors, 0 warnings)
✓ 2 fixable problems.
Try to run: $ textlint --fix [file]
```

いくつか、警告が出ました。  
文章を修正して再実行します。

```text
BitBucketからcloneしてPerformance testをやります。
```

textlintを実行しても何も警告が表示されませんでした。  
うまく動いてくれていそうです。

```sh
./node_modules/.bin/textlint ./test.txt

```

## VS Codeに「vscode-textlint」をインストール

VS Codeでtextlintを実行してくれるように設定します。  
と言っても簡単で、拡張機能「[vscode-textlint](https://marketplace.visualstudio.com/items?itemName=taichi.vscode-textlint)」をインストールし、textlintをインストールしたプロジェクトを開けば完了です。

うまく動くと、以下の画像のように「問題」に警告が表示されます。

![img](/img/post/20210110_textlint-and-vscode.png)

## 感想

textlintときいて取っ付きづらそうというのが第一印象でしたが、丁寧な日本語の記事がいくつもあり導入するところまではできました。  助かりました。  
年々腰が重くなっているため、今年はもう少しノリで動くことを心がけても良いかもしれません。  
textlintでレビューが楽になればいいな。楽になってくれ頼む。いや楽にするぞ。

## 参考サイト

- [textlint-ja/textlint-rule-preset-ja-technical-writing: 技術文書向けのtextlintルールプリセット](https://github.com/textlint-ja/textlint-rule-preset-ja-technical-writing)
- [textlint と VS Code で始める文章校正 - Qiita](https://qiita.com/takasp/items/22f7f72b691fda30aea2)
- [textlint のインストールと基本的な使い方｜まくろぐ](https://maku.blog/p/3veuap5/#:~:text=textlint%20%E3%81%AF%E3%80%81%E3%83%86%E3%82%AD%E3%82%B9%E3%83%88%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%84,%E3%81%9F%E3%82%81%E3%81%AE%E6%A0%A1%E6%AD%A3%E3%83%84%E3%83%BC%E3%83%AB%E3%81%A7%E3%81%99%E3%80%82)
