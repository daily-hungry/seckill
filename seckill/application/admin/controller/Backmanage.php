<?php

namespace app\admin\controller;

class Backmanage extends Common
{

    /**
     * 3.后台用户信息管理
     */
    public function index()
    {
        // $res = db('users')->select();
        // $this->assign('lists', $res);
        return $this->fetch();
    }
}
