<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.board_wrap{
  margin: 50px auto;
  width:850px;
}
.board{
	width:1080px;
	height:800px;
	margin: 0px auto;
	overflow:auto;
	
}
</style>
</head>
<body>
   <div class="board row3">
    <div class="board_wrap">
     <h1>삭제하기</h1>
      <form method=post action="delete_ok.jsp">
      <table class="table">
       <tr>
         <td class="text-center">
         비밀번호:<input type=password name=pwd size=15 class="input-sm">
           <input type=hidden name=no value="${board.no }">
           <%-- ${param.no} request.getParameter("no"); --%>
           <input type=hidden name=page value="${board.page }">
           <%-- ${param.page} request.getParameter("page") --%>
         </td>
       </tr>
       <tr>
         <td class="text-center">
           <button class="btn btn-sm btn-danger">삭제</button>
           <input type=button value="취소" class="btn btn-sm btn-primary"
            onclick="javascript:history.back()">
         </td>
       </tr>
      </table>
      </form>
     </div>
   </div>
</body>
</html>