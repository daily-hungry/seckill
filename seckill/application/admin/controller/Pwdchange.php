<?php

namespace app\admin\controller;

use think\Controller;
use think\Loader;
use think\Db;


class Pwdchange extends Common {

    /**
     * 改密码页面
     */
    public function index() {
            return $this->fetch();  
    }
    
    /**
     * 修改密码
     */
    public function dopwdchange() {
        //验证密码流程
        if ($_POST['username']) {
            $username = input('post.username');
            $password_old = input('post.password_old');
            $password_new = input('post.password_new');

            if (!$username) {
                $this->error('用户名不能为空！');
            }
            if (!$password_old || !$password_new) {
                $this->error('密码不能为空！');
            }
            $info = db('users')->field('id,username,password')->where('username', $username)->find();
            //信息错误报错
            if (!$info) {
                $this->error('用户名错误！请重新输入！');
            }

            if (md5($password_old) != $info['password']) {
                $this->error('输入旧密码不正确！请重新输入！');
            } else {
                //对数据库的修改
                Db::table('users')
                    ->where('id', $info['id'])
                    ->update(['password' => md5($password_new)]);
                    
                $this->success('修改成功！', 'main/index');
            }
        } 
    }

}