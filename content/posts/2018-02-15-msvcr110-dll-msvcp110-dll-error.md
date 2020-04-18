---
title: MSVCR110.dll、MSVCP110.dllが見つからないためコードの続行ができません エラーの対応法
author: なっかあ
type: posts
date: 2018-02-15T13:18:47+09:00
url: /msvcr110-dll-msvcp110-dll-error/
categories:
  - Windows

---
## 事象

Windows10 64bitでゲーム(Simutrans Experimental)を起動しようとしたら以下のエラーが出て起動できませんでした。

* 「MSVCR110.dllが見つからないためコードの続行ができません 」
* 「MSVCP110.dllが見つからないためコードの続行ができません 」

![image](/img/wp/smtr_msvcp110_error-1.png)
  
![image](/img/wp/smtr_msvcr110_error-1.png)

## 原因

ググってみると、以下のサイトでVisual C++ 再頒布可能パッケージがないとエラーが出るようです。  
下記リンクから、Visual C++ 再頒布可能パッケージをダウンロードし、インストールする必要があります。
  
[Visual Studio 2012 更新プログラム 4 の Visual C++ 再頒布可能パッケージ](https://www.microsoft.com/ja-JP/download/details.aspx?id=30679)

## 対処手順

以下の手順を実施します。

1. 上記のリンク先を開き、「ダウンロード」ボタンを押下します。
2. 32bit版を動かすならば、「VSU4vcredist_x86.exe」に、64bit版のソフトウェアを動かすときは「VSU4vcredist_x64.exe」にチェックを入れます。
3. 「次へ」ボタンを押下し、ダウンロードします。
4. インストール後、起動できることを確認します。

以上です。

## 参考

[Windows 10にアップグレードしたらMSVCR110.dllが無いのでプログラムがスタートできない、というエラーがでる &#8211; マイクロソフト コミュニティ](https://answers.microsoft.com/ja-jp/windows/forum/windows_10-performance/windows/e097d585-c9f1-4c37-bb91-156f7310171c)
