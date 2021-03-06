# seckill秒杀系统-热门活动报名系统
# 一、项目概述
本项目为2020年秋季《互联网软件开发技术与实践》课程项目，用于热门活动的报名。活动主办方将要举办的热门活动信息录入，包括报名活动名额，固定时间开放活动报名入口。普通用户学生进行抢报，一人只能报名一次。

实现技术：主要通过Thinkphp框架实现，附加RabbitMQ消息队列的使用。

分为两大部分：

- 后台管理端——热门活动报名后台管理
  - 业务功能：
    - 活动信息管理
    - 报名信息管理
    - 后台用户信息管理
    - 前台用户信息管理
    - 角色权限管理
    - 系统功能管理
  - 权限设置：
    - 活动负责人——具备“活动信息管理”和“报名信息管理”权限。
    - 高级管理员——具备上述6个功能权限。
- 客户端——热门活动报名
  - 业务功能：
    - 查看活动信息
    - 活动报名
    - 查看报名结果

# 二、部署说明

## 1.环境依赖

- Apache：**`Apache / 2.4.6 (CentOS)`**
- MySQL：**`MySQL / 5.7.32`**
- PHP：**`PHP / 7.2.34`**
- RabbitMQ：**`RabbitMQ / 3.8.5`**

## 2.部署流程

- 通过seckill.sql创建数据库。

- 下载项目文件到服务器，并搭建如上的项目依赖环境。

- 修改seckill/database.php文件中的数据库配置信息。

  修改seckill/public/.user.ini文件中的web的服务器配置信息，将open_basedir路径改为自己的主机路径（例如：open_basedir=/www/wwwroot/yourhost/:/tmp/）。

  修改go/RabbitMQ_send/send.go和go/RabbitMQ_receive/receive.go文件中的RabbitMQ连接信息。

- 编译运行两个go文件上传至服务器。

- 通过http://yourhost/index.php/admin/login/index.html 访问后台管理端。

  通过http://yourhost/index.php/front/seckill/index.html 访问客户端。
  
# 三、目录结构

- seckill文件——thinkphp框架搭建的站点

- go文件——RabbitMQ相关文件

~~~
seckill-thinkphp框架项目目录结构
├─application           应用目录
│  ├─common             公共模块目录
│  ├─front        		前台模块目录（主要）
│  │  ├─controller      控制器目录
│  │  ├─model           模型目录
│  │  ├─view            视图目录
│  │  └─ ...            更多类库目录
│  ├─admin        		后台管理模块目录（主要）
│  │  ├─controller      控制器目录
│  │  ├─model           模型目录
│  │  ├─view            视图目录
│  │  └─ ...            更多类库目录
│  │
│  ├─command.php        命令行工具配置文件
│  ├─common.php         公共函数文件
│  ├─config.php         公共配置文件
│  ├─route.php          路由配置文件
│  ├─tags.php           应用行为扩展定义文件
│  └─database.php       数据库配置文件-部署时要修改
│
├─public                WEB目录（对外访问目录）
│  ├─js                 公共js文件（自添加）
│  ├─temp               部分参考Xadmin的引用文件（自添加）
│  ├─index.php          入口文件
│  ├─router.php         快速测试文件
│  └─.htaccess          用于apache的重写
│……
~~~
