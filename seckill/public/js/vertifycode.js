
// 重新生成验证码
function reloadImg(imgid) {
	//window.alert(1);
	//$('#img').attr('src','{:captcha_src()}?rand='+Math.random());
	document.getElementById(imgid).src = "{:captcha_src()}?rand='+Math.random()";
}