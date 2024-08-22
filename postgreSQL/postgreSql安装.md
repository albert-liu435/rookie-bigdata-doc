---
title: PostgreSql 15.4安装
date: 2023-09-15 13:33:45
categories: bigData
tags:
- PostgreSql
---

### 安装要求

本次安装采用的是Centos 8操作系统，满足PostgreSql的安装要求

1. GNU make版本在3.80或以上

   ```shell
   [root@VM-0-4-centos ~]# make --version
   GNU Make 4.2.1
   Built for x86_64-redhat-linux-gnu
   Copyright (C) 1988-2016 Free Software Foundation, Inc.
   License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
   This is free software: you are free to change and redistribute it.
   There is NO WARRANTY, to the extent permitted by law.
   [root@VM-0-4-centos ~]# 
   ```

2. ISO/ANSI C 编译器（至少是 C99兼容的）。推荐使用最近版本的GCC

   ```shell
   [root@VM-0-4-centos ~]# gcc --version
   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4)
   Copyright (C) 2018 Free Software Foundation, Inc.
   This is free software; see the source for copying conditions.  There is NO
   warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
   
   [root@VM-0-4-centos ~]# 
   
   ```

3. tar zlib GUN Readline库

   ```shell
   [root@VM-0-4-centos ~]# tar --version
   tar (GNU tar) 1.30
   Copyright (C) 2017 Free Software Foundation, Inc.
   License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
   This is free software: you are free to change and redistribute it.
   There is NO WARRANTY, to the extent permitted by law.
   
   Written by John Gilmore and Jay Fenlason.
   [root@VM-0-4-centos ~]# rpm -qa | grep zlib
   zlib-1.2.11-17.el8.x86_64
   zlib-devel-1.2.11-17.el8.x86_64
   [root@VM-0-4-centos ~]# rpm -qa | grep readline
   readline-7.0-10.el8.x86_64
   [root@VM-0-4-centos ~]# 
   ```

   如果在执行./configure的命令时出现configure: error: readline library not found错误，则需要执行如下安装命令

   ```shell
   yum install readline-devel
   ```

   

### PostgreSQL 安装

1. 源码下载及解压

   ```shell
   [root@VM-0-4-centos ~]# wget https://ftp.postgresql.org/pub/source/v15.4/postgresql-15.4.tar.gz
   [root@VM-0-4-centos ~]# tar -zxvf postgresql-15.4.tar.gz
   ```

2. 配置、构建、测试，及安装

   ```shell
   [root@VM-0-4-centos ~]#./configure       # 源码树配置及依赖变量检查
   [root@VM-0-4-centos ~]#make all          # 构建
   [root@VM-0-4-centos ~]#make check        # 回归测试
   [root@VM-0-4-centos ~]#sudo make install # 使用root权限进行安装，因默认会安装到/usr/local/pgsql
   ```

3. 设置环境变量

   执行 vim /etc/profile 命令，在文件最下面添加如下内容

   ```shell
   export PGSQL_HOME=/usr/local/pgsql
   export PATH=$PGSQL_HOME/bin:$PATH
   ```

   ```shell
   [root@VM-0-4-centos postgresql-15.4]# vim /etc/profile
   [root@VM-0-4-centos postgresql-15.4]# source /etc/profile #环境变量生效
   ```

4. 配置数据目录并启动

   推荐使用一个单独的账号（`postgres`）运行 PostgreSQL,创建了一个新账号`postgres`，新建了`/usr/local/pgsql/data`数据文件夹并将控制权限赋予`postgres`

   ```shell
   [root@VM-0-4-centos postgresql-15.4]# adduser postgres
   [root@VM-0-4-centos postgresql-15.4]# mkdir /usr/local/pgsql/data
   [root@VM-0-4-centos postgresql-15.4]# chown postgres /usr/local/pgsql/data
   ```

   切换为`postgres`，初始化数据库，并启动服务。

   ```shell
   [root@VM-0-4-centos postgresql-15.4]# su - postgres
   Last failed login: Fri Sep 15 16:33:26 CST 2023 from 170.64.200.120 on ssh:notty
   There were 6 failed login attempts since the last successful login.
   [postgres@VM-0-4-centos ~]$ /usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data
   The files belonging to this database system will be owned by user "postgres".
   This user must also own the server process.
   
   The database cluster will be initialized with locale "en_US.utf8".
   The default database encoding has accordingly been set to "UTF8".
   The default text search configuration will be set to "english".
   
   Data page checksums are disabled.
   
   fixing permissions on existing directory /usr/local/pgsql/data ... ok
   creating subdirectories ... ok
   selecting dynamic shared memory implementation ... posix
   selecting default max_connections ... 100
   selecting default shared_buffers ... 128MB
   selecting default time zone ... Asia/Shanghai
   creating configuration files ... ok
   running bootstrap script ... ok
   performing post-bootstrap initialization ... ok
   syncing data to disk ... ok
   
   initdb: warning: enabling "trust" authentication for local connections
   initdb: hint: You can change this by editing pg_hba.conf or using the option -A, or --auth-local and --auth-host, the next time you run initdb.
   
   Success. You can now start the database server using:
   
       /usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l logfile start
   
   [postgres@VM-0-4-centos ~]$ /usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l server.log start
   pg_ctl: unrecognized operation mode "star"
   Try "pg_ctl --help" for more information.
   [postgres@VM-0-4-centos ~]$ /usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l server.log start
   waiting for server to start.... done
   server started
   
   ```

### PostgreSQL简单使用

创建一个测试数据库testDB，并进行简单的测试

```shell
[postgres@VM-0-4-centos ~]$ /usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l server.log star
pg_ctl: unrecognized operation mode "star"
Try "pg_ctl --help" for more information.
[postgres@VM-0-4-centos ~]$ /usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data -l server.log start
waiting for server to start.... done
server started
[postgres@VM-0-4-centos ~]$ /usr/local/pgsql/bin/createdb testDB
[postgres@VM-0-4-centos ~]$ /usr/local/pgsql/bin/psql testDB
psql (15.4)
Type "help" for help.

testDB=# \d
Did not find any relations.
testDB=# \q
[postgres@VM-0-4-centos ~]$ 

```



