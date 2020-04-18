---
title: Macのメールアプリで「Liveメール」を送受信する
author: なっかあ
type: post
date: 2014-08-30T13:00:53+00:00
url: /mac-use-livemail/
categories:
  - Mac

---
Macにデフォルトで入っているメールアプリで、Microsoftが提供している「Liveメール」(今はoutlook.comだけど)を受信したい。
  
GMailはすんなり受信できましたが、調べてみるとLiveメールは少し面倒くさいようです。

## 前提条件

* macOS 10.9

## 設定方法
  
メールを起動し、環境設定を開きます。
  
「アカウント」をクリックし、左下の「+」をクリックします。
  
![image](/img/wp/20140830_mac_livemail_1-400x410.png)
  
「その他のメールアカウント」をクリックし「続ける」をクリックします。

![image](/img/wp/20140830_mac_livemail_2-400x339.png)
  
メールアカウントを追加の画面が出てきます。

* 氏名に自分の名前(ハンドルネームとか)
* メールアドレスに自分のLiveメールのアドレス
* パスワードにメールアカウントのパスワードを入力します。
  
入力し終わったら「作成」をクリックします

![image](/img/wp/20140830_mac_livemail_3-400x301.png)

  
次にメールの受信方法を選択します。

* アカウントの種類は「IMAP」をクリック
* メールサーバは「imap-mail.outlook.com」
* ユーザー名は、前の画面で入力したメールアドレス
* パスワードも前の画面で入力したものと同じです。

![image](/img/wp/20140830_mac_livemail_4-400x332.png)

ポートが「993」になっていること、「SSLを使用」にチェックが入っていることを確認して「次へ」

![image](/img/wp/20140830_mac_livemail_5-400x332.png)
  
SMTPサーバーに「smtp-mail.outlook.com」と入力し、
  
ユーザー名に先ほど入力したメールアドレスを、パスワードに先ほど入力したものと同じパスワードを入力します。
  
「作成」をクリックし設定は終わりです。

![image](/img/wp/20140830_mac_livemail_6-400x301.png)


## 参考サイト
  
[Outlook.com でメール アプリをセットアップする](http://windows.microsoft.com/ja-jp/windows/outlook/send-receive-from-app)