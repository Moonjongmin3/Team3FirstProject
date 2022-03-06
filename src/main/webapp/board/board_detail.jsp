<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.BoardModel"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
th{
  color:black;
}
.row{
  margin: 0px auto;
  width:800px;
}
</style>
</head>
<body>
  <div class="container">
   <h3>자유게시판 상세보기</h3>
    <div class="row">
     <table class="table">
      <tr>
       <th width=20% class="text-center danger">번호</th>
       <td width=30% class="text-center">${vo.no }</td>
       <th width=20% class="text-center danger">작성일</th>
       <td width=30% class="text-center">
       <fmt:formatDate value="${vo.created_at }" pattern="yyyy-MM-dd"/></td>
      </tr>
      <tr>
       <th width=20% class="text-center danger">이름</th>
       <td width=30% class="text-center">${vo.user_id }</td>
       <th width=20% class="text-center danger">조회수</th>
       <td width=30% class="text-center">${vo.hit }</td>
      </tr>
      <tr>
       <th width=20% class="text-center danger">제목</th>
       <td colspan="3">${vo.subject }</td>
      </tr>
      <tr>
        <td colspan="4" height="200" class="text-left" valign="top">
         <pre style="white-space: pre-wrap;background-color: white;border:none">${vo.content }</pre>
        </td>
      </tr>
      <tr>
       <td class="text-right" colspan="4">
         <a href="../board/update.do?no=${vo.no }" class="btn btn-xs btn-danger">수정</a>
         <span class="btn btn-xs btn-success" id="delBtn">삭제</span>
         <a href="../board/list.do" class="btn btn-xs btn-info">목록</a>
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
     
    </div>
<!--  <div id="comments">
        <h2 class="sectiontitle">댓글</h2>
        <ul>
         <c:forEach var="rvo" items="${rList }">
	          <li>
	            <article>
	              <header>
	                <figure class="avatar">
	                 <c:if test="${sessionScope.id==rvo.id}">
	                   <span class="btn btn-xs btn-success updates" data-no="${rvo.no }" style="color:black">수정</span>
	                   <a href="../reply/reply_delete.do?no=${rvo.no }&rno=${rvo.rno}&tp=5" class="btn btn-xs btn-warning" style="color:black">삭제</a>
	                 </c:if>
	                </figure>
	                <address>
	                By <a href="#">${rvo.name}(${rvo.dbday })</a>
	                </address>
	              </header>
	              <div class="comcont">
	                <p><pre style="white-space:pre-wrap;background-color:white;border:none">${rvo.msg }</pre></p>
	              </div>
	            </article>
	            <table class="table ups" id="m${rvo.no }" style="display:none">
	             <tr>
	               <td>
	                 <form method=post action="../reply/reply_update.do">
	                     <input type="hidden" name=rno value="${vo.no }">
	                     <input type=hidden name=no value="${rvo.no}">
	                     <input type=hidden name=tp value="5">
		                 <textarea rows="5" name="msg" cols="48" style="float:left">${rvo.msg }</textarea>
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
        <c:if test="${sessionScope.id!=null }"><%--로그인이 된 상태 --%>
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
        </c:if>-->
   </div>
</body>
</html>