<?php

namespace app\front\controller;

use think\Controller;
use think\Db;

class Seckill extends Controller
{

    /**
     * 活动报名秒杀
     */
    public function index()
    {
        $res = db('activities')->select();
        $this->assign('lists', $res);
        return $this->fetch();
    }

    /**
     * 执行秒杀逻辑
     */
    public function doseckill()
    {
        //验证密码流程
        if ($_POST['username']) {
            $username = input('post.username');
            $password = input('post.password');
            //一次MD5+一次修改(仅自己知道)+一次MD5 避免彩虹表破译
            $password = substr(md5($password), 5, 16);
            $password += 'wy';
            $password = md5($password);
            $activity = input('post.activity');
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
            $info_student = db('students')->field('id,username,password,state')->where('username', $username)->find();
            //var_dump($info);

            //输入错误要报错
            if (!captcha_check($verifycode)) {
                $this->error('验证码错误，请重新输入！');
            } else if (!$info_student || $password != $info_student['password']) {
                $this->error('用户名或密码错误，请重新输入！');
            } else { //登录成功
                //报名处理
                $info_activity = db('activities')->where('id', $activity)->find();
                //var_dump($info_activity);
                if ($info_student['state'] == 1) {
                    $this->error('您已报名该活动，请勿重复报名！');
                }
                if ($info_activity['remain'] < 1) {
                    $this->error('抱歉！活动名额已满！');
                }
                //有剩余名额且本人未报名成功
                db('students')->where('username', $username)->update(['logintime' => time(), 'state' => 1]); //更新该用户选票状态为1（已选票）
                db('activities')->where('id', $activity)->update(['remain' => $info_activity['remain'] - 1]); //更新活动剩余可选名额
                Seckill::_addSign($info_student['id'], $info_activity['id'], $info_activity['info']); //添加报名订单信息
                //传递参数跳转
                $this->assign('info_activity', $info_activity);
                $this->assign('username', $info_student['username']);
                return $this->fetch('succeed');
            }
        } else {
            $this->view->engine->layout(false);
            return $this->fetch('seckill');
        }
    }

    //添加报名订单信息
    private function _addSign($stuid, $actid, $info)
    {
        $piece = array();
        $piece['stuid'] = $stuid;
        $piece['actid'] = $actid;
        $piece['gettime'] = time();
        $piece['info'] = $info;
        db('signs')->insert($piece);
    }

    //ajax更新信息
    public function giveinfo($tipid, $actid)
    {
        if (request()->isAjax()) {
            $actid = input('actid'); //获得actid,
            $info_activity = db('activities')->field('remain')->where('id', $actid)->find();
            $data = $info_activity['remain'];
            $data->save();
            //var_dump($data);
        } else {
            $this->error('非法操作');
        }
    }
}
