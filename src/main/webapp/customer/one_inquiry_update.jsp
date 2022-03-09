<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<tr id="admin_insert_wrap" class="admin_update">
	<td class="one_insert_answer" >
		<form  action="../customer/one_answer_update_ok.do?groupId=${vo.groupId }&page=${page}" method="post" enctype="multipart/form-data" id="answerUpdateFrm">
			<div class="one_insert_answer_top">
				<h3>답변하기</h3>
					<span>파일첨부&nbsp;
						<input type="file" name="file" size=10 style="display: inline-block;">
					</span>
					<span style="font-size:13px;display: block;margin-top:5px;">
					최근 수정일 : ${vo.updateAt }
					</span>
				</div>
			<div class="one_detail_answer_insert">
				<textarea cols="100" rows="20" name="content">${vo.content }</textarea>
			</div>
		</form>
	</td>
</tr>