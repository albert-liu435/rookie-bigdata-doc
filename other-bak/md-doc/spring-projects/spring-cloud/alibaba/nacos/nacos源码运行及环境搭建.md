## nacos源码运行

下载源码导入到idea中，然后再源码的根目录执行如下命令

```shell
mvn -Prelease-nacos -Dmaven.test.skip=true clean install -U 
```

启动控制台程序，需要添加如下运行参数

![1650244979](.\pic\1650244979.png)

```shell
-Dnacos.standalone=true 
```

![1650017323](.\pic\1650017323.png)

## nacos安装

### 单机安装

[Nacos 快速开始](https://nacos.io/docs/latest/quickstart/quick-start/)

[Nacos支持三种部署模式](https://nacos.io/docs/latest/guide/admin/deployment/)

ui访问：127.0.0.1:8848/nacos

### 集群部署

[Nacos集群部署和持久化配置（重要）](https://www.jiguiquan.com/?p=943)

