---
title: vscode配置git
date: 2022-07-08 13:33:45
categories: salesforce
tags:
- vscode
---

本章默认你已经安装了git及salesforce相关的工具，如果没有安装git百度自行安装

首先初始化本地代码，从org中拉取最新的代码，然后按照如下步骤操作

配置git路径，如图

![image-20220711155817738](images/salesforce/vscode/vscode整合git2022-07-08/image-20220711155817738.png)

![image-20220711155838221](images/salesforce/vscode/vscode整合git2022-07-08/image-20220711155838221.png)

### 初始化代码

![image-20220708101249205](images/salesforce/vscode/vscode整合git2022-07-08/image-20220708101249205.png)

### 加入到暂存区并添加commit

![image-20220708101453844](images/salesforce/vscode/vscode整合git2022-07-08/image-20220708101453844.png)

![2022-07-08 (1)](images/salesforce/vscode/vscode整合git2022-07-08/2022-07-08 (1).png)

### 连接远程github

首先在github上创建一个仓库，如图

![image-20220708103018936](images/salesforce/vscode/vscode整合git2022-07-08/image-20220708103018936.png)

![2022-07-08 (2)](images/salesforce/vscode/vscode整合git2022-07-08/2022-07-08 (2).png)

![2022-07-08 (3)](images/salesforce/vscode/vscode整合git2022-07-08/2022-07-08 (3).png)

![2022-07-08 (4)](images/salesforce/vscode/vscode整合git2022-07-08/2022-07-08 (4).png)

![2022-07-08 (5)](images/salesforce/vscode/vscode整合git2022-07-08/2022-07-08 (5).png)

![2022-07-08 (6)](images/salesforce/vscode/vscode整合git2022-07-08/2022-07-08 (6)-1657247259149.png)

![image-20220708103119285](images/salesforce/vscode/vscode整合git2022-07-08/image-20220708103119285.png)

不知道为什么 第一次push必须使用命令才能完成
git push -u origin master -f 

![image-20220708120008984](images/salesforce/vscode/vscode整合git2022-07-08/image-20220708120008984.png)

下图通过这里可以直接操作分支

![image-20220708120014261](images/salesforce/vscode/vscode整合git2022-07-08/image-20220708120014261.png)

也可以直接使用git命令进行操作，参考如下

https://www.cnblogs.com/xzdz/p/15611097.html