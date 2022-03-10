<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.myPagetable{
	margin-top: 20px;
	width:100%;
}
.myPagetable>tr td{
	height: 55px;
	vertical-align: middle;
}
.myPagetable>tbody>tr:first-child>td{
	border-top: none;
}

</style>
</head>
<body>
	<div style="width:750px">
		<table class="table myPagetable">
	      <tr>
	       <td class="text-right" width=15%>아이디</td>
	       <td width=85% class="inline">
	         <input type=text name=id id="join_id" size=15 class="input-sm" readonly>
	         <input type=button id="checkBtn" value="아이디중복체크" class="btn btn-sm btn-primary">
	       </td>
	      </tr>
	      <tr>
	       <td class="text-right" width=15%>비밀번호</td>
	       <td width=85% class="inline">
	         <input type=password name=pwd id=join_pwd size=15 class="input-sm">
	       </td>
	      </tr>
	      <tr>
	       <td class="text-right" width=15%>이름</td>
	       <td width=85%>
	         <input type=text name=name id=name size=15 class="input-sm">
	       </td>
	      </tr>
	      <tr>
	       <td class="text-right" width=15%>성별</td>
	       <td width=85% class="inline">
	         <input type=radio value="남성" name=gender checked="checked">남자
	         <input type=radio value="여성" name=gender>여자
	       </td>
	      </tr>
	      <tr>
	       <td class="text-right" width=15%>생년월일</td>
	       <td width=85%>
	         <input type=date size=20 name=birth class="input-sm" id="day">
	       </td>
	      </tr>
	      <tr>
	       <td class="text-right" width=15%>E-mail</td>
	       <td width=85%>
	         <input type=text name=email id=email size=50 class="input-sm">
	       </td>
	      </tr>
	      <tr>
	       <td class="text-right" width=15%>우편번호</td>
	       <td width=85% class='inline'>
	         <input type=text name=post id=post size=10 class="input-sm" readonly>
	         <input type=button id="postBtn" value="우편번호찾기"
	          class="btn btn-sm btn-success">
	       </td>
	      </tr>
	      <tr>
	       <td class="text-right" width=15%>주소</td>
	       <td width=85%>
	         <input type=text name=address1 id=address1 size=50 class="input-sm" readonly>
	       </td>
	      </tr>
	      <tr>
	       <td class="text-right" width=15%>상세주소</td>
	       <td width=85%>
	         <input type=text name=address2 id=address2 size=50 class="input-sm">
	       </td>
	      </tr>
	      <tr>
	      <tr>
	       <td class="text-right" width=15%>휴대폰번호 </td>
	       <td width=85% class="inline">
	         <input type=text name=tel id=tel size=20 class="input-sm">
	       </td>
	      </tr>
	      <tr>
	       <td class="text-right" width=15%>소개 </td>
	       <td width=85%>
	         <textarea rows="8" cols="55" id="content" name="content"></textarea>
	       </td>
	      </tr>
	      <tr>
	        <td colspan="2" class="text-center">
	         <input type=button class="btn btn-sm btn-primary" value="회원가입"
	           id="joinBtn"
	         >
	         <input type=button class="btn btn-sm btn-info" value="돌아가기"
	          onclick="javascript:history.back()"
	         >
	        </td>
	      </tr>
	    </table>
    </div>
</body>
</html>