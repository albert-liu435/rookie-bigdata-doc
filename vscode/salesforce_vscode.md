## vscode配置salesforce插件

[参考网址](https://trailhead.salesforce.com/en/content/learn/trails/set-up-your-workspace-and-install-developer-tools)

### 下载安装Visual Studio Code

[下载地址](https://code.visualstudio.com/)

下载之后进行安装，安装完成后打开Visual Studio Code

### 安装命令行工具 Salesforce CLI

[下载地址](https://developer.salesforce.com/tools/sfdxcli)

下载完成之后进行安装，安装完成之后通过cmd打开命令行工具查看如图

![1654063416](.\pic\1654063416.png)

### Visual Studio Code安装Salesforce Extension Pack

在VS Code的左侧工具栏单击Extensions.然后再搜索框中输入Salesforce Extension Pack，再点击install即可，如下图，我已经安装了，所以没有install按钮

![1654063761](.\pic\1654063761.png)

## vscode配置salesforce连接与开发

### 创建工程

1、在vs code中按 Ctrl+Shift+P组合键，然后再输入SFDX:Create Project,然后按enter键

2、输入工程名称，如VSCodeQuickstart，根据自己需要将工程创建到指定的目录中

3、按Ctrl+P组合键进行搜索文件，如project-scratch-def.json，对里面的orgName进行重新命名为Wise Shark Playground然后保存

### 进行org身份认证

1、按Ctrl+Shift+P组合键，然后输入SFDX: Authorize an Org，选择默认的登录URL,输入orgName 为Wise Shark Playground进行认证授权

2、按住Ctrl+Shift+P，然后输入SFDX: Create Apex Class，输入AccountController创建一个apx

代码如下,按Ctril+S进行文件保存

```java
public with sharing class AccountController {
    public static List<Account> getAllActiveAccounts() {
      return [SELECT Id,Name,Active__c FROM Account WHERE Active__c = 'Yes'];
    }
  }
```

### 进行sql查询及部署

1、按Ctrl+Shift+P组合键，然后输入SFDX:Execute SOQL Query with Currently Selected Text，然后将SELECT Id,Name,Active__c FROM Account WHERE Active__c = 'Yes'放入，选择Rest API并按Enter键即可看到相应的查询出的数据

2、按照如下进行部署,点击**SFDX: Deploy Source to Org**.进行部署

![1](.\pic\1.webp)

## vscode salesforce整合Dev Hub

[参考网址](https://trailhead.salesforce.com/en/content/learn/trails/set-up-your-workspace-and-install-developer-tools)

