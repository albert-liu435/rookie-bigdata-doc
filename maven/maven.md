maven

### maven简介

maven的本质是一个项目管理工具，将项目开发和管理过程抽象成一个项目对象模型(POM)。引入maven是为了解决传统的项目管理jar包不统一，jar包不兼容且工程升级维护过程中操作频繁等问题。

maven的作用：提供标准的、跨平台的自动化项目构建方式，方便快捷的管理项目依赖的资源(jar包),避免资源间的版本冲突，提供标准的、统一的项目结构。

### maven基础概念

#### 仓库

仓库：用于存储资源，包含各种jar包。包括本地仓库和远程仓库。

本地仓库：自己电脑上存储资源的仓库，连接远程仓库获取资源

远程仓库：非本机电脑上的仓库，为本地仓库提供资源。包括中央仓库和私服。其中中央仓库指maven团队维护，存储所有资源的仓库，私服是部门/公司范围内存储资源的仓库，从中央仓库获取资源。

私服作用：一定范围内共享资源，仅对内部开放，不对外共享。保存具有版权的资源，包含购买或只读研发的jar。

#### 坐标

坐标是用于描述仓库中资源的位置。坐标主要组成如下

groupId:定义当前maven项目隶属组织名称

artifactid:定期当前maven项目的名称

version：定义当前项目版本号

packaging：定义该项目的打包方式

使用唯一标识，唯一性定位资源位置，通过该标识可以将资源的识别与下载工作交由机器完成。

### maven项目结构及依赖管理

#### 项目结构

使用IDEA创建java maven项目过程如下，

File-》new Project如图

![1647918307](.\pic\1647918307.png)

![1647918377](.\pic\1647918377.png)

即可创建一个java maven项目。其中main为主程序，main下面的java和resources分别为放置源代码和配置文件，test为测试程序，test下面的java和resources分别为放置源代码和配置文件。

#### 依赖管理

依赖配置

依赖指当前项目运行所需的jar,一个项目可以设置多个依赖，如javaseDemo项目中的pom依赖

```java
    <!--设置当前项目所依赖的所有jar-->
	<dependencies>
		<!--设置具体的依赖-->
        <dependency>
			<!--设置所属groupId-->
            <groupId>com.rookie.bigdata</groupId>
			<!--设置所属artifactId-->
            <artifactId>rookie-spring</artifactId>
			<!--依赖范围-->
			<scope>compile</scope>
			<!--设置所属版本号-->
            <version>1.0.0.RELEASE</version>
        </dependency>

        <dependency>
            <groupId>com.taobao.top</groupId>
            <artifactId>taobao-sdk-java-auto</artifactId>
            <version>1603954165353-20210916</version>
        </dependency>
    </dependencies>
```

依赖冲突问题

在引入依赖的时候，有时候也会出现相同依赖之间的版本冲突问题，maven自行解决该冲突问题的原则有 

路径优先：当依赖中出现相同的资源时，层级越深，优先级越低，层级越浅优先级越高。

声明优先：当资源在相同层级被依赖时，配置顺序越靠前的覆盖配置顺序越靠后的。

特殊优先：当统计配置了相同资源的不同版本，后配置的覆盖先配置的。

可选依赖

Optional标签标示该依赖是否可选，默认是false。可以理解为，如果为true，则表示该依赖不会传递下去，如果为false，则会传递下去。如

```xml
        <dependency>
            <groupId>com.taobao.top</groupId>
            <artifactId>taobao-sdk-java-auto</artifactId>
            <version>1603954165353-20210916</version>
            <optional>true</optional>
        </dependency>
```

依赖排除

如果我们在当前工程中引入了一个依赖是 A，而 A 又依赖了 B，那么 Maven 会自动将 A 依赖的 B 引入当前工程，但是个别情况下 B 有可能是一个不稳定版，或对当前工程有不良影响。这时我们可以在引入 A 的时候将 B 排除。如

```xml
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.13.2</version>
            <!--<scope>test</scope>-->
            <exclusions>
                <exclusion>
                    <groupId>org.hamcrest</groupId>
                    <artifactId>hamcrest-core</artifactId>
                </exclusion>
            </exclusions>
        </dependency>
```

依赖范围scope

