### windows安装MAVEN

#### 下载MAVEN

​	[官方下载地址](http://maven.apache.org/download.cgi)

#### 安装maven

本文以apache-maven-3.6.3-bin.zip为例介绍

将该zip文件解压到指定的目录下，本机目录如下：C:\developer\Java\maven

maven目录如图

![1647913564](.\pic\1647913564.png)

bin：该目录包含了mvn运行的脚本，这些脚本用来配置Java命令，驻军吧号classpaht和相关的Java系统属性，然后执行Java命令。

boot:该目录下只包含一个plexus-classworlds-2.6.0.jar文件，这个jar包是一个类加载器框架，相对于默认的java类加载器，它提供了更丰富的语法以方便设置，maven使用该框架加载自己的类库。

conf:包括一个settings.xml文件，修改该文件可以在机器上全局定制maven的行为。

lib:包含了所有与maven运行时需要的java类库。



设置环境变量，如下图：

![maven1](.\pic\maven1.png)

打开windows命令行输入如下命令

```powershell
mvn -v 
```

```shell
Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
Maven home: C:\developer\Java\maven\bin\..
Java version: 1.8.0_161, vendor: Oracle Corporation, runtime: C:\developer\Java\jdk1.8.0_161\jre
Default locale: zh_CN, platform encoding: GBK
OS name: "windows 10", version: "10.0", arch: "amd64", family: "windows"
```

#### 配置maven的本地仓库和镜像

打开C:\developer\Java\maven\conf目录下的setting.xml配置文件，修改如下：

![maven2](.\pic\maven2.png)

如果不修改本地仓库地址的话，默认本地仓库位置为${user.home}/.m2/repository

由于仓库地址指向的是国外地址，所以可以通过添加镜像解决下载jar包问题，如图添加阿里云镜像

![maven3](.\pic\maven3.png)

#### IDEA配置MAVEN信息

依次点击 File==>other setting==>Settings for New Projects，如图，这样在每次 创建项目或import项目的时候不需要重新设置maven了。

![maven4](.\pic\maven4.png)



### Linux安装MAVEN

#### 下载并解压maven

```shell
wget https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
#进行解压
tar -xzvf apache-maven-3.6.3-bin.tar.gz
#移动到usr/local/目录下
mv apache-maven-3.6.3 /usr/local/apache-maven

```

![linux-maven1](.\pic\linux-maven1.png)

配置环境变量

```shell
vim /etc/proflie
#添加如下
export JAVA_HOME=/home/jdk/jdk
export MAVEN_HOME=/usr/local/apache-maven
export PATH=$MAVEN_HOME/bin:$JAVA_HOME/bin:$PATH

#保存之后执行如下命令使环境变量生效
source /etc/profile

#执行如下命令查看是否生效
mvn -v
```

#### 配置maven的本地仓库和镜像

可以参照上面的windows环境进行配置，注意本地仓库的路径地址就行