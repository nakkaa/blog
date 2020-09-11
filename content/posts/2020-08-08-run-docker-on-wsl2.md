+++ 
date = 2020-08-08T21:21:03+09:00
title = "WSL2のUbuntuでDockerを動かす"
url = "run-docker-on-wsl2"
description = ""
categories = ["computer"]
tags = ["docker","ubuntu","windows10","wsl2"]
+++

* WSL2(Windows Subsystem for Linux)のUbuntuでDockerを動かす方法のメモ書きです。

# 前提条件

* Windows10 Version 2004 以上であること

# WSL2の有効化

WSL2を有効化します。  
有効化手順は[Windows 10 用 Windows Subsystem for Linux のインストール ガイド](https://docs.microsoft.com/ja-jp/windows/wsl/install-win10#install-the-windows-subsystem-for-linux) を参考にします。

スタートメニューを右クリックし「Power shell (管理者)」をクリックし PowerShell を開きます。  
開いたら以下を実行します。

```sh
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```
```sh
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

`操作は正常に完了しました。` と表示されたら、Windowsを再起動します。

次にWSL2をデフォルトとして使うように設定します。  
再度 PowerShell を開き以下を実行します。
```sh
wsl --set-default-version 2
```

Microsoft Storeを起動し、Ubuntuと検索します。  
「入手」ボタンをクリックしてUbuntuをインストールします。  
インストール完了後、「起動」ボタンをクリックし、[Linux ディストリビューションのユーザー アカウントを作成および更新する | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/wsl/user-support) を参考にユーザ作成を行います。

ユーザ作成が完了後、パッケージの更新を行います。

```sh
sudo apt update && sudo apt upgrade -y
```

# Dockerのインストール

WSL2上のUbuntuにDockerをインストールします。  
インストール手順は [Install Docker Engine on Ubuntu | Docker Documentation](https://docs.docker.com/engine/install/ubuntu/) を参考にします。

今回は最新の安定版のDockerをインストールします。


```sh
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
```

```sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

```sh
sudo apt-key fingerprint 0EBFCD88
```

```sh
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
```

Dockerをインストールします。
```sh
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

インストール後、Dockerを起動します。
```sh
sudo service docker start
```

`sudo service docker status` して `Docker is running` と出ていたらインストール完了です。

# Docker Compose のインストール

次にDocker Composeをインストールします。  
手順は[Install Docker Compose | Docker Documentation](https://docs.docker.com/compose/install/)を参考にします。

最新(記事執筆時点)のDocker Composeをダウンロードします。
```sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

実行権限を付与します。
```sh
sudo chmod +x /usr/local/bin/docker-compose
```

Docker Composeのバージョンを確認します。  
表示されればインストール完了です。お疲れ様でした。
```sh
docker-compose --version
docker-compose version 1.26.2, build eefe0d31
```

# あとがき
WSL2便利ですね。  
まさかUbuntu(Linux)のDockerがそのままWindows上で動くようになるとは思いませんでした。 

VS Codeに拡張機能を入れればWSL上のファイルも編集できますし、(さっと触った感じでは ですが)開発に困ることはなくなりそうですね。   
Macを使い続ける理由がまた一つなくなりそうです。  
参考: [Windows Subsystem for Linux で VS Code の使用を開始する | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/wsl/tutorials/wsl-vscode)
