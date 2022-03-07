<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                        <td width="85%" colspan="3" style="background-color: white">${notice.title}</td>
                    </tr>
                    <tr>
                        <td width="15%" class="text-center" style="background-color: #cdcdcd">날짜</td>
                        <td width="25%">${notice.created_At}</td>
                        <td width="15%" class="text-center" style="background-color: #cdcdcd">조회수</td>
                        <td width="25%">${notice.hit}</td>
                    </tr>
                    <tr>
                    	<td width="15%" class="text-center" style="background-color: #cdcdcd">첨부파일</td>
                    	<td width="85%" colspan="3">
                    	<a href="../customer/download.do?fn=${notice.filename }"> ${notice.filename}</a> (${notice.filesize }Bytes)
                    	</td>
                    </tr>
                    <tr>
                        <td colspan="4" height="600px" valign="top" style="padding:10px 15px; ">
                        <pre>${notice.content}</pre>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right" colspan="4">
                            <c:if test="${sessionScope.admin==1}">
                                <a href="notice_update.do?page=${page}&no=${notice.no}" class="btn btn-xs btn-info">수정</a>
                                <a href="notice_delete.do?page=${page}&no=${notice.no}" class="btn btn-xs btn-danger">삭제</a>
                            </c:if>
                            <a href="notice.do?page=${page }" class="btn btn-xs btn-success">목록</a>
                        </td>
                    </tr>
                </table>
      
</body>
</html>