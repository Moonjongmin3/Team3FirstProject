<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
function submit(){
	let f =$('#ofm')
	f.submit();
}
</script>
</head>
<body>
	<div class="one_title">
		<h3>1:1 문의 등록하기</h3>
	</div>
	<div class="one_detail_wrap">
		<form action="../customer/one_insert_ok.do" method="post" enctype="multipart/form-data" id="ofm">
			<table class="one_detail_table">
				<tbody>
					<tr>
						<td class="one_insert_top" >
							제목 &nbsp;<input type="text" name="title" size=70 >
							<span class="one_insert_name">문의자 명 : ${sessionScope.userName }</span>
						</td>
					</tr>
					<tr>
						<td class="one_insert_secret">
							<span>잠금</span><input type="checkbox" name="secretCk" value="Y">
							<span class="one_insert_password">비밀번호 <input type="password" name="password" size=13></span>
							<span class="one_insert_file">파일첨부 <input type="file" name="file" size=13></span>
						</td>
					</tr>
					<tr>
						<td>
							<textarea rows="20" cols="100" placeholder="내용을 입력하시오" name="content"></textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<div class="one_insert_btnbox">
		<a href="javascript:submit()" class="btn btn-sm">작성하기</a>
		<a href="javascript:history.back()" class="btn btn-sm">작성취소</a>
	</div>
</body>
</html>