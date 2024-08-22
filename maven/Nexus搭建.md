## Nexus下载

[nexus下载地址](https://help.sonatype.com/repomanager3/product-information/download)

本文使用的是最新版本nexus-3.38.0-01-unix.tar.gz 

## Liunx安装Nexus

1、将下载的包上传到linux环境，解压然后操作，并在该目录下创建nexus文件夹，将解压的两个文件夹nexus-3.38.0-01和sonatype-work移动到nexus文件夹中,如下解压命令和解压后的目录情况

```shell
[root@VM-0-11-centos ~]# tar -xvzf nexus-3.38.0-01-unix.tar.gz 
```

![1647941984](.\pic\1647941984.png)

启动

在启动之前需要修改etc下面的nexus-default.properties,可以根据自己的需要进行修改端口信息等

```shell
[root@VM-0-11-centos nexus-3.38.0-01]# cd etc/
[root@VM-0-11-centos etc]# ll
total 24
drwxr-xr-x 2 root root 4096 Mar 22 17:35 fabric
drwxr-xr-x 2 root root 4096 Mar 22 17:35 jetty
drwxr-xr-x 3 root root 4096 Mar 22 17:35 karaf
drwxr-xr-x 2 root root 4096 Mar 22 17:35 logback
-rw-r--r-- 1 root root  383 Feb 26 05:22 nexus-default.properties
drwxr-xr-x 2 root root 4096 Mar 22 17:35 ssl
[root@VM-0-11-centos etc]# pwd
/root/nexus/nexus-3.38.0-01/etc
[root@VM-0-11-centos etc]# cat nexus-default.properties 
## DO NOT EDIT - CUSTOMIZATIONS BELONG IN $data-dir/etc/nexus.properties
##
# Jetty section
application-port=8081
application-host=0.0.0.0
nexus-args=${jetty.etc}/jetty.xml,${jetty.etc}/jetty-http.xml,${jetty.etc}/jetty-requestlog.xml
nexus-context-path=/

# Nexus section
nexus-edition=nexus-pro-edition
nexus-features=\
 nexus-pro-feature

nexus.hazelcast.discovery.isEnabled=true
[root@VM-0-11-centos etc]# 

```

由于本系统虚拟机内存较小，所以需要修改etc目录下的nexus.vmoptions的内存大小，默认为2703，根据自己的需要进行修，如图

![1647942355](.\pic\1647942355.png)

直接进行启动即可，

```shell
[root@VM-0-11-centos bin]# ./nexus start

```

然后进行访问即可，本机虚拟机较小，下面会用windows系统的安装进行演示。

## Windows安装Nexus

同理现在windows版本的nexus，将其解压到windows的一个目录下，我解压到C:\developer\Java\nexus这个目录下，然后进入到C:\developer\Java\nexus\nexus-3.38.0-01\bin目录下，通过cmd打开命令行窗口，执行nexus.exe /run nexus即可

然后打开http://localhost:8081,如图进行登录，按照操更改密码等

![1647944055](.\pic\1647944055.png)

登录成功后页面如下，其中最上面的正方体是用来浏览使用的，齿轮模样按钮是用来进行一些必要的设置，包括用户创建，权限设置，仓库创建等等，可以比较简单，可以自己搭建之后点击设置一下，这里不再赘述。

![1647999629](.\pic\1647999629.png)



## nexus仓库的分类

nexus的仓库分为宿主仓库，代理仓库，和仓库组

宿主仓库：宿主仓库即hosted,保存无法从中央仓库获取的资源，包括自主研发的资源和第三方非开源项目，如上图maven-releases,maven-snapshots。

代理仓库：代理仓库proxy,代理远程仓库，通过nexus访问 其他公共仓库，比如中央仓库，例如上图的maven-central。

仓库组：仓库组group,是为了简化配置，将若干个仓库组成一个群组。本身并不保存资源，属于设计型仓库。例如上图的maven-public

### 创建自己的仓库

如图，参照maven-public,maven-releases,maven-snapshots,maven-central创建自己的仓库组haizhilangzi-public,宿主仓库haizhilangzi-releases,haizhilangzi-snapshots，haizhilangzi-third,代理仓库haizhilangzi-central。创建完成后如下，其中haizhilangzi-third同haizhilangzi-releases创建方式一样，只不过是用来存放第三方的jar包

![1647999881](.\pic\1647999881.png)

![1647999951](.\pic\1647999951.png)

![1648000383](.\pic\1648000383.png)

![1648000400](.\pic\1648000400.png)

#### 配置私服访问权限

由于我在设置访问的时候设置了匿名用户可访问，所以如果只是单纯的访问仓库拉取资源可以不配置用户名和密码，当需要deploy资源到仓库的时候才需要配置用户名和密码。

配置本地仓库资源来源有两种方式，一种的在maven的setting配置文件中配置镜像，如下

```xml
  <mirrors>
    <!-- mirror
     | Specifies a repository mirror site to use instead of a given repository. The repository that
     | this mirror serves has an ID that matches the mirrorOf element of this mirror. IDs are used
     | for inheritance and direct lookup purposes, and must be unique across the set of mirrors.
     |
    <mirror>
      <id>mirrorId</id>
      <mirrorOf>repositoryId</mirrorOf>
      <name>Human Readable Name for this Mirror.</name>
      <url>http://my.repository.com/repo/path</url>
    </mirror>
		  阿里云仓库 

	 <mirror>
      <id>alimaven</id>
      <name>aliyun maven</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
      <mirrorOf>central</mirrorOf>        
    </mirror>
	
		 	 <mirror>
      <id>alimaven</id>
      <name>aliyun maven</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
      <mirrorOf>central</mirrorOf>        
    </mirror>
     -->
	<mirror>
      <id>nexus-haizhilangzi</id>
      <name>haizhilangzi maven</name>
      <url>http://localhost:8081/repository/haizhilangzi-public/</url>
      <mirrorOf>*</mirrorOf>        
    </mirror>

  </mirrors>
  
```

第二种在pom中配置仓库资源下载地址，如下

```xml
    <repositories>
        <repository>
            <id>nexus-haizhilangzi</id>
            <name>haizhilangzi maven</name>
            <url>http://localhost:8081/repository/haizhilangzi-public/</url>
        </repository>
    </repositories>
```

deploy资源到nexus上，对于第三方包可以直接上传到nexus中，以上传taobao-sdk-java-auto-1603954165353-20210916.jar为例，如图，按照自己的原子填写好哦Group ID，Artifact ID，Version等信息，然后点击Upload

![1648001539](.\pic\1648001539.png)

上传成功后如图

![1648001564](.\pic\1648001564.png)

利用mave deploy到仓库地址，需要在setting中配置本地仓库的账号和密码，本示例中直接使用admin账号和密码，在生产环境中需要按需创建账号和密码，如果不需要给deploy权限的开发人员，则可以直接忽略这不操作

maven中的setting.xml配置如下

```xml
  <servers>
    <!-- server
     | Specifies the authentication information to use when connecting to a particular server, identified by
     | a unique name within the system (referred to by the 'id' attribute below).
     |
     | NOTE: You should either specify username/password OR privateKey/passphrase, since these pairings are
     |       used together.
     |
    <server>
      <id>deploymentRepo</id>
      <username>repouser</username>
      <password>repopwd</password>
    </server>
    -->

    <!-- Another sample, using keys to authenticate.
    <server>
      <id>siteServer</id>
      <privateKey>/path/to/private/key</privateKey>
      <passphrase>optional; leave empty if not used.</passphrase>
    </server>
    -->
	
	<server>
      <id>haizhilangzi-release</id>
      <username>admin</username>
      <password>admin</password>
    </server>
		<server>
      <id>haizhilangzi-snapshots</id>
      <username>admin</username>
      <password>admin</password>
    </server>
	
  </servers>
```

还需要在pom中配置发布管理，如下

```xml
    <!--发布配置管理-->
    <distributionManagement>
        <repository>
            <id>haizhilangzi-release</id>
            <url>http://localhost:8081/repository/haizhilangzi-release/</url>
        </repository>
        <snapshotRepository>
            <id>haizhilangzi-snapshots</id>
            <url>http://localhost:8081/repository/haizhilangzi-snapshots/</url>
        </snapshotRepository>
    </distributionManagement
```

然后直接在相应的项目下执行mvn deploy发布到对应的仓库里面了。默认是deploy到haizhilangzi-snapshots上，如果想deploy到haizhilangzi-release中，则将快照版本更改为发布版本，即SNAPSHOT-》release.如图

![1648002780](.\pic\1648002780.png)

![1648002792](.\pic\1648002792.png)

示例代码参考 [github](https://github.com/albert-liu435/rookie-spring)



