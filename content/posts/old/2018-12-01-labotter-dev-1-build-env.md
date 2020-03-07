---
title: PHP開発環境構築 MAMP+VSCode+PHP Debugを導入する
author: なっかあ
type: post
date: 2018-12-01T12:51:29+00:00
url: /labotter-dev-1-build-env/
categories:
  - Computer
tags:
  - PHP

---
  
PHPの開発環境をMac上に準備します。

## 前提条件

* macOS
* VS Codeがインストール済み
* MAMPがインストール済み

## MAMPのインストール

PHP、MySQLの環境を作るために、MAMPをインストールします。

### PHPの動作確認

ブラウザでアクセスしPHPが動作するか確認します。
  
以下のファイルをMAMPのDocument Root配下に設置します。

```php
phpinfo();
```

私の環境ではPHP 7.2.1でした。

## エディタのインストール

Visual Studio Code (以下VS Codeと表記) をインストールします。

## PHP開発用に拡張機能を導入

VS Codeに PHP IntelliSenseとPHP Debugをインストールします。
  
以下の記事を参照しました。

[PHPプログラミングも快適に！ VS Codeの二大拡張機能 (1/3)：Visual Studio Code＋PHPの可能性を探る - ＠IT](https://www.atmarkit.co.jp/ait/articles/1809/11/news028.html)

### デバッグ用の設定を追加

PHP Debugを使えるようにするために[Xdebug - Debugger and Profiler Tool for PHP](https://xdebug.org/)の設定が必要なようです。

ところで、Xdebugってなんでしょう。気になって公式サイトを見ました。

> Xdebug is an extension for PHP to assist with debugging and development.  
> [Xdebug - Debugger and Profiler Tool for PHP](https://xdebug.org/)

PHPのデバッグと開発を補助してくれる拡張機能のようですね。はー便利なものもあるもんだ。

追加でインストールが必要なのかと思いましたが、MAMPにはすでにXdebugが同梱されているため不要です。ただし無効化されているため有効化します。
  
以下のサイトを参考にphp.iniを編集します。

[MACにMAMP、NetBeans、XdebugでPHPをトレースする方法 - Qiita](https://qiita.com/y-ta/items/fc54af35026550eb5bc6)

格納場所を確認します。

```
$ find /Applications/MAMP -name "php.ini" | grep 7.2.1
/Applications/MAMP/bin/php/php7.2.1/conf/php.ini
```

php.iniの最終行の ; を外し、2行ほど追記します。

```
[xdebug]
zend_extension="/Applications/MAMP/bin/php/php7.2.1/lib/php/extensions/no-debug-non-zts-20170718/xdebug.so"
xdebug.remote_enable = 1
xdebug.remote_autostart = 1
```
    
MAMPを再起動し、先ほどの動作確認用PHPへアクセスします。
  
Xdebugの項目が表示されれば大丈夫です。

試しに、ブレークポイントを貼ってページをリロードすると、ちゃんと止まってくれました！

![image](https://7ka.org/wp-content/uploads/2018/12/20181201-php-debug-768x534.png)

以上です。