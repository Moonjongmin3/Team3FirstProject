<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>공지사항 작성</h3>
	<form method="post" action="notice_insert_ok.do" enctype="multipart/form-data">
		<table class="table">
			<tr style="background-color: #cdcdcd">
				<td width="20%" class="text-center" style="font-size: 17px"><b>제목</b></td>
				<td width="80%" style="background-color: white; padding: 0">
					<input type="text" name="title" size="85"
						style="border: none; line-height: 40px; padding-left: 10px">
					<input type="hidden" name="admin_id" value="${sessionScope.userId }"> 
				</td>
			</tr>
			<tr>
				<td width="15%" class="text-center" style="background-color: #cdcdcd"><b>첨부파일</b></td>
				<td width="85%" colspan="3">
					<input type=file name=upload size=20 class="input-sm">
				</td>
			</tr>
			<tr>
				<td colspan="4" height="300px" valign="top" style="padding: 0">
					<textarea rows="20" cols="100" name="content"
						style="border: none; margin: 0; padding: 10px 10px"></textarea>
				</td>
			</tr>
			<tr>
				<td class="text-right" colspan="2">
					<c:if test="${sessionScope.admin==1}">
						<button class="btn btn-sm btn-danger">작성</button>
					</c:if>
					<input type="button" value="취소" class="btn btn-sm btn-warning"
						onclick="javascript:history.back()">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>