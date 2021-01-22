<?php

namespace app\admin\controller;

use think\Request;
use think\Db;

class Signmanage extends Common {

    /**
     * 2.报名信息管理
     */
    public function index() {
            // $res = db('users')->select();
            // $this->assign('lists', $res);
            return $this->fetch();
    }
}
