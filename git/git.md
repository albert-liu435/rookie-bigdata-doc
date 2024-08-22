## GIT下载安装与设置

1. ### git设置

   1. 开发者设置

      ```powershell
      --配置开发者信息
      git config --global user.name "liuxili"
      git config --global user.email "liuxili@bestseller.com.cn"
      --查看配置信息
      git config -l		
      ```

   2. git创建版本库及git status命令

      ![git_01](.\pic\git_01.png)

      现在的开发属于主分支：On branch master
      初始化仓库的提交：Initial commit;
      未标记的文件:Untracked files;
      随后给出了一些曹祖uode命令：(use "git add <file>..." to include in what will be committed)
      未标记的文件列表,现在只有一个：RedissonProperties.java

   3. 添加文件到仓库

      添加文件到暂存区：git add 文件名称
      提交文件：git commit -m "注释"

      ![git_02](.\pic\git_02.png)

   4. 修改仓库文件

      ![git_03](.\pic\git_03.png)


## 工作区与暂存区

工作区:就是当前电脑的操作目录(包含.git)
仓库(版本库,Repository):工作区有一个隐藏的.git,这个不算工作区,而是Git的仓库(版本库)
	Git的版本库里面存放着很多东西，其中最重要的就是被称为stage的暂存区，还有Git为用户自动创建爱你的主程序分支master,以及指向master的HEAD指针。

1. 工作区与仓库

   ![git_04](.\pic\git_04.png)

2. 版本回退

   ![git_05](.\pic\git_05.png)

   ![git_06](.\pic\git_06.png)

   ![git_07](.\pic\git_07.png)

3. 撤销修改

   ![git_08](.\pic\git_08.png)

   ![git_09](.\pic\git_09.png)

   ![git_10](.\pic\git_10.png)

4. 撤销修改

   ![git_11](.\pic\git_11.png)

5. 关联远程仓库

   ![git_12](.\pic\git_12.png)

   ![git_13](.\pic\git_13.png)


## .gitignore文件规则

> [参考]: http://blog.720ui.com/2014/git_gitignore/
>
> 

1. gitignore 文件对其所在的目录及所在目录的全部子目录均有效。通过将 .gitignore 文件添加到仓库，其他开发者更新该文件到本地仓库，以共享同一套忽略规则。
2. 在仓库目录下新建一个名为 .gitignore 的文件，可以控制其所在的目录及所在目录的全部子目录文件忽略规则。
3. 在 windows 目录下没办法直接直接创建，必须通过右键 Git Bash，按照 Linux 的方式来新建 .gitignore 文件。（因为是点开头，没有文件名）

.gitignore的格式规范

```java
*.java      #忽略所有 .java结尾的文件
!lib.java      #但 lib.java 除外
/TODO         #仅仅忽略项目根目录下的 TODO 文件，不包括 subdir/TODO
build/        #忽略 build/ 目录下的所有文件
doc/*.txt     #会忽略 doc/notes.txt 但不包括 doc/server/arch.txt
```
