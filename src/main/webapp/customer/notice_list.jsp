<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="top">
		<h3>공지사항</h3>
		<div class="notice_search_bar">
			 <div class="notice_search-area">
			 <form method="get" action="../customer/notice.do">
				 <select name="type">
					<option ${(type=="TC")?"selected":""} value="TC">제목+내용</option>
					<option ${(type=="title")?"selected":""} value="title">제목</option>
					<option ${(type=="content")?"selected":""} value="content">내용</option>
				</select>
				<input type="text" placeholder="검색어를 입력해 주세요" value="${notice_keyword }" size=23 name="notice_keyword">
				<button type="submit" class="notice_search_btn"></button>
				<div class="search_icon"></div>
			</form>
			</div>
		</div>
	</div>
	<div class="contents">
		<div class="contents_top">
			<ul>
				<li>순번</li>
				<li>제목</li>
				<li>조회수</li>
				<li>등록일</li>
			</ul>
		</div>
		<div class="contents_main">
			<c:forEach items="${notice_list}" var="list" varStatus="i">
			<ul>
				<li>${list.no}</li>
				<li><a href="../customer/notice_detail.do?page=${curpage}&no=${list.no}">${list.title}</a>
					<jsp:useBean id="today" class="java.util.Date" />
					<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd" /></c:set>
					<c:if test="${list.created_At==date }">
						<sup style="color:red">new</sup>
					</c:if>
				 </li>
				<li>${list.hit }</li>
				<li>${list.created_At}</li>
			</ul>
			</c:forEach>
		</div>
		<div class="contents_page">
			<!-- 넘김 버튼 변경 예정 -->
			<ul>
				<c:if test="${curpage!=1}">
					<li class="prev_first"><a href="notice.do?page=1&type=${type}&keyword=${keyword}" class="pageicon"></a></li>
					<li class="prev"><a href="notice.do?page=${curpage-1}&type=${type}&keyword=${keyword}" class="pageicon"></a></li>
				</c:if>
				<c:forEach var="i" begin="${startpage}" end="${endpage}" step="1">
					<li class="page_list"><a href="notice.do?page=${i}&type=${type}&keyword=${keyword}" ${i==curpage?"style='color: #0052d4'":""} class="pagenum">${i}</a></li>
				</c:forEach>
				<c:if test="${curpage!=endpage}">
					<li class="next" ><a href="notice.do?page=${curpage+1}&type=${type}&keyword=${keyword}" class="pageicon"></a></li>
					<li class="next_end"><a href="notice.do?page=${total}&type=${type}&keyword=${keyword}" class="pageicon"></a></li>
				</c:if>
			</ul>
			<c:if test="${sessionScope.admin==1}">
				<div class="notice_write">
				<form action="notice_insert.do" method="get">
					<input type="hidden" name="page" value="${curpage }" style="display: inline-block;">
					<button class="btn btn-sm btn-info text-right" style="display: inline-block;">글쓰기</button>
				</form>
				</div>
			</c:if>
		</div>
	</div>	
</body>
</html>