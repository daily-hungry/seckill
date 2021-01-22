<?php

namespace app\admin\controller;

use think\Request;
use think\Db;

class Nodemanage extends Common {

    /**
     * 6.系统功能管理
     */
    public function index() {
            // $res = db('users')->select();
            // $this->assign('lists', $res);
            return $this->fetch();
    }
}
