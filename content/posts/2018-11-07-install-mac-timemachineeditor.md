---
title: MacのTimeMachineバックアップの頻度を変更する
author: なっかあ
type: posts
date: 2018-11-07T13:33:34+09:00
url: /install-mac-timemachineeditor/
categories:
  - Mac
tags:
  - macOS

---
MacのTimeMachineのバックアップ頻度を変更するため、「TimeMachineEditor」というアプリを導入しました。

## はじめに

MacにはTimeMachineという定期的にデータのバックアップを取ってくれる便利な機能があります。
  
が、TimeMachineの自動でバックアップを有効にしている場合、1時間に1回の高頻度でバックアップを取ります。
  
流石にそれでは多すぎるため、1週間に1度くらいの頻度にしたいのですが、残念ながらデフォルトの設定には用意されていません。
  
かといって、手動でバックアップを取るのは忘れそうだし嫌なため、頻度を変更できるアプリがないか探したところ、以下のサイトを見つけました。

[Time Machine &#8211; バックアップ・スケジュールを設定 &#8211; アプリ「TimeMachineEditor」 &#8211; PC設定のカルマ](https://pc-karuma.net/mac-app-timemachineeditor/)

どうやら、「TimeMachineEditor」というアプリを使えば、バックアップの頻度変更を実現できそうです。

## TimeMachineEditorのダウンロード

TimeMachineEditorは以下のサイトから無料でダウンロードできます。
  
動作環境はmacOS 10.9以上。Mojaveにも対応しています。

[TimeMachineEditor](https://tclementdev.com/timemachineeditor/)

## スケジュールを設定する

早速、毎週土曜日の朝6時にバックアップするようにスケジュールしました。
  
手順は以下の通り。

  * 「Back up」にチェックを入れ「カレンダー」を選択。
  * バックアップを「土曜日」に、時刻を「6:00」にします。
  * 最後に「適用」を押します。

![image](/img/wp/tme-20181107-768x525.png )

設定が適用されると、TimeMachimeの環境設定ウィンドウの「バックアップを自動作成」のチェックが外れます。

## あとがき

Macをスリープ状態にし土曜日を迎えたところ、朝6時にしっかりとバックアップを取ってくれたようです。よかった〜。
  
アプリ自体は大体日本語化されているため、とっつきにくさを感じませんでした。ありがたや。
  
macOS側でバックアップの頻度を設定できるようにしてくれるのが一番なのですが、設定項目がごちゃごちゃ増えるようなことAppleはやらないでしょうね。しばらくはこのアプリのお世話になると思います。
