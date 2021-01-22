<?php

namespace app\admin\controller;

use think\Db;

class Frontmanage extends Common
{

    /**
     * 4 前台用户信息管理
     */
    public function index()
    {
        $res = db('students')->select();
        $this->assign('lists', $res);
        return $this->fetch();
    }
}
