<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<tr id="admin_insert_wrap">
	<td class="one_insert_answer">
		<form  action="../customer/one_insert_ok.do?groupId=${qvo.groupId }" method="post" enctype="multipart/form-data" id="answerFrm">
			<div class="one_insert_answer_top">
				<h3>답변하기</h3>
					<span>파일첨부&nbsp;
						<input type="file" name="file" size=10 style="display: inline-block;" value="${vo.filename }">
					</span>
				</div>
			<div class="one_detail_answer_insert">
				<textarea cols="100" rows="20" name="content">${vo.content }</textarea>
			</div>
		</form>
	</td>
</tr>