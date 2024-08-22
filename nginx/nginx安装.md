## nginx安装

1. 安装依赖

   ```shell
   yum -y install gcc zlib zlib-devel pcre-devel openssl openssl-devel
   ```

2. 下载并解压安装包

   ```shell
   [root@VM-0-4-centos local]# pwd
   /usr/local
   [root@VM-0-4-centos local]# mkdir nginx
   [root@VM-0-4-centos local]# wget http://nginx.org/download/nginx-1.18.0.tar.gz
   --2021-04-02 14:16:40--  http://nginx.org/download/nginx-1.18.0.tar.gz
   Resolving nginx.org (nginx.org)... 3.125.197.172, 52.58.199.22, 2a05:d014:edb:5702::6, ...
   Connecting to nginx.org (nginx.org)|3.125.197.172|:80... connected.
   HTTP request sent, awaiting response... 200 OK
   Length: 1039530 (1015K) [application/octet-stream]
   Saving to: ‘nginx-1.18.0.tar.gz’
   
   nginx-1.18.0.tar.gz                            100%[====================================================================================================>]   1015K  8.85KB/s    in 88s     
   
   2021-04-02 14:18:09 (11.5 KB/s) - ‘nginx-1.18.0.tar.gz’ saved [1039530/1039530]
   
   [root@VM-0-4-centos local]# tar -xvf 
   bin/                 games/               lib/                 libexec/             nginx-1.18.0.tar.gz  redis-6.2.1/         share/               
   etc/                 include/             lib64/               nginx/               qcloud/              sbin/                src/                 
   [root@VM-0-4-centos local]# mv nginx-1.18.0.tar.gz ./nginx
   [root@VM-0-4-centos local]# cd nginx/
   [root@VM-0-4-centos nginx]# tar -xzvf nginx-1.18.0.tar.gz 
   ```

   

3. 安装nginx

   ```shell
   drwxr-xr-x 8 1001 1001    4096 Apr 21  2020 nginx-1.18.0
   -rw-r--r-- 1 root root 1039530 Apr 21  2020 nginx-1.18.0.tar.gz
   [root@VM-0-4-centos nginx]# cd nginx-1.18.0/
   [root@VM-0-4-centos nginx-1.18.0]# ./configure
   #执行make命令
   [root@VM-0-4-centos nginx-1.18.0]# make
   #执行nake install 命令
   [root@VM-0-4-centos nginx-1.18.0]# make install 
   ```

4. 配置并启动nginx

   ```shell
   [root@VM-0-4-centos nginx-1.18.0]# vim /usr/local/nginx/conf/nginx.conf
   #　使用nginx -c的参数指定nginx.conf文件的位置
   [root@VM-0-4-centos nginx-1.18.0]# /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
   ```
重新加载
/usr/local/nginx/sbin/nginx -s reload
   

5. 其他常用命令

   ```
   安装完成一般常用命令
   
   进入安装目录中，
   
   命令： cd /usr/local/nginx/sbin
   
   启动，关闭，重启，命令：
   
   ./nginx 启动
   
   ./nginx -s stop 关闭
   
   ./nginx -s reload 重启
   ```

   

6. niginx部署vue项目

   https://segmentfault.com/a/1190000019549313

7. nginx中文网站

    https://www.nginx.cn/doc/

8. ngin+spirngboot配置ssl证书实现https请求

https://my.oschina.net/u/4354892/blog/4081146

