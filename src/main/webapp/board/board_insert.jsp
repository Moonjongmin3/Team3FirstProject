<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
th{
  color:black;
}
.board_wrap{
  margin: 0px auto;
  width:1000px;
</style>
</head>
<body>
  <div class="board row3">
    <h3>글쓰기</h3>
   <div class="board_wrap">
     <form method=post action="../board/board_insert_ok.do">
      <table class="table">
       <tr>
        <th width=15% class="text-right success">이름</th> <!-- userID로바꾸기 -->
        <td width=85%>
         <input type=text name=uer_id size=15 class="input-sm">
        </td>
       </tr>
       <tr>
        <th width=15% class="text-right success">제목</th>
        <td width=85%>
         <input type=text name=title size=50 class="input-sm">
        </td>
       </tr>
       <tr>
        <th width=15% class="text-right success">내용</th>
        <td width=85%>
         <textarea rows="8" cols="55" name=content></textarea>
        </td>
       </tr>
       <tr>
        <th width=15% class="text-right success">첨부파일</th>
        <td width=85%>
         <input type=file name=bfile size=20 class="input-sm">
        </td>
       </tr>
       <tr>
        <th width=15% class="text-right success">비밀번호</th>
        <td width=85%>
         <input type=password name=pwd size=10 class="input-sm">
        </td>
       </tr>
       <tr>
         <td colspan=2 class="text-center">
           <input type=submit value="글쓰기" class="btn btn-sm btn-primary">
           <input type=button value="취소" class="btn btn-sm btn-danger"
            onclick="javascript:history.back()">
         </td>
       </tr>
      </table>
      </form>
    </div>
   </div>
</body>
</html>