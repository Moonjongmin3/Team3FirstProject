<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<form action="../customer/one_question_update_ok.do?groupId=${vo.groupId }&page=${page}" method="post" enctype="multipart/form-data" id="ofm">
	<table class="one_detail_table" id="one_ques_update_win" state="3">
		<tbody>
			<tr>
				<td class="one_insert_top" >
					제목 &nbsp;<input type="text" name="title" size=70 value="${vo.title }">
				<span class="one_insert_name">문의자 명 : ${sessionScope.userName }</span>
				</td>
			</tr>
			<tr>
				<td class="one_insert_secret">
					<span>잠금</span><input type="checkbox" name="secretCk" ${vo.secretCk=='N'?'':'checked' }>
					<span class="one_insert_password">비밀번호 <input type="password" name="password" size=13 ></span>
					<span class="one_insert_file">파일첨부 <input type="file" name="file" size=13></span>
					<span style="font-size:13px;display: block;margin-top:5px;">
					최근 수정일 : ${vo.updateAt }
					</span>
				</td>
			</tr>
			<tr>
				<td>
					<textarea rows="20" cols="100" placeholder="내용을 입력하시오" name="content">${vo.content }</textarea>
				</td>
			</tr>
		</tbody>
	</table>
</form>			
		