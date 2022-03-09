<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.BoardModel"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
  margin: 50px auto;
  width:850px;
}
.board{
	width:1080px;
	height:800px;
	margin: 0px auto;
	overflow:auto;
	
}

td {
  text-align: center;
  border-bottom: 1px solid #ddd;
  
}
</style>
</head>
<body>

   <div class="board_wrap">
	    <table class="table" style = "width:100%; table-layout: fixed">
	      <tr>
	       <td width="20%" class="text-center danger">번호</td>
	       <td width="30%" class="text-center">${vo.no }</td>
	       <td width="20%" class="text-center danger">작성일</td>
	       <td width="30%" class="text-center">
	       <fmt:formatDate value="${vo.created_at }" pattern="yyyy-MM-dd"/></td>
	      </tr>
	      <tr>
	       <td width="20%" class="text-center danger">이름</td>
	       <td width="30%" class="text-center">${vo.user_id }</td>
	       <td width="20%" class="text-center danger">조회수</td>
	       <td width="30%" class="text-center">${vo.hit }</td>
	      </tr>
	      <tr>
	       <td width="20%" class="text-center danger">제목</td>
	       <td colspan="3" class="text-cetner">${vo.title }</td>
	      </tr>
		  <tr>
 			<td width="20%" class="text-center danger">첨부파일</td>
		  	<td width="80%">
		  	<a href="../board/download.do?fn=${vo.bfile }"> ${vo.bfile}</a>
		  	</td>
	      </tr>
	      <tr>
	        <td colspan="4" height="500px" class="text-left" valign="top">
	         <pre style="white-space: pre-wrap; background-color: white; border:none ">${vo.content }</pre>
	        </td>
	      </tr>
	      <tr>
	       <td class="text-right" colspan="4">
	         <a href="board_update.do?page=${page}&no=${vo.no}" class="btn btn-xs btn-info">수정</a>
	         <a href="board_delete.do?page=${page}&no=${vo.no}" class="btn btn-xs btn-danger">삭제</a>
	         <a href="list.do" class="btn btn-xs btn-success">목록</a>
	       </td>
	      </tr>
	      <tr style="display:none" id="tr">
	        <td class="text-right inline" colspan="4">
	           <input type=hidden name=no value="${vo.no }" id="data-no">
	           비밀번호 : <input type=password name=pwd class="input-sm"
	                      size=15 id="data-pwd">
	           <input type=button id="del" class="btn btn-sm btn-danger"
	             value="삭제">
	        </td>
	      </tr>
	     </table>

        <h2 class="sectiontitle">댓글</h2>
        <ul>
         <c:forEach var="rvo" items="${replyList }">
	          <li>
	            <article>
	              <header>
	                <figure class="avatar">
	                 <c:if test="${sessionScope.user_id==rvo.user_id}">
	                   <span class="btn btn-xs btn-success updates" data-no="${rvo.no }" style="color:black">수정</span>
	                   <a href="../reply/reply_delete.do?no=${rvo.no }" class="btn btn-xs btn-warning" style="color:black">삭제</a>
	                 </c:if>
	                </figure>
	                <address>
	                By <a href="#">${rvo.user_id}</a>
	                </address>
	              </header>
	              <div class="comcont">
	                <p><pre style="white-space:pre-wrap;background-color:white;border:none">${rvo.content}</pre></p>
	              </div>
	            </article>
	            <table class="table ups" id="${rvo.no }" style="display:none">
	             <tr>
	               <td>
	                 <form method=post action="../reply/reply_update.do">
	                     <input type=hidden name=no value="${rvo.no}">
		                 <textarea rows="5" name="content" cols="48" style="float:left">${rvo.content }</textarea>
		                  <input type=submit value="댓글수정" class="btn btn-primary"
		                  style="height: 30px">
	                 </form>
	               </td>
	             </tr>
	           </table>
	          </li>
	         
          </c:forEach>
          </ul>
        </div>
        <c:if test="${sessionScope.user_id!=null }"><%--로그인이 된 상태 --%>
	        <table class="table">
	             <tr>
	               <td>
	                 <form method=post action="../reply/reply_insert.do">
	                     <input type="hidden" name=rno value="${vo.no }">
	                     <input type=hidden name="type" value="5">
		                 <textarea rows="5" name="msg" cols="48" style="float:left"></textarea>
		                  <input type=submit value="댓글쓰기" class="btn btn-primary"
		                  style="height: 105px">
	                 </form>
	               </td>
	             </tr>
	           </table>
        </c:if>

</body>
</html>