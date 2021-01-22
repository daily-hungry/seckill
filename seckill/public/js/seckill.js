//判断输入用户名是否合法-是否全为数字和字母-非法给出提示
function check_name_legality(numid, tipid) {
    var zg =  /^[0-9a-zA-Z]*$/;
    var x = document.getElementById(numid).value;
    if (!zg.test(x)) { //判断不是数字
        document.getElementById(tipid).innerHTML = "输入用户名格式有误！";
    }
}

//判断输入密码是否合法-是否长度足够-不足给出提示
function check_pwd_legality(invitationid, tipid) {
    var x = document.getElementById(invitationid).value;
    if (x.length < 4) { //判断密码长度是否不足
        document.getElementById(tipid).innerHTML = "输入密码长度不足！";
    }
}

//重新输入时清空提示
function tip_clear(spanid) {
    document.getElementById(spanid).innerHTML = "";
}

//ajax显示活动信息
function giveinfo(tipid,actid) {
    $.ajax({
        type:"post",
        //dataType:"json",
        data:{actid:actid},//把actid传递到Controller里的方法中去
        url:"{:url('Seckill/giveinfo')}",//方法地址
        success:function (data) {
            document.getElementById(tipid).innerHTML = "活动剩余名额：".$data;
        }
    });  
}
