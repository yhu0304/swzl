function is_email(email) {
	var pattern = new RegExp(/^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/);
	return pattern.test(email);
}
//获得字符串的长度  一个中文字符为2字节 英文为1字节
function getLen(str) {
    var i,sum;
    sum=0;
    for(i=0;i<str.length;i++){
        if ((str.charCodeAt(i)>=0) && (str.charCodeAt(i)<=255))
            sum=sum+1;
        else
            sum=sum+2;
    }
    return sum;
}
function is_mobile(num){
	var pattern = new RegExp(/^0?(13[0-9]|15[012356789]|18[0123456789]|14[0123456789])[0-9]{8}$/); 
	return pattern.test(num);
}

$(function(){
			//header部分 登录下拉菜单
		$("#nav-login").bind({
			mouseenter:function(){$("#nav-loginSelect").show();$("#nav-login a").css("color","#000");},
			mouseleave:function(){$("#nav-loginSelect").hide();$("#nav-login a").css("color","#fff");}
		});
			
			
			//设置datepicker本地化
			jQuery(function($){
			$.datepicker.regional['zh-CN'] = {
				closeText: '关闭',
				prevText: '&#x3c;上月',
				nextText: '下月&#x3e;',
				currentText: '今天',
				monthNames: ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'],
				monthNamesShort: ['一','二','三','四','五','六','七','八','九','十','十一','十二'],
				dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
				dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],
				dayNamesMin: ['日','一','二','三','四','五','六'],
				weekHeader: '周',
				dateFormat: 'yy-mm-dd',
				firstDay: 1,
				isRTL: false,
				showMonthAfterYear: true,
				yearSuffix: '年'};
				$.datepicker.setDefaults($.datepicker.regional['zh-CN']);
			});
			
			//设置日历
			$("#datepicker" ).datepicker({ minDate: "-1M", maxDate: 0 });
			$("#datepicker-deadline" ).datepicker({ minDate: 0, maxDate: "1M" });
			$("#search-startTime-datepicker" ).datepicker({ minDate: "-3M", maxDate: 0 });
			$("#search-endTime-datepicker" ).datepicker({ minDate: "-3M", maxDate: 0 });
			$("#datepicker" ).datepicker({ minDate: "-1M", maxDate: 0 });
			//文章浏览页 联系楼主 
			$("#contact-lz-btn").bind('click',function(){ $("#contact-lz").slideToggle(300);});
			$("#contact-lz-close").bind('click',function(){ $("#contact-lz").slideUp(500);});
			
			//-----------------------------------
			/**************************************
			$('.J_reg_email').blur(function() {
				var reg_email = $('.J_reg_email').val();
				var data = 'reg_email=' + reg_email;
				//alert(data);
				$.ajax({
					type: "POST",
					url: "register_chk.php",
					data: data,
					success: function(html) {
						$('#J_email .error').show();
						$('#J_email .error').html(html);
					}
				});
				return false;
			});
			*****************************************/
			//-----------------------------------
			//评论列表点击回复按钮 执行以下操作
			$(".commentList-reply").bind('click',function() {
				//var reply_id = $(this).attr("id");
				var comment_id = "#c" + $(this).attr("id"); 
				var comment_box = $(comment_id).children(".J_comment_box");
				if(comment_box.length) { //评论框是否存在
					var state = comment_box.css("display");
					if(state == "none") { //评论框被隐藏时
						comment_box.css("display","block");
						$(this).text("收起");
					}
					else { //评论框显示时
						comment_box.hide();
						$(this).text("回复");
					}
				}
				else { //评论框不存在 插入评论框节点
					var cmt_box = $("#comment-box .J_comment_box").clone(true).appendTo(comment_id);
					//删除插入节点的某些class
					//##################################################################
					cmt_box.find(".J_cmt-name").removeClass("cmt-error");
					cmt_box.find(".J_cmt-name").removeClass("cmt-ok");
					cmt_box.find(".J_cmt-email").removeClass("cmt-ok");
					cmt_box.find(".J_cmt-email").removeClass("cmt-error");
					cmt_box.find(".J_cmt-content").removeClass("cmt-content-error");
					cmt_box.find(".J_cmt-content").removeClass("cmt-content-ok");
					//############################################################
					var num = $(this).next().text(); //获取楼层ID
					var name = $(this).prevAll(".commentList-title-author").text();//获取楼层作者昵称
					var reply = "@" + name + "(" + num + ")："; 
					$(comment_id).find(".comment-textarea").val(reply); // @yuqin.me(1#):
					$(this).text("收起");
				}
			});
			//文章评论模块用户名 邮箱 内容验证
			
			
			
			
			

	//$('#J_reg_submit').click(function(event){
		//email_chk();
		//pwd_chk();
		//username_chk();
		//if(!(emailStatus && usernameStatus && pwdStatus))
			//event.preventDefault();
	//});
			//ddddddddddddd
			//首先绑定事件
			
			//$(".J_cmt-name").blur(cmt_name_chk);
			//$(".J_cmt-email").blur(cmt_email_chk);
			//$(".J_cmt-content").blur(cmt_content_chk);
			function cmt_email_chk(node) {
				//alert("aa");
				/***********
				var mynode;
				if(node) {
					mynode = node;
				}
				else {
					mynode = aa;
				}***********/
				mynode = node;
				mynode.removeClass("cmt-error");
				mynode.removeClass("cmt-ok");
				var email = mynode.val();
				//alert(email);
				var emLen = email.length;
				if(emLen < 1) { //输入为空时
					mynode.addClass("cmt-error");
				}
				else if (!is_email(email)) { //如果邮箱格式不正确 此函数依赖register.js文件
					mynode.addClass("cmt-error");
					return false;
				}
				else { //格式正确时
					mynode.addClass("cmt-ok");
					return true;
				}
				
			}
		
			function cmt_content_chk(node) {
				/***********
				var mynode;
				if(node) {
					mynode = node;
				}
				else {
					mynode = $(this);
				}
				*************/
				var mynode = node;
				mynode.removeClass("cmt-content-error");
				mynode.removeClass("cmt-content-ok");
				var content = mynode.val();
				content = $.trim(content);
				var contentLen = getLen(content);
				if(contentLen < 4) {
					mynode.addClass("cmt-content-error");
					return false;
				}
				else if(contentLen > 3) {
					mynode.addClass("cmt-content-ok");
					return true;
				}
			}
			function cmt_name_chk(node) {
				//代码逻辑太乱，后期必须修改
				var mynode = node;
				mynode.removeClass("cmt-error");
				mynode.removeClass("cmt-ok");
				var name = $(mynode).val();
				name = $.trim(name);
				var nameLen = getLen(name);
				if(nameLen < 4) {
					mynode.addClass("cmt-error");
					return false;
				}
				else if(nameLen > 3) {
					mynode.addClass("cmt-ok");
					return true;
				}
			}
			
			
			/********
			
				function cmt_name_chk() {
				
				$(this).removeClass("cmt-error");
				$(this).removeClass("cmt-ok");
				var name = $(this).val();
				name = $.trim(name);
				var nameLen = getLen(name);
				if(nameLen < 4) {
					$(this).addClass("cmt-error");
				}
				else if(nameLen > 3) {
					$(this).addClass("cmt-ok");
					cmtNameState = true;
				}
			}
			
			**************/
			$(".cmt-btn").click( function(event) {
				//event.preventDefault();
				contentNode = $(this).parents(".comment").find(".J_cmt-content");//尽量减少遍历  有待优化
				//alert(contentNode);
				//var a = $.isEmptyObject(contentNode);
				//alert(a);
				nameNode = $(this).parents(".comment").find(".J_cmt-name"); //尽量减少遍历  有待优化
				//alert(nameNode);
				//var b = $.isEmptyObject(nameNode);
				//alert(b);
				emailNode = $(this).parents(".comment").find(".J_cmt-email");//尽量减少遍历  有待优化
				
				
				
				if (nameNode.length){
				
					var email_chk_state = cmt_email_chk(emailNode);
					var name_chk_state = cmt_name_chk(nameNode);
					var content_chk_state = cmt_content_chk(contentNode);
					if( !(name_chk_state && email_chk_state && content_chk_state) ) {
						event.preventDefault();
					}
				}
				//var content_chk_state = cmt_content_chk(contentNode);
				//if(!content_chk_state) {
					//event.preventDefault();
				//}
				else  {
					var content_chk_state = cmt_content_chk(contentNode);
					if(!content_chk_state) {
						event.preventDefault();
					}
				}
				
				
				
				
			});
		$(window).bind("scroll",function() {
			var a = $(document).scrollTop();
			//alert(a);
			a > 50 ? $(".nav").addClass("nav-fixed") : $(".nav").removeClass("nav-fixed");
			a > 50 ? $(".back-to-top").fadeIn(700) : $(".back-to-top").fadeOut(700);
        
		});
		
		$(".back-to-top").bind("click",function(){
			$(document).scrollTop(0);
		});	
	
		
		
//////////////////////以下是注册页js代码
function is_email(email) {
	var pattern = new RegExp(/^([a-zA-Z0-9_.-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/);
	return pattern.test(email);
}
//获得字符串的长度  一个中文字符为2字节 英文为1字节
function getLen(str) {
    var i,sum;
    sum=0;
    for(i=0;i<str.length;i++){
        if ((str.charCodeAt(i)>=0) && (str.charCodeAt(i)<=255))
            sum=sum+1;
        else
            sum=sum+2;
    }
    return sum;
}
function email_chk() {
	var email = $('#reg-email').val();
	var emLen = email.length;
	$('#J_email_msg .error').hide();
	$('#J_email_msg .ok').hide();

	if(emLen < 1) { 
		$('#J_email_msg .error').text("注册邮箱不能为空").show(); 
	}
	
	else if (!is_email(email)){ 
		$('#J_email_msg .error').text("邮箱格式不正确").show(); 
	}
	//如果格式正确
	else { 
		emailStatus = true;
		$('#J_email_msg .ok').show(); 
		
	}
}
function username_chk(){
	
	var username = $('#reg-username').val();
	//去掉字符串俩端的空白字符
	username = $.trim(username);
	$('#reg-username').val = username;
	var usernameLen = getLen(username);
	$('#J_username_msg .error').hide();
	$('#J_username_msg .ok').hide();
	if(usernameLen<1){ $('#J_username_msg .error').text("昵称不能为空，至少四个字符").show(); }
	else if(usernameLen>0 && usernameLen<4){ $('#J_username_msg .error').text("至少四个字符，一个汉字为俩个字符").show(); }
	else { $('#J_username_msg .ok').show(); usernameStatus = true;}
}
function pwd_chk(){
	var pwdLen = $('#reg-pwd').val().length;
	$('#J_pwd_msg .error').hide();
	$('#J_pwd_msg .ok').hide();
	//alert(pwdLen);
	if(pwdLen < 6){ $('#J_pwd_msg .error').text("密码6位以上").show(); }
	else { $('#J_pwd_msg .ok').show(); pwdStatus =true;}
}

	emailStatus = usernameStatus = pwdStatus = false;
	//邮箱验证
	$('#reg-email').blur(email_chk);
	
	//用户名验证开始
	$('#reg-username').blur(username_chk);
	
	//密码验证开始
	$('#reg-pwd').blur(pwd_chk);
	$('#J_reg_submit').click(function(event){
		email_chk();
		pwd_chk();
		username_chk();
		if(!(emailStatus && usernameStatus && pwdStatus))
			event.preventDefault();
	});
});
