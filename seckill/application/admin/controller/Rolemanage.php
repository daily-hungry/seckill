<?php

namespace app\admin\controller;

use think\Request;
use think\Db;

class Rolemanage extends Common {

    /**
     * 5.角色权限管理
     */
    public function index() {
            // $res = db('users')->select();
            // $this->assign('lists', $res);
            return $this->fetch();
    }
}
