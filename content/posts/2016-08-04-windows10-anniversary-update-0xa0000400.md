---
title: Windows10 Anniversary Update が0xA0000400エラーでインストールできない
author: なっかあ
type: posts
date: 2016-08-03T16:51:57+09:00
url: /windows10-anniversary-update-0xa0000400/
dsq_thread_id:
  - 5777962583
categories:
  - Windows
tags:
  - Windows10

---

**2016年8月9日 追記: この事象は、私の環境では解消しました。以下の記事は念のため残しています。**

## 前提条件

* Windows10 Education

## 発生事象

昨日リリースされたWindows10 Anniversary Updateを、自宅のWindows10 Educationへインストールしようしたところ、エラーコード「0xA0000400」が出てしまいました。

![image](/img/wp/win10-error-0xA0000400.png)

## 解決策
  
Windows Updateをしても、Anniversary Updateへアップデートできません。  
[Windows 10 の更新履歴](https://support.microsoft.com/ja-jp/help/12387/windows-10-update-history?ocid=update_setting_client)のページからWindows10 アップグレードアシスタントをダウンロードし、Windows10 Anniversary Updateをインストールもトライしてみましたがエラーで先へ進めませんでした。
  
調べてみたところ以下の記事が引っかかりました。  
[Windows 10 Anniversary Update Error Code 0xA0000400](http://answers.microsoft.com/en-us/windows/forum/windows_10-windows_install/windows-10-anniversary-update-error-code/70d02245-59b5-466e-9187-4131bc559150)を見ると、どうやらWindows10 Education上での問題らしいです。
  
マイクロソフト側が修正してくれるまで、気長に待つことにします。
