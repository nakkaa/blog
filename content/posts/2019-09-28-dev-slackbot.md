---
title: MacでSlackBot開発をしてみた
author: なっかあ
type: posts
date: 2019-09-28T14:04:34+09:00
url: /dev-slackbot/
categories:
  - Computer
tags:
  - Python
  - Slack
---
PythonでSlackのBotを作りたくなり、環境構築から実際に動作確認するまでやってみました。  
ちなみにこの記事は [PythonのslackbotライブラリでSlackボットを作る &#8211; Qiita][1] を参考に実施しました。リンク先のページに詳しい説明がされています。

今回作るのは以下の画像のように、Bot宛にメッセージを送ると返事をしてくれるやつです。

![](/img/wp/20190928-bot.png)

## 必要なもの

* Homebrewが動くMac (Mojave 10.14.6で確認)
* Bot用のSlack API Token

## 環境構築

Bot開発用の環境を構築します。

HomebrewでPython3をインストールする。

```
brew install python3
```

次にpip3でslackbotをインストールします。  
[slackbot][2]を使うと難しいことを考える必要なく、Botが作れます。

```
pip3 install slackbot
```

インストールを終えたら、動作確認に移ります。

### Homebrewが失敗する場合

長らく使ってなかったためか、私の環境では `brew install python3` が失敗してしまいました。

困っていたところ、フォロワーさんに `brew doctor` というコマンドを教わりました。(とても助かりました。)  
Homebrewのマニュアルを見ると `Check your system for potential problems.` とあります。どうやらシステム内の潜在的な問題をチェックしてくれるもののようです。  

実行するとディレクトリのownershipを変更しなさいと警告が出ました。

```
Error: The following directories are not writable by your user:
/usr/local/lib

You should change the ownership of these directories to your user.
  sudo chown -R $(whoami) /usr/local/lib

And make sure that your user has write permission.
  chmod u+w /usr/local/lib
```

言われた通りにコマンドをコピペしたところ、うまくいきました。

## Bot作成

### run.py

まず、run.pyというファイルを作成します。

```python
from slackbot.bot import Bot
def main():
    bot = Bot()
    bot.run()

if __name__ == "__main__":
    print('start bot')
    main()</code></pre>
```

### 設定ファイル

次に同じ階層にslackbot_settings.py に Slack API tokenを記載します。  
[slackbot/README_ja.md][3] を見ると2種類方法があるようですが、今回は2番目の[slack web api ページ][4]で API トークンを生成してみます。(OAuth & Permissions のBot User OAuth Access Token欄に書かれている文字列を、API_TOKENに指定します。

```python
# coding: utf-8

API_TOKEN = "xxxx-xxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxx"
PLUGINS = ['plugins']</code></pre>
```

### Pluginファイル

最後に、Botにさせたい処理を書きます。  
Pliginsディレクトリを作り、配下にpythonファイルを作成します。


```python
# coding: utf-8

from slackbot.bot import respond_to

@respond_to('鳩は唐揚げ')
def mention_func(message):
    message.reply('鳩は唐揚げ')</code></pre>
```

最終的に以下のようなファイル配置になります。

```
├── plugins
│   ├── __init__.py
│   └── my_menthon.py
├── run.py
└── slackbot_settings.py</code></pre>
```

## 動作確認

Botの動作確認をします。  
以下のコマンドを実行します。

```python
python3 run.py
```

`start bot` と出力された後に、エラーメッセージが出なければ動作しています。  
Slack側でBotにメンションすれば反応してくれるハズ。

### Slackbotがエラー(&#8216;NoneType&#8217; object has no attribute &#8216;endswith&#8217;)で起動しない場合

`python3 run.py` したら、以下のエラーメッセージが出てしまいBotが起動しない事象に遭遇しました。

```
Traceback (most recent call last):
  File "run.py", line 13, in &lt;module>
    main()
  File "run.py", line 9, in main
    bot.run()
  File "/usr/local/lib/python3.7/site-packages/slackbot/bot.py", line 34, in run
    self._plugins.init_plugins()
  File "/usr/local/lib/python3.7/site-packages/slackbot/manager.py", line 31, in init_plugins
    self._load_plugins(plugin)
  File "/usr/local/lib/python3.7/site-packages/slackbot/manager.py", line 54, in _load_plugins
    if not path_name.endswith('.py'):
AttributeError: 'NoneType' object has no attribute 'endswith'
```

対処方法ですが、Pluginsディレクトリ配下に `__init__.py` を放り込みました。(元のQiita記事では作ってるのですが見落としていました。)

## 感想

Slack APIの認証周りを考えずにさっくりBotを作れるので便利ですね。  
躓かなければ、1時間くらいでBotの作成ができそう。

作ったBotですがまだメッセージの返答しかできないので、ドキュメントを読んで色々いじってみます。

ではでは。

 [1]: https://qiita.com/sukesuke/items/1ac92251def87357fdf6
 [2]: https://github.com/lins05/slackbot
 [3]: https://github.com/lins05/slackbot/blob/develop/README_ja.md#slack-api%E3%83%88%E3%83%BC%E3%82%AF%E3%83%B3%E3%82%92%E7%94%9F%E6%88%90%E3%81%99%E3%82%8B
 [4]: https://api.slack.com/web
