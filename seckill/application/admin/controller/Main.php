<?php

/**
 * 欢迎页
 * @file
 * @date
 * @author
 * @version
 */

namespace app\admin\controller;

use think\Db;

class Main extends Common
{

    /**
     * 主页面
     */
    public function index()
    {
        $res = db('users')->select();
        $this->assign('lists', $res);
        return $this->fetch();
    }

}
