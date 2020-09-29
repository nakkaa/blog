---
title: Ubuntu(Linux)でNetSimutrans用のサーバーを構築する
author: なっかあ
type: posts
date: 2017-03-12T21:02:00+09:00
url: /netsimutrans-server-linux/
categories:
  - Computer
tags:
  - simutrans
---

2020-09-29追記: この記事は稀にアクセスがあるため念のため残してますが、情報が古いため現在でも使用可能かは未確認です。  
今の時代ならDocker使えばもっと楽に運用できるんじゃないかなと思ったり。追記終わり。

Simutransでマルチプレイするために、サーバーを構築する方法です。  
今回はConohaVPS上でUbuntu 16.04を使いました。

## 構築方法

### 作業用ユーザーの作成

作業用のユーザーを作成します。rootで作業をするのはよろしくないらしい。  
今回はsimuという名前のユーザーを作り、管理者権限を付与しました。

```sh
adduser simu
gpasswd -a simu sudo
```

作成したらsimuでログインできるか、管理者権限を取得できるかを確認します。  
以降の作業は作業用ユーザーで行います。

### Simutransのダウンロード

作業用ディレクトリ「tmp」を作成。

```sh
mkdir tmp
```

Simutransのソースコードをダウンロードします。現時点(2017年3月)での最新版は120.2.1でした。

```sh
wget https://sourceforge.net/projects/simutrans/files/simutrans/120-2-1/simutrans-src-120-2-1.zip/download
```

ダウンロードした、download という名前のzipファイルを解凍します。

```sh
unzip download
```

unzipしようとしたら以下のエラーが出てしまいました。

```sh
The program 'unzip' is currently not installed. You can install it by typing: sudo apt install unzip
```

ConohaVPS上のUbuntuには、デフォルトでunzipが入っていないので、unzipのインストールを行います。  

```sh
sudo apt-get install unzip
```

インストールが終わったらzipファイルを解凍します。

### ビルド

Linuxサーバー上で動かすためにビルドを行います。  tmpディレクトリに移動します。

```sh
cd tmp
```

`config.default` を開き、下記の項目を設定します。

```sh
BACKEND = posix
COLOUR_DEPTH = 0
OSTYPE = linux
```

configure.sh に実行権限をつけ実行します。

```sh
chmod +x configure.sh
./configure.sh
```

`configure.sh: error: no acceptable C compiler found in $PATH` と言われるので、Cコンパイラをインストールします。

```sh
sudo apt-get install gcc
```

今度は `configure.sh: error: C++ preprocessor "/lib/cpp" fails sanity check` と言われるのでg++をインストールします。

```sh
sudo apt-get install g++
```

このままmakeすると、 `descriptor/reader/image_reader.cc:12:18: fatal error: zlib.h: No such file or directory #include &lt;zlib.h&gt;` といわれるので zlib1g-dev をインストールします。

```sh
sudo apt-get install zlib1g-dev
```
また `dataobj/loadsave.cc:20:19: fatal error: bzlib.h: No such file or directory #include &lt;bzlib.h&gt;` も言われるので、 `libbz2-dev` をインストールします。

```sh
sudo apt-get install libbz2-dev
```

インストールが終わったらビルドします。

```sh
make
```

### get_pak.shの作成

他のサイトには get_pak.sh を実行すると書いてありますが、自分の環境ではなぜか生成されてなかったので、下記のgithubからファイルを持ってきます。  [https://github.com/aburch/simutrans/blob/master/get_pak.sh](https://github.com/aburch/simutrans/blob/master/get_pak.sh)  
get_pak.shはtmpディレクトリの中に設置します。  
get_pak.shに実行権限を付け実行し必要なpakファイルをダウンロードします。  

```sh
chmod +x get_pak.sh
./get_pak.sh
```

### get_lang_files.shの作成

get_lang_files.shも作成します。下記サイトからファイルを持ってきて、tmpディレクトリ内に設置します。  
[https://github.com/aburch/simutrans/blob/master/get_lang_files.sh](https://github.com/aburch/simutrans/blob/master/get_lang_files.sh)  
get_lang_files.shを実行します。

```sh
chmod +x get_lang_files.sh
./get_lang_files.sh
```

### 初期マップの設置

サーバーは自力でマップの生成を行ってくれないので、クライアント側で用意したファイルをサーバーのsaveディレクトリに保存します。

### ファイルの設置など

私はhome階層のSimutransフォルダとtmpフォルダ内のSimutransフォルダとsimファイルを統合しました。

### 動作確認

サーバーモードで起動できるか確認します。

```sh
./sim -server -objects pak -load save.sve
```

### 運用開始

正常に起動できたら、運用を開始します。

```sh
cd
./simutrans/sim -server 13353 -objects pak -lang ja -nomidi -nosound -load server13353-network.sve
```

※ロードするセーブファイルに初期マップを指定してしまうと、サーバー側のSimutransを再起動した際にこれまでのデータが消えてしまうらしいので気を付けましょう。  
ネットワーク対戦を開始すると作成される、 <code>server13353-network.sve</code> (13353の部分はポート番号?)が最新のマップデータだと思われます。

### systemdに登録する

このままだと、SSH接続を切るたびにSimutransが終了してしまうのでデーモン化します。  
Simutransを起動するためのスクリプトを書きます。

```sh
cd
vim start.sh
&lt;/code&gt;
```

start.shの中身は下記の通りです。

```sh
~/simutrans/sim -server 13353 -server_name hassakuServer -objects pak -lang ja -nomidi -nosound -load ../server13353-network.sve
```

次に /etc/systemd/system/へ移動し、sim.serviceというファイルを作成します。

```sh
cd /etc/systemd/system/
vim sim.service
```

sim.serviceの中身は下記の通り

```sh
[Unit]
Description=Simutrans
[Service]
User=simu
ExecStart=/bin/bash /home/simu/start.sh
```

これでSimutransを起動するときは下記のコマンドを入力するだけで済むようになりました。

```sh
sudo systemctl start sim
```

## 参考サイト

- [Simutransを自鯖で構築してみる - ejo090の日記](http://ejo090.hatenadiary.jp/entry/2013/10/30/212954)
- [ArchLinuxでsimutransサーバを建てる 2016/02 120.1.3 - みちのいに!!](http://m77.hatenablog.com/entry/2016/02/18/030501)
- [どうでもいいメモ帳: さくらVPSでSimutransを動かせた　（完結編）](http://owakon.blogspot.com/2013/06/vps-simutrans.html)
- [systemd を利用してプロセスをデーモン化する - cameong’s blog](https://cameong.hatenablog.com/entry/2016/10/18/121400)
- [Ubuntuで足りないファイルがどのパッケージにあるか調べる方法 - 組み込みの人。](https://embedded.hatenadiary.org/entry/20081101/p3)
- [ubuntu ユーザを追加して sudo 権限をつける - Qiita](https://qiita.com/white_aspara25/items/c1b9d02310b4731bfbaa)
- [Ubuntu Serverにunzipをインストール](http://web.showjin.me/ubuntu_unzip.html)
