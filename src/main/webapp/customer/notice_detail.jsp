<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세</title>
</head>
<body>
    
                <h3>공지사항</h3>
                <table class="table">
                    <tr style="background-color: #cdcdcd">
                        <td width="15%" colspan="1" class="text-center">제목</td>
                        <td width="85%" colspan="3" class="text-left" style="background-color: white">${notice.title}</td>
                    </tr>
                    <tr>
                        <td width="15%" class="text-center" style="background-color: #cdcdcd">날짜</td>
                        <td width="25%">${notice.created_At}</td>
                        <td width="15%" class="text-center" style="background-color: #cdcdcd">조회수</td>
                        <td width="25%">${notice.hit}</td>
                    </tr>
                    <c:if test="${notice.filesize!=0 }">
                    <tr>
                    	<td width="15%" class="text-center" style="background-color: #cdcdcd">첨부파일</td>
                    	<td width="85%" colspan="3" class="text-left">
                    	<fmt:formatNumber value="${notice.filesize/1024 }" pattern=".0" var="size"/>
                    		<a href="../customer/download.do?fn=${notice.filename }"> ${notice.filename}</a> (${size}KB)
                    	</td>
                    </tr>
                    </c:if>
                    <tr>
                        <td colspan="4" height="600px" valign="top" style="padding:10px 15px;text-align: left">
                        <pre>${notice.content}</pre>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right" colspan="4">
                            <c:if test="${sessionScope.admin==1}">
                                <a href="notice_update.do?page=${page}&no=${notice.no}" class="btn btn-sm btn-info">수정</a>
                                <a href="notice_delete.do?page=${page}&no=${notice.no}" class="btn btn-sm btn-danger">삭제</a>
                            </c:if>
                            <a href="notice.do?page=${page }" class="btn btn-sm btn-success">목록</a>
                        </td>
                    </tr>
                </table>
      
</body>
</html>