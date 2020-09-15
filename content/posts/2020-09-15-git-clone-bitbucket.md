+++ 
date = 2020-09-15T22:35:18+09:00
title = "MacからBitbucketにSSH接続でgit cloneする方法"
url = "git-clone-bitbucket"
description = "MacからBitbucketにSSH接続(公開鍵認証)でgit cloneする方法"
categories = ["computer"]
tags = ["macos","ssh","Bitbucket"]
+++

MacからBitbucketにSSH接続(公開鍵認証)で `git clone` する手順を説明します。

## 問題

Bitbucketからgit cloneしようとしたら、以下のエラー `Permission denied (publickey).` が発生しました。  

```sh
git clone git@bitbucket.org:hoge/secret.git
(snip))
git@bitbucket.org: Permission denied (publickey).
fatal: Could not read from remote repository.
Please make sure you have the correct access rights
and the repository exists.
```

非公開リポジトリをcloneする場合は、SSH鍵が必要です。  
そこで、鍵を作成しBitbucketへ登録します。

## 環境

- macOS 10.15.6 Catalina
- Bitbucketのアカウントが存在すること。

## 鍵の作成

まずは、公開鍵の作成を行います。ターミナルを開いて以下のコマンドを入力します。  
`-C` の後はメールアドレス等を入力します。

```sh
ssh-keygen -t rsa -b 4096 -C "example@example.com"
```

すると、以下のように鍵の作成場所を聞かれます。  

```sh
Enter file in which to save the key (/Users/hoge/.ssh/id_rsa): 
```

デフォルトのままでも良いですが、 `bitbucket_key` という名前にしたい場合は以下のように入力します。

```sh
Enter file in which to save the key (/Users/hoge/.ssh/id_rsa): /Users/hoge/.ssh/bitbucket_key
```

鍵のパスフレーズ(鍵を使う時に必要なパスワードのようなもの。空にもできますが設定することをお勧めします。)を入力します。  
これは2回入力を求められます。

```sh
Enter passphrase (empty for no passphrase):
Enter same passphrase again: 
```

最後に変な模様が出たら作成完了です。

## 公開鍵の登録

続いてBitbucketに公開鍵を登録します。  
まずは先ほど作成した公開鍵の値をコピーします。  

```sh
cat ~/.ssh/bitbucket_key.pub | pbcopy
```

ブラウザで[アカウント設定 — Bitbucket](https://bitbucket.org/account/settings/)を開きます。  
左下の「SSH 鍵」をクリックします。  
「鍵を追加」ボタンをクリックし、 `key` 部分に先ほどコピーした公開鍵の文字列を貼り付けます。  
「鍵の追加」ボタンをクリックすれば完了です。

## ~/.ssh/config の設定

続いてsshのconfigファイルを作成します。  
ここにBitbucketへ接続する時に、今回作成した鍵を使って認証するように設定を追加します。
`vim ~/.ssh/config` をしたら以下を入力して保存します。

```sh
Host bitbucket.org
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/bitbucket_key
```

これで準備完了です。

## git cloneしてみる

では、git cloneしてみます。  
`Enter passphrase for key` と聞かれたら、先ほど設定したパスフレーズを入力してください。

```sh
% git clone git@bitbucket.org:hoge/secret.git
Cloning into 'secret'...
(snip))
Enter passphrase for key '/Users/hoge/.ssh/bitbucket_key': 
remote: Counting objects: 4, done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 4 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (4/4), done.
```

以上です。

## 参考サイト

- [GitHub に SSH で接続する \- GitHub Docs](https://docs.github.com/ja/github/authenticating-to-github/connecting-to-github-with-ssh)

## 修正履歴

- マウスでコピーするより、pbcopy使った方が楽ですね。情報提供ありがとうございます。pbcopyを使う手順に修正しました。(2020/09/15)
