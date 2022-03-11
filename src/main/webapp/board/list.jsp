<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="dao.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
  width:1000px;
}
.board{
	width:1080px;
	height:800px;
	margin: 0px auto;
	overflow:hidden;
}
nav{
	width:100%;
	text-align:center;
}
nav>ul>li{
	display:inline-block;
	font-size:15px;
}
form{
	float:right;
}
</style>
</head>
<body>
  <div class="board row3">
   <div class="board_wrap">
    <h3></h3>
    <ul>
     <li>
     <c:if test="${sessionScope.userId!=null }">
       <a href="../board/board_insert.do" class="btn btn-sm btn-danger">새글</a>
     </c:if>
	 	<form method="get" action="../board/list.do" style="margin-bottom: 10px;">
				 <select name="type">
					<option ${(type=="title")?"selected":""} value="title">제목</option>
					<option ${(type=="content")?"selected":""} value="content">내용</option>
					<option ${(type=="user_id")?"selected":""} value="user_id">작성자</option>
				</select>
				<input type="text" placeholder="검색어를 입력해 주세요" value="${board_keyword }" size=23 name="board_keyword">
				<button type="submit" class="board_search_btn">검색</button>
			</form>
     </li>
    </ul>
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
	        <c:if test="${fn:length(vo.title)>33 }">
	         <a href="../board/board_detail.do?page=${curpage }&no=${vo.no }">${fn:substring(vo.title,0,33) }...</a>
	        </c:if>
	        <c:if test="${fn:length(vo.title)<33 }">
	         <a href="../board/board_detail.do?page=${curpage }&no=${vo.no }">${vo.title }</a>
	        </c:if>
	       </td>
	       <td class="text-center" width=15%>${vo.user_id }</td>
	       <td class="text-center" width=20%>
	        <fmt:formatDate value="${vo.created_at }" pattern="yyyy-MM-dd"/>
	       </td>
	       <td class="text-center" width=10%>${vo.hit }</td>
	      </tr>
	     </c:forEach>
    </table>
    <nav class="pagination">
        <ul>
          <c:if test="${startpage>1 }">
            <li><a href="../board/list.do?page=${startpage-1 }&type=${type}&keyword=${keyword}">&laquo;</a></li>
          </c:if>
          <c:set var="style" value=""/>
          <c:forEach var="i" begin="${startpage }" end="${endpage }">
            <c:if test="${i==curpage }">
              <c:set var="style" value="class=current"/>
            </c:if>
            <c:if test="${i!=curpage }">
              <c:set var="style" value=""/>
            </c:if>
            <li><a href="../board/list.do?page=${i }&type=${type}&keyword=${keyword}">${i }</a></li>
          </c:forEach>
          <c:if test="${endpage<totalpage }">
            <li><a href="../board/list.do?page=${endpage+1 }&type=${type}&keyword=${keyword}">&raquo;</a></li>
          </c:if>
        </ul>
      </nav>
  </div>
 </div>
</body>
</html>
