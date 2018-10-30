<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiels"%>
<!DOCTYPE html>
<!--[if IE 9 ]><html class="ie9"><![endif]-->
<html>
    <head>
         <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
        <meta name="format-detection" content="telephone=no">
        <meta charset="UTF-8">

        <meta name="description" content="">
        <meta name="keywords" content="">

        <title>SEDN X Media</title> 
         <!-- start: Favicon -->
				<link rel="shortcut icon" href="${pageContext.request.contextPath }/favicon.ico">
         <!-- CSS -->
        <link href="${pageContext.request.contextPath}/ibsCmsCss/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/ibsCmsCss/animate.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/ibsCmsCss/font-awesome.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/ibsCmsCss/form.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/ibsCmsCss/calendar.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/ibsCmsCss/style.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/ibsCmsCss/icons.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/ibsCmsCss/generics.css" rel="stylesheet"> 
        
    </head>
    <body id="skin-blur-ocean">
	<section id="login">
            <header>
                <h1>SEDN X ADMIN</h1>
                <p>The Best Internet Broadcast System For Your Business</p>
            </header>
        
            <div class="clearfix"></div>
            
            <!-- Login -->
            <div class="box tile animated active">
	            <form class="form-validation-1" id="submitAccount"   method="post" action="${pageContext.request.contextPath }/cms/loginProcess">
	                <h2 class="m-t-0 m-b-15">Login</h2>
	                <input type="text" name="member_email" id="memberEmail" class="input-sm validate[required,custom[email],funcCall[loginCheck.checkMemberEmail]] form-control login-control m-b-10"  placeholder="관리자 계정(이메일)" >
	                <input type="password" autocomplete="new-password" name="member_pass" id="memberPass" class="input-sm validate[required,funcCall[loginCheck.checkMemberPass] form-control login-control" placeholder="비밀번호">
	                <input type="submit"  class="btn btn-sm m-r-5 m-t-10"  value="로그인">
	                <small>
	                    <a href="${pageContext.request.contextPath}/cms/join">계정을 원하시나요?</a> |
	                    <a href="${pageContext.request.contextPath}/cms/forgetpass">비밀번호를 잊으셨나요??</a>
	                </small>
	            </form>
            </div>
            <!--######## default Modal ######-->
             		<div class="modal fade" id="msgModal" tabindex="-1" role="dialog" aria-hidden="true">
                	<div class="alert alert-danger alert-icon alert-dismissable fade in">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <span id="warnText"></span>
                    <i class="icon">&#61730;</i>
                  </div>
               </div>
              <!--######## defulet Modal ######-->     
        </section>                      
        <script src="${pageContext.request.contextPath}/ibsCmsJs/jquery.min.js"></script> <!-- jQuery Library -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/bootstrap.min.js"></script>
        <!--  Form Related -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/validation/validate.min.js"></script> <!-- jQuery Form Validation Library -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/validation/validationEngine.min.js"></script> <!-- jQuery Form Validation Library - requirred with above js -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/icheck.js"></script> <!-- Custom Checkbox + Radio -->
        <!-- All JS functions -->
        <script src="${pageContext.request.contextPath}/ibsCmsJs/functions.js"></script>
        <script>
        	/**Login Check JS**/
    		var loginCheck=(function(){
    			var catText="EXIST";
    			var catPass="EXIST";
    			var catExist="NOT_EXIST";
    			var checkMemberEmail=function(field, rules, i, options){
    				$.ajax({url:"${pageContext.request.contextPath}/api/web/checkMemberEmail?member_email="+$("#memberEmail").val(),
    					success:function(responseData){
    						var data = JSON.parse(responseData);
    						catText=data.msg;
    					},
    					error:exception.ajaxException
    				});
    				if (catText!="EXIST") {
        				return options.allrules.validate2fields.alertEmail;
        		}
    			};
    			var checkLostEmail=function(field, rules, i, options){
    				$.ajax({url:"${pageContext.request.contextPath}/api/web/checkMemberEmail?member_email="+$("#lostEmail").val(),
    					success:function(responseData){
    						var data = JSON.parse(responseData);
    						catText=data.msg;
    					},
    					error:exception.ajaxException
    				});
    				if (catText!="EXIST") {
        				return options.allrules.validate2fields.alertEmail;
        		}
    			};
				var checkMemberPass=function(field, rules, i, options){
					$.ajax({url:"${pageContext.request.contextPath}/api/web/checkMemberPass",
						cache : false,
						type : 'post',
						data : {"member_email":$("#memberEmail").val(),"member_pass":$("#memberPass").val()},
						async : false,
    					success:function(responseData){
    						var data = JSON.parse(responseData);
    						catPass=data.msg;
    					},
    					error:exception.ajaxException
    				});
					if (catPass!="EXIST") {
        				return options.allrules.validate2fields.alertPass;
        			}
    			};
    			var checkEmailExist=function(field, rules, i, options){
    				$.ajax({url:"${pageContext.request.contextPath}/api/web/checkMemberEmail?member_email="+$("#joinEmail").val(),
    					success:function(responseData){
    						var data = JSON.parse(responseData);
    						catExist=data.msg;
    					},
    					error:exception.ajaxException
    				});
    				if (catExist!="NOT_EXIST") {
        				return options.allrules.validate2fields.alertExist;
        		}
    			};
    			var checkImageExist=function(field, rules, i, options){
    				if($("#imageFile").val().length==0){
    					return options.allrules.validate2fields.alertImage;
    				}
    			};
    			return{
    				checkMemberEmail:checkMemberEmail,
    				checkMemberPass:checkMemberPass,
    				checkEmailExist:checkEmailExist,
    				checkImageExist:checkImageExist,
    				checkLostEmail:checkLostEmail
    			};
    		}());
    		/***Exception JS****/
    		var exception=(function(){
    			var ajaxException=function(data){
    				$("#warnText").text("AJAX EXCEPTION:"+data);
    				$("#msgModal").modal();
    			};
    			var loginException=function(){
    				$("#warnText").text("LOGIN ERROR:로그인에 오류가 있습니니다.");
    				$("#msgModal").modal();
    			};
    			var imageFileSizeException=function(){
    				$("#warnText").text("1MB 이하 이미지만 업로드 가능합니다. ");
    				$("#msgModal").modal();
    			};
    			var imageFileExtException=function(){
    				$("#warnText").text("jpg,jpeg,gif,png 파일만 업로드 가능합니다.");
    				$("#msgModal").modal();
    			};
    			return{
    				ajaxException:ajaxException,
    				loginException:loginException,
    				imageFileSizeException:imageFileSizeException,
    				imageFileExtException:imageFileExtException
    			};
    		}());
    		/***file upload JS***/
    		var uploadFile=(function(){
    			var image=function(f,section){
    				var file=f.files;
    				if(file[0].size > 1024 * 1024){
    					exception.imageFileSizeException();
    					return;
    				}
    				var localPath=$("#"+section).val();
    				var ext=localPath.split('.').pop().toLowerCase();
    				if($.inArray(ext,['jpg','jpeg','gif','png'])==-1){
    					exception.imageFileExtException();
    					return false;
    				}
    				var reader = new FileReader();
    				reader.onload = function(rst){ // 파일을 다 읽었을 때 실행되는 부분
    					$("#"+section+"_view").attr("src",rst.target.result);
    				}
    				reader.readAsDataURL(file[0]); // 파일을 읽는다
    				var formData = new FormData();
    				formData.append("uploadFile",f.files[0]);
    				$.ajax({
 	                url: '${pageContext.request.contextPath}/SEQ/UPLOAD/PROFILE',
 	                processData: false,
 	                contentType: false,
 	                data: formData,
 	                type: 'POST',
 	                success: function(responseData){
 	                	var data = JSON.parse(responseData);
 	                	$("#joinProfile").val(data.fileName);
 	                }
 	            });
    			};
    			return{
    				image:image
    			};
    		}());
    		$(function(){
    			var frm=$("#member-register");
    			frm.submit(function(ev){
    				if(frm.validationEngine('validate')){
    					$('#loadingLayer').fadeIn('fast');
    					$.ajax({
        					type: frm.attr("method"),
    	            url: frm.attr("action"),
    	            data: frm.serialize(),
    	            success: function (data) {
    	            	$('#register_email').text(data);
    	            	$('#loadingLayer').fadeOut();	
                		$('#regster_elem').css('display','none');	
                		$('#register_result').fadeIn();
    	            }
        		    });
    				}
    				ev.preventDefault();
    			});
    			var lostfrm=$("#member-findpass");
    			lostfrm.submit(function(ev){
    				$('#loadingLayerPass').fadeIn();
    				if($("#lostEmail").val().length!=0){
    					$.ajax({
        					type: lostfrm.attr("method"),
    	            url: lostfrm.attr("action"),
    	            data: lostfrm.serialize(),
    	            success: function (data) {
    	            	$('#loadingLayerPass').fadeOut();
    	            	$("#warnText").text(data+"로 임시 비밀번호가 발급 되었습니다. 임시 비밀번호로 로그인해서 비밀번호를 변경해주세요.");
        						$("#msgModal").modal();
    	            }
        		    });
    				}
    				ev.preventDefault();
    			});
    		});
    		$("#memberPass").keydown(function (key) {
    			if(key.keyCode == 13){
    	            $('#submitAccount').submit();
    	        }
    	 	});
    		</script>
	</body>
</html>
  <!-- SEDN LOG IN JS -->
        
        

        

        
        
