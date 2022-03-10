<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.board row3{
   margin-top: 100px;
}
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
td {
  padding: 8px;
  text-align: left;
  border-bottom: 1px solid #ddd;
}
</style>
</head>
<body>
  <div class="board row3">
    <h3>글쓰기</h3>
   <div class="board_wrap">
     <form method=post action="../board/board_insert_ok.do" enctype="multipart/form-data">
      <table class="table">
       <tr>
        <th width=15%>이름</th>
        <td width=85%>
         ${sessionScope.userId }
        </td>
       </tr>
       <tr>
        <th width=15%>제목</th>
        <td width=85%>
         <input type=text name=title size=50 class="input-sm">
        </td>
       </tr>
       <tr>
        <th width=15%>내용</th>
        <td width=85%>
         <textarea rows="10" cols="70" name=content></textarea>
        </td>
       </tr>
       <tr>
        <th width=15%>첨부파일</th>
        <td width=85%>
         <input type=file name=bfile size=20 class="input-sm">
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
           <button class="btn btn-sm btn-danger">글쓰기</button>
           <input type=button value="취소" class="btn btn-sm btn-light"
            onclick="javascript:history.back()">
         </td>
       </tr>
      </table>
      </form>
    </div>
   </div>
</body>
</html>