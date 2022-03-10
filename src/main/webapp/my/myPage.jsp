<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(function(){
	$('#userUpdateBtn').click(function(){
		$('#myPageTop').text('내정보 수정')
		$('html,body').animate({scrollTop:$('#myPageTop').offset().top-100+"px"}, 50);
		$.ajax({
			type:'post',
			url:'../my/myPage_update.do',
			success:function(res){
				$('.myPagetable').hide()
				$('#myPageTop').after(res)
			}
		})
		
	})
	$('#userDeleteBtn').click(function(){
		$('#myPageTop').text('회원탈퇴')
		$('html,body').animate({scrollTop:$('#myPageTop').offset().top-100+"px"}, 50);
		$.ajax({
			type:'post',
			url:'../my/myPage_delete.do',
			success:function(res){
				$('.myPagetable').hide()
				$('#myPageTop').after(res)
			}
		})
		
	})
	
	
})
function postFindBtn(){
	$('#address2').val('')
	new daum.Postcode({
		oncomplete:function(data)
		{
			$('#post').val(data.zonecode)
			$('#address1').val(data.address)
		}
	}).open()
}
function myDeleteBackBtn(){
	$('#myPageTop').text('내정보')
	$('html,body').animate({scrollTop:$('#myPageTop').offset().top-100+"px"}, 50);
	$('#mydelete_wrap').remove()
	$('.myPagetable').show()
}
function myUpdateBackBtn(){
	$('#myPageTop').text('내정보')
	$('html,body').animate({scrollTop:$('#myPageTop').offset().top-100+"px"}, 50);
	$('#myUpdateTable').remove()
	$('.myPagetable').show()
}
function deleteOkBtn(){
	let pwd =$('#delPwd').val()
	if($.trim(pwd)==''){
		$('#debt').text('비밀번호를 입력하시오!')
		$('#delPwd').focus()
		$('#debt').show()
		return;
	}
	$.ajax({
		type:'post',
		url:'../my/myPageDelete_ok.do',
		data:{"pwd":pwd},
		success:function(res){
			if($.trim(res)==='NO'){
				$('#debt').text('비밀번호가 틀렸습니다!')
				$('#debt').show()
			}else{
				window.location.href='../main/main.do'
			}
		}
	})
}

</script>
<style type="text/css">
#myPageTop{
	position: relative;
}

#myPageTop::after{
	content: "";
    display: block;
    border-bottom: 2px solid black;
    position: absolute;
    width: 100%;
    bottom: -20;
}

.myPagetable{
	margin-top: 20px;
	width:100%;
}
.myPagetable tr td{
	height: 55px;
	vertical-align: middle;
	border-top : 1px solid #dedede
}
.myPagetable tr td:first-child{
	padding-left:40px;
}
.myPagetable tr td:last-child{
	padding-left:50px
}
.myPagetable>tbody>tr:first-child>td{
	border-top: none;
}
.myPagetable>tbody>tr:last-child>td input{
	margin:0 7px;
}
.myPagetable textarea{
	padding:5px 5px;
}
</style>
</head>
<body>
	<div style="width:750px">
		<h2 id="myPageTop">내정보</h2>
		<table class="myPagetable">
	      <tr>
		       <td width=15%>아이디</td>
		       <td width=85% class="inline">
		       		<span>${vo.id }</span>
		       </td>
	      </tr>
	      <tr>
	      </tr>
	      <tr>
	       <td width=15%>이름</td>
	       <td width=85%>
	         <span>${vo.name }</span>
	       </td>
	      </tr>
	      <tr>
	       <td width=15%>성별</td>
	       <td width=85% class="inline">
	         <span>${vo.gender }</span>
	       </td>
	      </tr>
	      <tr>
	       <td  width=15%>생년월일</td>
	       <td width=85%>
	         <span>${vo.birth }</span>
	       </td>
	      </tr>
	      <tr>
	       <td width=15%>E-mail</td>
	       <td width=85%>
	         <span>${vo.email }</span>
	       </td>
	      </tr>
	      <tr>
	       <td width=15%>우편번호</td>
	       <td width=85% class='inline'>
	         <span>${vo.post }</span>
	       </td>
	      </tr>
	      <tr>
	       <td width=15%>주소</td>
	       <td width=85%>
	         <span>${vo.address1 }</span>
	       </td>
	      </tr>
	      <tr>
		      <c:if test="${vo.address2!='' }">
			       <td width=15%>상세주소</td>
			       <td width=85%>
			       		<span>${vo.address2 }</span>
			       </td>
		       </c:if>
	      </tr>
	      <tr>
	      <tr>
	       <td width=15%>휴대폰 </td>
	       <td width=85% class="inline">
	         <span>0${vo.tel }</span>
	       </td>
	      </tr>
	      <tr>
	       <td width=15%>소개 </td>
	       <td width=85%>
	         <textarea rows="8" cols="55" id="content" name="content" readonly>${vo.content }</textarea>
	       </td>
	      </tr>
	      <tr>
	        <td colspan="2" class="text-center" style="padding-top:10px;">
	         <input type=button class="btn btn-md btn-primary" value="정보수정"
	           id="userUpdateBtn">
	         <input type=button class="btn btn-md btn-danger" id="userDeleteBtn" value="회원탈퇴">
	        </td>
	      </tr>
	    </table>
    </div>
</body>
</html>