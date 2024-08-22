### Sublime IDE配置

1、下载并安装sublime

下载地址：https://www.sublimetext.com/download，下载后进行安装

2、安装Package Control

Package Control 这个东东是一个方便 Sublime text 管理插件的插件，这个强大，把它装上去了，再通过他的安装其它插件。也便于管理你安装的插件 官网：https://packagecontrol.io/installation  里面有安装方法，可以按照他的步骤很快就能装好 安装好在首选项会有个子菜单

安装方法：

![9ee2e9de20c83fca15819d7e3d7d6d6](.\pic\9ee2e9de20c83fca15819d7e3d7d6d6.png)

SF的插件有2个 1：MavensMate 详细教程贴：（https://www.xgeek.net/zh/salesforce/sublime-text-3-mavensmate-for-salesforce-development/） 2：HaoIDE  这2个都可以试试，看那个适合你，我是一直使用HaoIDE 这个是国内一个大神开发的，sublime 插件都是基于Python开发的。

3、安装haoIDE插件

![c07992c989bebda44b16326c0d3a883a](.\pic\c07992c989bebda44b16326c0d3a883a.png)

![7e355a8671c69a6bbae4fb6142e5b6b5](.\pic\7e355a8671c69a6bbae4fb6142e5b6b5.jpg)

![107c48f6e39bfd22d4add68f3f117ceb](.\pic\107c48f6e39bfd22d4add68f3f117ceb.jpg)

1. HaoIDE 开源了可以在github上看到  https://github.com/xjsender/haoide  可以在github上看到作者信息

4、配置跟salesforce服务器的连接

配置SF项目，HaoIDE 的配置和sublime的配置一致，都是通过json信息配置，点击 haoide 菜单，点击settings，选择settings-user ,setting-default中是配置参考

projects:是项目集合，此节点下可以配置多个项目

project1:是单个项目配置信息

default:表示当前项目是否处于**状态，只能有一个项目处于**状态

login_url:表示SF的环境链接，https://login.salesforce.com Or https://test.salesforce.com

password:密码

subscribed_metadata_objects：需要下载那些组件，对于开发就4种够了，还可以把对象，字段这些元数据下载下来

username:用户名

workspace：项目存放目录，可以设置一个全局，也可以为每个项目配置一个单独的。

![ea75a947c3b8d114a0a276e721f856cc](.\pic\ea75a947c3b8d114a0a276e721f856cc.jpg)

5、



参考地址：https://www.pianshen.com/article/1017672577/