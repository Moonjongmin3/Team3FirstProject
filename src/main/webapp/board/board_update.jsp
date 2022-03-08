<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<style type="text/css">
th{
  color:black;
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
</style>
</head>
<body>
  <div class="board row3">
   <div class="board_wrap">
    <h3>수정</h3>
     <form method=post action="../board/board_update_ok.do">
      <table class="table">
       <tr>
        <th width=15% class="text-right">이름</th>
         <td width=85%><input type=text name=name size=15 
         class="input-sm" value="${board.user_id }">
          <input type=hidden name=no value="${board.no }">
        </td>
       </tr>
       <tr>
        <th width=15% class="text-right success">제목</th>
        <td width=85%>
         <input type=text name=subject size=50 class="input-sm"
         value="${board.title }">
        </td>
       </tr>
       <tr>
        <th width=15% class="text-right success">내용</th>
        <td width=85%>
         <textarea rows="8" cols="55" name=content>${board.content }</textarea>
        </td>
       </tr>
       <tr>
        <th width=15% class="text-right success">첨부파일</th>
        <td width=85%>
         <input type=file name=upload size=20 class="input-sm"
         value="${board.bfile }">
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
           <input type=submit value="수정" class="btn btn-sm btn-primary">
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