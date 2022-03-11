<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form method="post" action="../my/myPageUpdate_ok.do">    
    <table class="myPagetable" id="myUpdateTable">
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
	       		<input type="text" name="name" value="${vo.name }">
	       </td>
	      </tr>
	      <tr>
	       <td width=15%>성별</td>
	       <td width=85% class="inline">
	         	<input type=radio value="남성" name=gender ${vo.gender=='남성'?'checked':'' }>남성
         		<input type=radio value="여성" name=gender ${vo.gender=='여성'?'checked':'' }>여성
	       </td>
	      </tr>
	      <tr>
	       <td  width=15%>생년월일</td>
	       <td width=85%>
	         <input type="date" name="birth" value="${vo.birth }">
	       </td>
	      </tr>
	      <tr>
	       <td width=15%>E-mail</td>
	       <td width=85%>
	         <input type="text" name="email" value="${vo.email }">
	       </td>
	      </tr>
	      <tr>
	       <td width=15%>우편번호</td>
	       <td width=85% class='inline'>
	         <input type=text name=post id=post size=10 value="${vo.post }" readonly>
         	<a id="upostBtn" href="javascript:postFindBtn()"
          	class="btn btn-sm btn-success">
          	우편번호찾기
          	</a>
	       </td>
	      </tr>
	      <tr>
	       <td width=15%>주소</td>
	       <td width=85%>
	         <input type=text name=address1 id=address1 value="${vo.address1 }" readonly>
	       </td>
	      </tr>
	      <tr>
			  <td width=15%>상세주소</td>
			  <td width=85%>
			      <input type=text name=address2 id="address2" value="${vo.address2 }" >
			  </td>
	      </tr>
	      <tr>
	      <tr>
	       <td width=15%>휴대폰 </td>
	       <td width=85% class="inline">
	         <input type=text name=tel value="0${vo.tel }">
	       </td>
	      </tr>
	      <tr>
	       <td width=15%>소개 </td>
	       <td width=85%>
	         <textarea rows="8" cols="55" id="content" name="content" style="padding:5px 5px;">${vo.content }</textarea>
	       </td>
	      </tr>
	      <tr>
	        <td colspan="2" class="text-center" style="padding-top:10px;">
	         <input type=submit class="btn btn-md btn-primary" value="수정하기">
	         <a href="javascript:myUpdateBackBtn()" class="btn btn-md btn-danger myUpdateBack" style="color: #fff;">취소</a>
	        </td>
	      </tr>
	 </table> 
</form>	 