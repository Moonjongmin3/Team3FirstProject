<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="dao.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <h3>자유 게시판</h3>
    <table class="table">
	     <tr>
	      <td>
	       <a href="../board/board_insert.do" class="btn btn-sm btn-danger">새글</a>
	      </td>
	     </tr>
	    </table>
    <table class="table">
	     <tr class="success">
	      <th class="text-center" width=10%>번호</th>
	      <th class="text-center" width=45%>제목</th>
	      <th class="text-center" width=15%>작성자</th>
	      <th class="text-center" width=20%>작성일</th>
	      <th class="text-center" width=10%>조회수</th>
	     </tr>
	     <c:forEach var="vo" items="${board_list }">
	      <tr>
	       <td class="text-center" width=10%>${vo.no }</td>
	       <td width=45%>
	        <a href="../board/board_detil.do?no=${vo.no }">${vo.title }</a>
	       </td>
	       <td class="text-center" width=15%>${vo.user_id }</td>
	       <td class="text-center" width=20%>
	        <fmt:formatDate value="${vo.created_at }" pattern="yyyy-MM-dd"/>
	       </td>
	       <td class="text-center" width=10%>${vo.hit }</td>
	      </tr>
	     </c:forEach>
    </table>
    <table class="table"> <!-- 변경필요 -->
	      <tr>
	       <td class="text-center">
	        <a href="../board/list.do?page=${curpage>1?curpage-1:curpage }" class="btn btn-sm btn-warning">이전</a>
	         ${curpage } page / ${totalpage } pages
	        <a href="../board/list.do?page=${curpage<totalpage?curpage+1:curpage }" class="btn btn-sm btn-info">다음</a>
	       </td>
	      </tr>
	    </table>
  </div>
 </div>
</body>
</html>
