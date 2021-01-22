<?php

namespace app\admin\controller;

use think\Db;

class Activitymanage extends Common
{

    /**
     * 1 活动信息管理
     */
    public function index()
    {
        $res = db('activities')->select();
        $this->assign('lists', $res);
        return $this->fetch();
    }
}
