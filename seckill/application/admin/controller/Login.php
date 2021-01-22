<?php

/**
 * 登陆页
 * @file   Login.php
 * @date   2016-8-23 19:52:46
 * @author Zhenxun Du<5552123@qq.com>
 * @version    SVN:$Id:$
 * @change wy wy<1044683411@qq.com> -2021-1-3
 */

namespace app\admin\controller;

use think\Controller;

class Login extends Controller
{

    /**
     * 登入
     */
    public function index()
    {
        //浏览器存有cookie直接用cookie登录
        if (cookie('username')) {
            $username = cookie('user_name');
            $token = cookie('token');
            $info = db('users')->where('username', $username)->find();
            $info_role = db('user_role')->field('userid,roleid')->where('userid', $info['id'])->find();
            if ($token == $info['token']) {
                //设置session
                session('user_name', $info['username']);
                session('user_id', $info['id']);
                session('role_id', $info_role['roleid']);
                //登录成功更新登录时间
                db('users')->where('username', $username)->update(['logintime' => time()]);
                return $this->success('登录成功', 'main/index');
            }
        }
        return $this->fetch();
    }

    /**
     * 处理登录
     */
    public function dologin()
    {
        //验证密码流程
        if ($_POST['username']) {
            $username = input('post.username');
            $password = input('post.password');
            //一次MD5+一次修改(仅自己知道)+一次MD5 避免彩虹表破译
            $password = substr(md5($password), 5, 16);
            $password += 'wy';
            $password = md5($password);
            $verifycode = input('post.verifycode');
            //var_dump($verifycode);

            if (!$username) {
                $this->error('用户名不能为空！');
            }
            if (!$password) {
                $this->error('密码不能为空！');
            }
            if (!$verifycode) {
                $this->error('验证码不能为空！');
            }

            $info = db('users')->field('id,username,password')->where('username', $username)->find();

            $info_role = db('user_role')->field('userid,roleid')->where('userid', $info['id'])->find(); //wy 添加role_id
            //var_dump($info_role);

            //输入错误要报错
            if (!captcha_check($verifycode)) {
                $this->error('验证码错误，请重新输入！');
            } else if (!$info || $password != $info['password']) {
                $this->error('用户名或密码错误，请重新输入！');
            } else {
                //存token并更新登录时间-在cookie保证七天免登录（可编造）的基础上再借助logintime保证七天免登录
                $str = md5(time());
                $token = substr($str, 5, 16);
                db('users')->where('username', $username)->update(['token' => $token, 'logintime' => time()]);
                //设置cookie-七天免登录
                cookie('user_name', $username, 7 * 24 * 3600);
                cookie('token', $token, 7 * 24 * 3600);
                //设置session
                session('user_name', $info['username']);
                session('user_id', $info['id']);
                session('role_id', $info_role['roleid']);
                //跳转登录成功界面
                $this->success('登录成功', 'main/index');
            }
        } else {
            if (session('user_name')) {
                $this->success('您已登入', 'main/index');
            }
            $this->view->engine->layout(false);
            return $this->fetch('login');
        }
    }

    /**
     * 登出
     */
    public function logout()
    {
        session('user_name', null);
        session('user_id', null);
        session('role_id', null);
        cookie('user_name', null);
        cookie('token', null);
        $this->success('退出成功', 'login/index');
    }

    public function test()
    {
        echo 'test';
    }

}
