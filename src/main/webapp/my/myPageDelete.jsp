<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">

</script>
</head>
<body>
<div id="mydelete_wrap">
	<div style="margin-top: 30px; margin-bottom: 15px">
		<span style="font-size:16px;color: red;">탈퇴한 아이디로는 다시 가입할 수 없습니다.<br>
		 또한, 아이디 및 데이터는 복구할 수 없으므로 회원 탈퇴 시 신중히 진행해 주시기 바랍니다.</span>
	</div>
	<div style="font-size: 17px;">
		비밀번호 <input type="password" name="pwd" style="display: inline-block;" id="delPwd"> 
		<a class="btn btn-sm btn-default" href="javascript:deleteOkBtn()" style=" margin-left:5px; background-color: #ccc; "><b>탈퇴</b></a>
		<span id="debt" style="display: none;color:red;font-size: 15px">비밀번호가 틀렸습니다!</span>
	</div>
	<div style="height:20px; border-bottom: 2px solid black;"></div>
	<div class="text-center" style="margin-top:10px ">
		<a href="javascript:myDeleteBackBtn()" class="btn btn-md btn-danger" >취소</a>
	</div>
</div>
</body>
</html>