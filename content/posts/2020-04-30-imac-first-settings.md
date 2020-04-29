+++ 
date = 2020-04-30T07:45:36+09:00
title = "Macを買った後に最初に行う設定メモ"
description = "iMacを買った時に設定した項目のメモです。"
url = "mac-first-settings" 
tags = ["macOS"]
categories = ["Computer"]
+++

Macを買った時に設定した項目のメモです。  
思い出したら追記します。

# 前提条件
* macOS 10.15.x

# システム環境設定

## ユーザとグループ
* ゲストモードをオフにする。

## セキュリティとプライバシー
* FileVault(ディスク暗号化)をオンにする。
* ファイアウォールをオンにする。

## インターネットアカウント
* Googleアカウントを登録し、メールとカレンダーにチェックを入れる。
* iCloud Driveのオプションをクリックし、 `デスクトップフォルダと書類フォルダ` のチェックボックスを外す。(iCloudの容量を消費しないようにする。)

# 導入するアプリケーション

* ウイルス対策ソフト
* VMware Fusion 10(Windowsを動かすため)
    * 仮想マシン(ゲスト側)のOSアップグレードも忘れずに行う。
* Office for Mac
* Visual Studio Code
    * 初回起動時にオプトアウトする。
* Xcode

# Finder
* ツールバーを表示する。

# Gitの初期設定

`git --version` でgitがインストールされていることを確認する。(入っていない場合は `sudo xcodebuild -license` を実行してから再度確認する。)

Gitで使うユーザ名とメールアドレスの設定を行う。(Todo: コミット署名をつけたい。)
```bash
git config --global user.name "nakkaa"
git config --global user.email "example@example.com"
```

カラーリングする
```bash
git config --global color.ui auto
```

エイリアスを設定する
```bash
git config --global alias.co checkout
```

# Visual Studio Codeの設定

* 拡張機能をインストールする。
    * zenkaku 全角スペースを視認しやすくする。
    * markdown
    * markdown-pdf converter ... markdownのテキストをPDFへ変換する。
* setting.json (Todo: Git管理したい。)
    * 空白文字に記号表示する。

# iPhone側の設定

* AirDropで本名が丸見えだったため、受信できる範囲を `受信しない` に変更する。（Macも同じく設定する）
* 連絡先はGoogleコンタクトからiCloudへ移設した。
