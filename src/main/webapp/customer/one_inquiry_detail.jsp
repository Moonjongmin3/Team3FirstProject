<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function(){
	$(window).scrollTop(200)
	var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다.
    console.log(position)
	$('#admin_insert_btn').click(function(){
			$('.one_detail_answer_insert').show()
			$('#admin_insert_wrap').show()
			$('#admin_insert_btn_span').hide()
			$('.one_detail_answer_insert>textarea').focus()
	})
	
	$('#one_answer_update').click(function(){
		$('.one_detail_answer_update').show()
		$('.one_detail_ques_delete').hide()
		$('.one_detail_ques_update').hide()
		let groupId = $(this).attr('groupid')
		$.ajax({
			type: 'POST',
	      	url : 'one_answer_update.do',
	      	data:{"groupId":groupId},
	      	 success:function(res){
	      		 console.log(res)
	      		$('#one_detail_answer_wrap').hide()
	      		 $('#one_detail_answer_wrap').before(res);
	      		 $('.admin_update').show()
	      	 }
		})
	})
})
function oneInsertBack(){
		$('.admin_update').remove()
		$('.one_detail_answer_update').hide()
		$('#one_detail_answer_wrap').show()
		$('.one_detail_ques_delete').show()
		$('.one_detail_ques_update').show()
		$(window).scrollTop(200)
	}
function answerInsert(){
	let fm = $('#answerFrm');
	fm.submit()
}	
function answerUpdate(){
	let ufm = $('#answerUpdateFrm');
	ufm.submit()
}


</script>
</head>
<body>
	<div class="one_title">
		<h3>1:1 문의 게시판</h3>
	</div>
	<div class="one_detail_wrap">
		<table class="one_detail_table">
			<tbody>
				<tr id="one_detail_question_wrap">
					<td class="one_detail_top">
						${qvo.title }
						<dl class="one_detail_info">
							<dt>DATE</dt>
							<dd>${qvo.createdAt }</dd>
							<dt>NAME</dt>
							<dd>${qvo.username }</dd>
							<dt>HIT</dt>
							<dd>${qvo.hit }</dd>
						</dl>
					</td>
				</tr>
				<tr style="border:none">
					<td class="one_detail_cont">
						<p style="white-space: normal;">
					 	${qvo.content }
					 	</p>
					</td>
				</tr>
				<c:if test="${avo!=null }">
				<tr id="one_detail_answer_wrap">
					<td class="one_detail_answer">
						<dl>
							<dt>${qvo.username }님께서 문의하신 내용에 대한 답변입니다.</dt>
							<dd>답변 등록일
								<span>
								<fmt:formatDate value="${avo.createdAt }" var="day" pattern="yyyy-MM-dd HH:mm"/>
								${day }
								</span>
							</dd>
						</dl>
						<div class="one_detail_answer_textbox">
							<p>
							${avo.content }
							</p>
							<c:if test="${avo.filename!=null }" >
							<span class="one_detail_filedown">
								<a href="../customer/one_inquery/download.do?groupId=${qvo.groupId }">
								<img src="../img/download_b.png" style="width: 25px; height: 25px"></img>
								${avo.filename }
								</a>
							</span>
							</c:if>
						</div>
						<div class="one_detail_notice">
							<img src="../img/headinfo.jpeg" >
							문제가 해결되셨나요? 더 궁금하신 부분은 새 글로 질문을 주셔야 빠른 답변이 가능합니다.<br>
							자세한 상담을 원하시면 <span style="color: #ee2d30;">쌍용Books 고객센터 (1811-9415)</span>로 연락바랍니다.
						</div>
					</td>
				</tr>
				</c:if>
				<c:if test="${avo==null && sessionScope.admin==1 }">
				<tr id="admin_insert_wrap">
					<td class="one_insert_answer">
						<form  action="../customer/one_insert_ok.do?groupId=${qvo.groupId }" method="post" enctype="multipart/form-data" id="answerFrm">
							<div class="one_insert_answer_top">
								<h3>답변하기</h3>
								<span>파일첨부&nbsp;
									<input type="file" name="file" size=10 style="display: inline-block;">
								</span>
							</div>
							<div class="one_detail_answer_insert">
								<textarea cols="100" rows="20" name="content"></textarea>
							</div>
						</form>
					</td>
				</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<div class="one_detail_btnbox">
		<a href="../customer/one_inquiry.do?page=${page }" class="one_detail_cancel">목록보기</a>
		<c:if test="${avo==null && sessionScope.admin==1 }">
			<span class="one_detail_answer_insert" id="admin_insert_btn_span" >
				<a class="btn btn-sm" id="admin_insert_btn">답변작성</a>
			</span>
		</c:if>	
			<span class="one_detail_answer_insert" style="display:none">
				<a href="javascript:oneInsertBack()" class="btn btn-sm" style="background-color:#008B8B;margin-right: 5px;">취소</a>
				<a href="javascript:answerInsert()" class="btn btn-sm"  style="background-color:#4169E1;">답변제출</a>
			</span>
			<span class="one_detail_answer_update" style="display:none">
				<a href="javascript:oneInsertBack()" class="btn btn-sm" style="background-color:#008B8B;margin-right: 7px;">취소</a>
				<a href="javascript:answerUpdate()" class="btn btn-sm"  style="background-color:#4169E1;">수정</a>
			</span>
		<c:if test="${avo!=null && sessionScope.admin==1 }">
				<span class="one_detail_ques_delete" id="">
					<a class="btn btn-sm" href="../customer/one_delete.do?groupid=${avo.groupId }" style="background-color:#008B8B;">답변삭제</a>
				</span>
				<span class="one_detail_ques_update" id="">
					<a class="btn btn-sm" id="one_answer_update" groupid="${avo.groupId }" style="background-color:#4169E1;">답변수정</a>
				</span>
		</c:if>
		<c:if test="${qvo.userId==sessionScope.userId }">
			<span class="one_detail_ques_delete" id="">
				<a class="btn btn-sm" href="../customer/one_delete.do?groupid=${qvo.groupId }" style="background-color:#008B8B;">문의삭제</a>
			</span>
			<span class="one_detail_ques_update" id="">
				<a class="btn btn-sm" id="" style="background-color:#4169E1;">문의수정</a>
			</span>
		</c:if>
	</div>

	<div class="one_detail_bottom"></div>
	<c:if test="${sessionScope.admin!=1 }">
	<div class="one_insert_btn">
		<a href="../customer/one_insert.do">
			<img src="https://cf.channel.io/file/9494/5e6a5e913fe23712201c/deskimage-c56241fe3a0ef051acd171c75b819bf0">
		</a>
	</div>
	</c:if>
</body>
</html>