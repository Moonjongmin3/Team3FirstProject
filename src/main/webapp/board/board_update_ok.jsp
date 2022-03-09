<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
	<c:if test="${bCheck==true }">
	 <c:redirect url="../board/detail.do?no=${no }&page=${page }"/>
	</c:if>
	<c:if test="${bCheck==false }">
	 <script>
	 alert("비밀번호가 틀립니다!")
	 history.back();
	 </script>
	</c:if>
</c:choose>