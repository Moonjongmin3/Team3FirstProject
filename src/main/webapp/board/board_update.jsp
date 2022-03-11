<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<style type="text/css">

.board_wrap{
  margin: 0px auto;
  width:800px;
}
.board{
	width:1080px;
	height:800px;
	margin: 0px auto;
	overflow:hidden;
}
th{
	background-color:DeepSkyBlue;
	text-align:center;
}
td{
	text-align:left;
}
</style>
</head>
<body>
  <div class="board row3">
   <div class="board_wrap">
    <h3>수정</h3>
     <form method=post action="../board/board_update_ok.do" enctype="multipart/form-data">
      <table class="table">
       <tr>
        <th width=15%>이름</th>
        <td width=85%>
         ${sessionScope.userId }
         <input type=hidden name=no value="${no }">
         <input type=hidden name=page value="${page }">
        </td>
       </tr>
       <tr>
        <th width=15%>제목</th>
        <td width=85%>
         <input type=text name=subject size=50 class="input-sm"
         value="${board.title }">
        </td>
       </tr>
       <tr>
        <th width=15%>첨부파일</th>
        <td width=85%>
         <input type=file name=upload size=20 class="input-sm"
         value="${board.bfile }">
        </td>
       </tr>
       <tr>
        <th width=15%>내용</th>
        <td width=85%>
         <textarea rows="10" cols="70" name=content>${board.content }</textarea>
        </td>
       </tr>
       <tr>
        <th width=15%>비밀번호</th>
        <td width=85%>
         <input type=password name=pwd size=10 class="input-sm">
        </td>
       </tr>
       <tr>
         <td colspan=2 class="text-center">
           <button class="btn btn-sm btn-danger">수정하기</button>
           <input type=button value="취소" class="btn btn-sm btn-warning"
            onclick="javascript:history.back()">
         </td>
       </tr>
      </table>
      </form>
    </div>
   </div>
</body>
</html>