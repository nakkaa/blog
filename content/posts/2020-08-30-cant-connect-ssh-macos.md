+++ 
date = 2020-08-30T17:24:07+09:00
title = "macOS CatalinaでSSH接続が失敗(client_loop: send disconnect: Broken pipe)する"
url = "cant-connect-ssh-macos"
description = "macOS Catalinaでssh接続すると、client_loop: send disconnect: Broken pipeが発生したので解決策を書く。"
categories = ["computer","mac"]
tags = ["macos","ssh",]
+++

macOS Catalinaでssh接続すると、 `client_loop: send disconnect: Broken pipe` が発生しSSH接続が
失敗する事象を引きました。  
また引くかもしれないので解決策をここにメモしておきます。

## 動作環境

* macOS Catalina 10.15.6
* OpenSSH_8.1p1, LibreSSL 2.7.3 (`ssh -V` で確認)

## 発生事象

macOSからAというサーバへSSH接続する時に `client_loop: send disconnect: Broken pipe` が発生して
SSH接続が失敗します。  
同じ.ssh/configを使ってRaspberry Piでは接続できるため、configは間違っていなさそうです。

## 解決策

SSH接続する時に、 `IPQoS=0` を指定します。

## 解決策へ至る道

sshのデバッグオプション `ssh -vvv` を使ってデバッグログを表示してみます。

```sh
ssh -vvv
(snip)
debug2: channel_input_open_confirmation: channel 0: callback done
debug2: channel 0: open confirm rwindow 0 rmax 32768
debug3: send packet: type 1
client_loop: send disconnect: Broken pipe
```

うーん、さっぱりわかりません。  

(知人と)Webの力を借りると以下の記事が引っかかりました。

[Can't complete SSH connection after successfully exchanging keys to Ubuntu from some networks](https://serverfault.com/questions/692026/cant-complete-ssh-connection-after-successfully-exchanging-keys-to-ubuntu-from#)

記事に書かれている事象は私と同じ `debug2: channel 0: open confirm rwindow 0 rmax 32768` ようです。
記事には以下にようにあります。

> I have heard talk about NAT boxes which cannot
handle change of TOS during a TCP connection.
The problem in your case does happen after the client indicates that
TOS has been changed.

雑に日本語訳すると『私(回答者)はNAT box がTCP接続中にTOSを変更操作できない話を聞いたことがあります。
あなたのこの問題は、クライアントがTOSが変更されたことを示した後に起こります。』でしょうか。

そもそもTOSについてわからないので、
[TOSフィールド（DSフィールド）とは - IT用語辞典 e-Words](http://e-words.jp/w/TOS%E3%83%95%E3%82%A3%E3%83%BC%E3%83%AB%E3%83%89.html)
を見ると以下のようにあります。

> TOSフィールドとは、IPv4データグラムのヘッダを構成するフィールドの一つで、転送の優先順位などを示すもの。先頭から9～16ビット目の8ビット（1バイト）を使用する。

TOSはType Of Serviceの略で、転送時の優先順位を表すことができるようです。  
いまいちピンと来ないので「マスタリングTCP/IP 入門編」を見ると「送信しているIPのサービス品質を表します」とありました。
遅延、スループット、信頼性、経費の中からどれを優先するか指定するためのフォールドのようです。  
ただし、現在のところではTOSでの制御を実現することが難しいためほとんどのネットワークではこれらの要求は無視されます。

このTOSの変更が発生することによって生じるのなら、変更しなければいいのでは？と記事の続きを読みます。

> You can also try the IPQoS option. If the change of TOS is the issue,
then specifying -o IPQoS=cs0 or -o IPQoS=0 should work but
any other setting would fail.
This is because ssh is using 0 as the QoS during authentication and
then switch to the chosen QoS after authentication.
By choosing QoS to be 0 there won't be any change of QoS value to
confuse middleboxes.

日本語訳すると『IPQoSも試してください。もしTOSの変更が問題ならば、IPQoS=0を設定することでうまくいくはずです。
ただし、それ以外は失敗します。なぜならSSHは0を認証中にQoSに0を指定し認証後にQoSの値を切り替えるためです。
QoSを0にすることでミドルボックスを混乱させる変更は起きないでしょう。』でしょうか。

どうやら接続時に `IPQoS=0` を指定してあげるよと良さそうです。  
.ssh/configに書く場合は以下のように `IPQoS 0` を追加します。

```text
Host A
        HostName A.jp
        IPQoS 0
        User hoge
        IdentityFile /Users/hoge/.ssh/key_hoge
```

これでSSH接続できるようになりました。

ところで、IPQoSってなんだ？ってなりますよね。  
私もなったので調べたのですが、納得できる情報が見つけることができませんでした。

ssh_configのマニュアル ([ssh_config(5) - Linux manual page](https://man7.org/linux/man-pages/man5/ssh_config.5.html))
にはIPQoSの記載があったのですが、「接続のためのIPv4タイプオブサービスまたはDSCPクラスを指定します。」とだけあります。

記事中に
> ssh is using 0 as the QoS during authentication

とあるように、SSHの認証時はIPQoSは0で動作するから、認証後の通信も0を指定すれば動くのは理解したのですが、
そもそも0ってなんだよってなりますね。数字が低い方が優先度が下がるから低優先ってことでしょうか。。。

いつかわかる時が来ることを信じてこの辺で調べるのをやめました。

## 所感

ネットワークさっぱりわからない。僕は雰囲気でネットワークを触っている。
