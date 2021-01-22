<?php

/**
 * 后台公共文件 
 * @file   Common.php  
 * @date   2016-8-24 18:28:34 
 * @author Zhenxun Du<5552123@qq.com>  
 * @version    SVN:$Id:$ 
 * @change wy wy<1044683411@qq.com> -2021-1-3 
 */

namespace app\admin\controller;

use think\Controller;
use think\Request;
use think\Db;

class Common extends Controller {
    public function _initialize() {
        //echo "Common";
        //拦截器-拦截未登录用户
        if (!session('user_id')) {
            $this->error('请登录！', 'login/index', '', 0);
        }
        //查询当前用户的权限
        $info_nodes = Db::name('nodes')->alias('a')
            ->join('role_node b','a.id = b.nodeid')
            ->field('a.name,a.url')
            ->where('b.roleid',session('role_id'))
            ->select();
        $role_name = db('roles')->field('name')->where('id', session('role_id'))->find();
        //var_dump($info_nodes);
        //拦截器-拦截无权限用户
        $node_check = Common::_checkAuthor();
        // $node_check = true;
        if(!$node_check){
            $this->error('您无权访问该页面！', 'main/index', '', 3);
        }
        //传递权限值与用户名称
        $this->assign('nodes', $info_nodes);
        $this->assign('username', session('user_name'));
        $this->assign('rolename', $role_name['name']);
        Common::_addLog();
    }

    //添加日志信息
    private function _addLog() {
        $piece = array();
        $piece['module'] = request()->module();
        $piece['controller'] = request()->controller();
        $piece['action'] = request()->action();
        $piece['ip'] = ip2long(request()->ip());
        $piece['time'] = time();
        db('log')->insert($piece);
    }

    //检查权限
    private function _checkAuthor(){
        $c = strtolower(request()->controller());
        $a = strtolower(request()->action());
        //$current_node是当前访问的功能id号，为NULL说明是基础常规功能或该访问地址不存在
        $current_node = db('nodes')->field('id')->where('controller', $c)->where('action', $a)->find(); 
        //var_dump($current_node);
        $check_exist = db('role_node')->where('roleid', session('role_id'))->where('nodeid', $current_node['id'])->find();
        //如果系统有这个功能并且该角色没有这个功能，则返回无权限提示
        if($current_node!=NULL && !$check_exist){
            return false;
        }else{
            return true;
        }
    }

}