![1647930101](.\pic\1647930101.png)

| scop          | 对于编译classpath有效 | 对于测试classpath有效 | 对于运行时classpath有效 | 例子                            |
| ------------- | --------------------- | --------------------- | ----------------------- | ------------------------------- |
| compile(默认) | Y                     | Y                     | Y                       | spring-core                     |
| test          | -                     | Y                     | -                       | JUnit                           |
| provided      | Y                     | Y                     | -                       | servlet-api                     |
| runtime       | -                     | Y                     | Y                       | JDBC驱动实现                    |
| system        | Y                     | Y                     | -                       | 本地的，maven仓库之外的类库文件 |

依赖传递

依赖具有传递性，分为直接依赖和间接依赖，直接依赖是指在当前项目中通过依赖配置建立依赖关系。间接依赖是指被依赖的资源如果依赖其他资源，当前项目间接依赖其他资源。

传递性依赖和依赖范围。假设A依赖于B,B依赖于C,我们说A对于B是第一直接依赖，B对于C是第二直接依赖，A对于C是传递性依赖。第一直接依赖的范围和第二直接依赖的范围决定了传递性依赖的范围。如下图，最左边一列表示第一直接依赖范围，最上面一行表示第二直接依赖范围，中间的交叉单元格则表示传递性依赖范围。

|          | compile  | test | provided | runtime  |
| -------- | -------- | ---- | -------- | -------- |
| compile  | compile  | -    | -        | runtime  |
| test     | test     | -    | -        | test     |
| provided | provided | -    | provided | provided |
| runtime  | runtime  | -    | -        | runtime  |

maven的生命周期管理和插件

生命周期管理和插件参考

[菜鸟教程](https://www.runoob.com/maven/maven-build-life-cycle.html)

[易百教程](https://www.yiibai.com/maven/maven_build_life_cycle.html)

### maven多模块开发

maven的多模块开发主要用到聚合和继承

maven聚合用于快速构建maven工程，一次性构建多个项目或者模块。

maven继承用于通过继承可以实现在子工程中沿用父工程中的配置。

创建一个多模块开发的工程 rookie-spring如图：

![1647933123](.\pic\1647933123.png)

创建完成后需要将里面的src文件夹删除，然后创建rookie-dao模块如图

![1647933307](.\pic\1647933307.png)

同理创建rookie-service模块，这样一个多模块的工程创建完成。

我们在rookie-spring文件目录下的pom.xml文件中加入如下

```xml
    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <java.version>1.8</java.version>
        <maven.compiler.source>1.8</maven.compiler.source>
        <maven.compiler.target>1.8</maven.compiler.target>
        <spring.version>5.1.9.RELEASE</spring.version>
    </properties>



    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>spring-core</artifactId>
                <version>${spring.version}</version>
            </dependency>
        </dependencies>
    </dependencyManagement>
```

在rookie-service中加入如下依赖，即完成了子模块从父模块的继承

```xml
  <dependencies>
    <dependency>
      <groupId>org.springframework</groupId>
      <artifactId>spring-core</artifactId>
     <!-- <version>5.1.9.RELEASE</version>-->
    </dependency>
  </dependencies>
```

工程实例在github地址上，[github地址](https://github.com/albert-liu435/rookie-spring)

### 版本管理

java maven项目版本主要有SNAPSHOT(快照版本)和RELEASE(发布版本)

SNAPSHOT(快照版本):为项目开发过程中，为方便团队成员合作，解决模块间相互依赖和时间更新问题，开发者对每个模块进行构建的时候，输出的临时性版本叫做快照版本。快照版本会随着开发的进度不断更新。

RELEASE(发布版本)：项目开发到进入阶段里程碑后，向团队外部发布较为稳定的版本，这种版本所对应的构建文件时稳定的，即便进行功能的后续开发，也不会改变当前发布版本内容，这种版本称为发布版本。

工程版本号约定，以Spring的版本管理为例。如5.2.9.RELEASE

主版本.次版本.增量版本.里程碑版本

主版本：表示项目重大架构的变更

次版本：表示有较大的功能增加和变化，或者全面系统地修复漏洞

增量版本：表示有重大漏洞修复

里程碑版本：表示一个版本的里程碑。