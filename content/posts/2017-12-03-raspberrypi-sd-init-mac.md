---
title: RaspberryPi OS書き込み後のSDカードをMacでフォーマットする方法
author: なっかあ
type: posts
date: 2017-12-03T05:28:40+09:00
url: /raspberrypi-sd-init-mac/
categories:
  - Computer
tags:
  - macos
---
Raspberry Piで使っていたSDカードをフォーマットする方法です。

## 使用環境など

* Macbook Pro(macOS 10.12 High Sierra)
* microSDカード(16GB)

## フォーマット方法

Raspberry Piのフォーラム( [OS書き込み後のSDカードのフォーマットについて &#8211; Raspberry Pi Forums](https://www.raspberrypi.org/forums/viewtopic.php?f=82&t=183931) )にはフリーソフトを使えば簡単にフォーマットが行えると書かれていますが、今回はターミナルでコマンドを入力してフォーマットを実行したいと思います。
  
使用するのは `diskutil` コマンドです。
  
まず、フォーマットするSDカードがどれか確認します。

```
diskutil list
```

コマンド入力後に、接続しているハードディスク等の一覧が出るので、SDカードを探します。

```
/dev/disk2 (external, physical):
#:                       TYPE NAME                    SIZE       IDENTIFIER
0:     FDisk_partition_scheme                        *15.8 GB    disk2
1:               Windows_NTFS                         43.0 MB    disk2s1
2:                      Linux                         15.8 GB    disk2s2
```
    
見つけたので、フォーマットを行います。
  
eraseDiskのあとは フォーマット形式、ディスクの名前、フォーマット対象ディスクの順に指定します。

```
diskutil eraseDisk MS-DOS RPI disk2
```

コマンド実行後、SDカードがフォーマットされます。

## 参考サイト

  * [OS書き込み後のSDカードのフォーマットについて &#8211; Raspberry Pi Forums](https://www.raspberrypi.org/forums/viewtopic.php?f=82&t=183931)
  * [Macのディスクユーティリティーコマンドで外部ストレージをフォーマット &#8211; ytooyamaのブログ](http://ytooyama.hatenadiary.jp/entry/2017/01/07/182432)
