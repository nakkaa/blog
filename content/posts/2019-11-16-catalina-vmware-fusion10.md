---
title: macOS CatalinaでVMware Fusion10を動かす方法
author: なっかあ
type: posts
date: 2019-11-16T09:22:04+09:00
url: /catalina-vmware-fusion10/
categories:
  - Computer
tags:
  - macOS
  - macApp
---
 

自宅のMacをmacOS Catalinaにアップグレードしたら、VMware Fusion10が動かなくなってしまったので直しました。また同じ事象にハマりそうなので記事にすることにしました。

**実行は自己責任でお願いします。以下の手順を実施することにより発生した損害について私は一切の責任を負いません。**

2020年9月22日 追記:  
2020年9月に非商用目的ならば無償で使えるVMware Fusion 12 Playerがリリースされました。  
もし、個人利用ならばVMware Fusion 12を使うことをお勧めします。  
[無償になったVMware Fusion 12 PlayerをmacOSにインストールした · としつーる](https://7ka.org/vmware-fusion-12-player-install-mac/)

## 動作環境

  * macOS Catalina 10.15.1 (19B88)
  * VMware Fusion 10.1.6 (12989998)

## 事象

macOS MojaveからCatalinaへアップグレード後、VMware Fusionで仮想マシンを起動すると画面が真っ黒なままな事象に遭遇しました。macを再起動しても事象は解決しませんでした。

起動しても画面が真っ黒なままの図

![](/img/wp/20191116-mac2-1024x827.png)

ただ、仮想マシンのライブラリからでは画面が確認できます。

![](/img/wp/20191116-mac-1024x697.png)

## 原因

Webで検索すると同じような事象の人がいるようで、[VMwareのフォーラムに記事](https://communities.vmware.com/thread/611933?start=15&tstart=0https://communities.vmware.com/thread/611933?start=15&tstart=0)が投稿されていました。

結論から書くと、Catalinaから「画面収録」の許可をする必要になったそうです。  
ですので、許可すると動くようになります。

ただし、残念なことに「画面収録」の設定にVMware Fusion 10は出てきません。  
そこで以下の解決策を実施します。

## 解決策

以下の解決策はmacOSのSystem Integrity Protection (SIP。Macのセキュリティ機能)を一時的に無効化する手順が含まれています。また内容の正確さについては保証しません。  
もし実施したくない場合は素直にVMware Fusionの最新版を買ってください。

1. Macをリカバリーモードにします。(Macを再起動し、Appleのロゴマークが出るまでCMD+Rキーを押し続けます)
2. メニュー上部からターミナルを開きます。
3. SIPを無効化(`csrutil disable` )します。
4. Macを再起動します。
5. ターミナルを起動し以下のコマンドを入力します。
```bash
tccutil reset All com.vmware.fusion
sudo sqlite3 "/Library/Application Support/com.apple.TCC/TCC.db" 'insert into access values ("kTCCServiceScreenCapture", "com.vmware.fusion", 0, 1, 1, "", "", "", "UNUSED", "", 0,1565595574)'
sudo sqlite3 "/Library/Application Support/com.apple.TCC/TCC.db" 'insert into access values ("kTCCServiceListenEvent", "com.vmware.fusion", 0, 1, 1, "", "", "", "UNUSED", "", 0,1565595574)'
sudo sqlite3 "/Library/Application Support/com.apple.TCC/TCC.db" 'insert into access values ("kTCCServicePostEvent", "com.vmware.fusion", 0, 1, 1, "", "", "", "UNUSED", "", 0,1565595574)'
```
6. 再度Macをリカバリーモードにしターミナルを開きます。
7. SIPを有効化(`csrutil enable`)します。
8. Macを再起動します。
