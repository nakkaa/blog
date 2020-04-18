---
title: Raspberry Pi 2 rootパスワード設定やユーザ名の変更をする
author: なっかあ
type: post
date: 2019-03-24T08:29:37+00:00
url: /raspberry-pi-2-root-pass-change/
categories:
  - コンピュータ
tags:
  - Raspberry Pi

---

Raspberry Pi 2のセットアップ記事です。  
rootパスワード設定やユーザ名の変更を実施します。

## 前提条件

* Raspberry PiへSSH接続できること。

## rootパスワードを設定する

rootパスワードを設定します。Raspberry Piへログインし以下のコマンドを入力します。

```
passwd
```

その後、パスワードを入力します。



## ユーザ名を変更する

デフォルトのユーザ名はpiですが、これを自分のユーザ名へ変更(新規作成)します。  
コマンドは `sudo adduser [ユーザ名]` です。

```
pi@raspberrypi:~ $ sudo adduser nakkaa
```
パスワードを聞かれるので入力します。  
Full Nameなどは好みで入力してください。(Enterで入力をスキップできます。)  
最後に yキーを押して完了です。

CLI出力例
```
Adding user `nakkaa' ...
Adding new group `nakkaa' (1001) ...
Adding new user `nakkaa' (1001) with group `nakkaa' ...
Creating home directory `/home/nakkaa' ...
Copying files from `/etc/skel' ...
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully
Changing the user information for nakkaa
Enter the new value, or press ENTER for the default
	Full Name []: 
	Room Number []: 
	Work Phone []: 
	Home Phone []: 
	Other []: 
Is the information correct? [Y/n] y
```

次に、上記で作成したユーザに管理者権限を付与します。  
コマンドは `sudo adduser [ユーザ名] sudo` です。

CLI出力例
```
pi@raspberrypi:~ $ sudo adduser nakkaa sudo
Adding user `nakkaa' to group `sudo' ...
Adding user nakkaa to group sudo
Done.
```

一旦ログアウトし、作成したユーザでログインします。  
ログインできることを確認したら、piユーザを削除します。  
コマンドは `sudo deluser pi` です。

CLI出力例
```
nakkaa@raspberrypi:~ $ sudo deluser pi
[sudo] password for nakkaa: 
Removing user `pi' ...
Warning: group `pi' has no more members.
Done.
```

## あとがき

他にも、sudoするときはパスワードを要求するようにしたり、SSHは公開鍵認証を用いるようにした方が好ましいですが、自宅のローカルLAN内でのみ使用するので今は実施しません。  
(そのうちやりたいですが。)

## 参考サイト

以下の公式ドキュメントを参考にしました。

* [Securing your Raspberry Pi - Raspberry Pi Documentation](https://www.raspberrypi.org/documentation/configuration/security.md)
