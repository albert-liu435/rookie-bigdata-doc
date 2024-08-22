github搭建maven仓库

1、首先在github上创建一个用于存放jar包的仓库，如maven_repo,仓库在创建的时候要选择public,不要选择private

![1647846618](.\pic\1647846618.png)

### 一：将自己写的代码上传到仓库

1、创建自己的项目，项目的pom如下

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.rookie.bigdata</groupId>
    <artifactId>rookie-spring</artifactId>
    <version>1.0.0.RELEASE</version>
    <name>rookie-spring</name>


    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
        <java.version>1.8</java.version>
        <!--代表在当前项目的target目录下的github目录下-->
        <distributionManagement.directory.name>github</distributionManagement.directory.name>

    </properties>

    <distributionManagement>
        <repository>
            <id>rookie-releases</id>
            <name>RookieNexus Release Repository</name>
            <url>file://${project.build.directory}/${distributionManagement.directory.name}</url>
        </repository>
    </distributionManagement>

    <repositories>
        <repository>
            <id>rookie-releases</id>
            <name>RookieNexus Release Repository</name>
            <!--其中abc为你自己的账号或者组织，在创建仓库的时候你可以看到-->
            <url>https://raw.github.com/abc/maven_repo/main</url>
        </repository>
    </repositories>

    <dependencies>

    </dependencies>

    <build>
        <plugins>

            <plugin>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.10.1</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                    <encoding>UTF-8</encoding>
                </configuration>
            </plugin>
            <!--maven发布插件-->
            <plugin>
                <artifactId>maven-deploy-plugin</artifactId>
                <version>2.8.2</version>
                <configuration>
                    <altDeploymentRepository>internal.repo::default::file://${project.build.directory}/${distributionManagement.directory.name}</altDeploymentRepository>
                </configuration>
            </plugin>
        </plugins>
    </build>

</project>

```

2、maven的项目结构如下，并编写一个StringUtils类如图

![1647846867](.\pic\1647846867.png)

3、依次点击右方的Lifecycle中的 clean->compile->package->deploy。最终会在tagert下生成如上图的目录，

4、将生成在target/github下面com目录copy出来，然后上传到github的maven_repo上，如图所示

![1647847242](.\pic\1647847242.png)

5、将自己本地仓库生成的jar包目录删除，然后再创建一个javaDemo项目进行测试，因为github使用了raw.githubusercontent.com这个域名用于raw文件下载，即url地址为https://raw.github.com/${user_account}/${project_name}/${brand},所以repository中的url为https://raw.github.com/abc/maven_repo/main。，完整pom依赖如下，如图

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.rookie.bigdata</groupId>
    <artifactId>javaseDemo</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>javaseDemo</name>
    <description>Demo project for Spring Boot</description>
    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
        <java.version>1.8</java.version>

    </properties>

    <dependencies>
        <dependency>
            <groupId>com.rookie.bigdata</groupId>
            <artifactId>rookie-spring</artifactId>
            <version>1.0.0.RELEASE</version>
        </dependency>

    </dependencies>


    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.5.1</version>
            </plugin>
        </plugins>
    </build>

    <repositories>
        <repository>
            <id>rookie-releases</id>
            <name>RookieNexus Release Repository</name>
                <!--其中abc为你自己的账号或者组织，在创建仓库的时候你可以看到-->
            <url>https://raw.github.com/abc/maven_repo/main</url>
        </repository>
    </repositories>
</project>
```

6、运行mvn package,将相关的依赖下载到本地仓库，然后就可以直接使用了

### 二、第三方jar包上传到github制作maven依赖包

以我们项目用到的阿里会员通taobao-sdk-java-auto-1603954165353-20210916.jar包为例，首先下载该sdk到本地，然后再在该sdk目录下运行如下命令

```java
mvn deploy:deploy-file -DgroupId=com.taobao.top -DartifactId=taobao-sdk-java-auto -Dversion=1603954165353-20210916 -Dpackaging=jar -Dfile=taobao-sdk-java-auto-1603954165353-20210916.jar -Durl=file://work -DrepositoryId=rookie-releases
```

最终会在该目录下生成一个work文件夹，里面既是jar包的目录路径，如图

![1647857510](.\pic\1647857510.png)

然后将work目录下的jar包目录上传到github的仓库中，如图

![1647857621](.\pic\1647857621.png)

同理，将本地仓库的1603954165353-20200916目录删除，在javaseDemo项目加入如下依赖，即可引用该jar包

按照5步骤，引入下面的依赖即可

```xml
        <dependency>
            <groupId>com.taobao.top</groupId>
            <artifactId>taobao-sdk-java-auto</artifactId>
            <version>1603954165353-20210916</version>
        </dependency>
```

然后就可以直接引用taobao-sdk-java-auto里面的类进行开发了。



### gitee搭建maven仓库

gitee搭建和github搭建类似，只是repository的url地址规则如下是使用https://gitee.com/${user_account}/${project_name}/raw/${branch}这种方式进行资源下载,我没有实验过，感兴趣的可以实验一下。