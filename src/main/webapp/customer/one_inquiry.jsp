<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function(){
	$('a.oneTitleBtn').click(function(){
			let group = $(this).attr('groupId')
			let pwdtr="pwd_"+String(group)
			let tr ="one_list_"+String(group)
			if($("."+tr+'>td').css('border')!= '0px none rgb(56, 56, 56)'){
				$("."+tr+'>td').css('border','none')
			}else{
				$("."+tr+'>td').css('border-bottom','1px solid #d5d5d5')
			}
			$('.pwdin_'+group).val('')
			$('.one_pwd_span_'+group).text('')
			$("."+pwdtr).toggle(100)
	})
	
	$('.one_pwd_submit').click(function(){
		let groupId = $(this).attr('groupId')
		let page =$(this).attr('page')
		let pwdin="pwdin_"+String(groupId)
		let pwd = $('.'+pwdin).val()
		if(pwd==""){
			$('.one_pwd_span_'+groupId).text("비밀번호를 입력하시오!")
			return;
		}
		$.ajax({
			 type : 'POST',
	      	 url : 'detail_ok.do',
	      	 data:{"password":pwd,
	      		 "groupId":groupId},
	      	 success:function(res){
	      		 let word = res.split(',')
	      		 let result=word[0]
	      		 let groupId= word[1]
	      		 if(result=='N'){
	      			$('.one_pwd_span_'+groupId).text("비밀번호가 틀렸습니다!")
	      			return;
	      		 }
	      		 location.replace('../customer/one_inquiry_detail.do?groupId='+groupId+'&page='+page)
	      	 }
		})
	})
})
function oneSearch(){
	let keyword=$('#one_search_text').val()
	if($.trim(keyword)==""){
		alert('검색어를 입력하시오!')
		return;
	}
	let sfm = $('#oneserchfm')
	sfm.submit()
}
function resetSearch(){
	$('.one_select option:first-child').prop('selected',true)
	$('#one_search_text').val('')
	let sfm = $('#oneserchfm')
	sfm.submit()
}

function mylistsearch(){
	let userId = '${sessionScope.userId}'
	
	$('.one_search_box').append($('<input/>',{type:'hidden',name:'userid',value:userId}))
	// ajax로 해야할듯 나중에
	/* $('#mylist_search').text('모든글 보기') */
	let sfm = $('#oneserchfm')
	sfm.submit()
}
</script>
</head>
<body>
	<div class="one_title">
		<h3>1:1 문의 게시판</h3>
	</div>
	<form method="post" action="../customer/one_inquiry.do" id="oneserchfm">
		<div class="one_search_bar">
			<c:if test="${sessionScope.userId!=null&& sessionScope.admin==0 }">
				<c:if test="${list[0].mylist=='N'}">
				<a href="javascript:mylistsearch()" id="mylist_search">
					내 글만 보기
				</a>
				</c:if>
			 </c:if>
			 <c:if test="${list[0].mylist=='Y'}">
				 <a href="javascript:resetSearch()" id="mylist_search">
					모든글 보기
				</a>
			</c:if>
			<div class="one_search_box">
				<strong class="one_total_num">
				총
				<em>${totalCount }</em>
				건
				</strong>
				<select class="one_select" name="oneSearchCate">
					<option value="1" ${cate=='1'?'selected':'' }>제목
					</option>
					<option value="2" ${cate=='2'?'selected':'' }>내용
					</option>
					<option value="3" ${cate=='3'?'selected':'' }>제목+내용
					</option>
				</select>
				<label for="one_text">
					<input type="text" name="one_keyword" id="one_search_text" value="${keyword }">
				</label>
				<a href="javascript:oneSearch()" class="one_search_btn">검색</a>
				<c:if test="${keyword!='' }">
					<a href="javascript:resetSearch()" class="one_reset_btn">초기화</a>
				</c:if>
			</div>
		</div>
	</form>
	<table class="one_list">
		<tbody>
		<c:set var="i" value="${totalCount+1 }" />
		<fmt:parseNumber value="${i }" var="is"/> 
			<c:forEach var="vo" items="${list }" >
			<tr class="one_list_tr one_list_${vo.groupId }">
				<td class="one_num" width="8%">${is=(is-1) }</td>
				<td width="3%">
					<c:if test="${vo.secretCk=='N' }">
					<i class="unlock_icon lock" secret="${vo.secretCk }">
						<img src="../img/unlock.png">
					</i>
					</c:if>
					<c:if test="${vo.secretCk=='Y' }">
					<i class="lock_icon lock" secret="${vo.secretCk }">
						<img src="../img/lock.png">
					</i>
					</c:if>
				</td>
				<td class="one_list_title" width="55%">
					<c:if test="${vo.secretCk=='N'|| sessionScope.admin==1 }">
						<a href="../customer/one_inquiry_detail.do?page=${curpage }&groupId=${vo.groupId }" >${vo.title }</a>
					</c:if>
					<c:if test="${vo.secretCk=='Y'&& sessionScope.admin!=1 }">
						<a style="cursor:pointer" class="oneTitleBtn" groupid=${vo.groupId }>${vo.title }</a>
					</c:if>
				<!-- ../customer/one_inquiry_detail.do?page=${curpage }&groupId=${vo.groupId } -->
					<jsp:useBean id="today" class="java.util.Date" />
					<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd" /></c:set>
					<c:if test="${vo.createdAt==date }">
						<sup style="color:red; top: -1;left: 4;">new</sup>
					</c:if>
				</td>
				<td width="10%">
					${vo.username }
				</td>
				<td width="10%">
					${vo.createdAt }
				</td>
				<td class="one_list_answer" width="15%">
					<c:if test="${sessionScope.admin==1 }">
						<c:if test="${vo.replyCheck=='N' }">
							<span>
								<a href="../customer/one_inquiry_detail.do?groupId=${vo.groupId }&page=${curpage}" class="one_list_answer_admin" qid=${vo.groupId } >
								답변하기</a>
							</span>
						</c:if>
					</c:if>	
					<c:if test="${sessionScope.admin!=1||sessionScope.userId == null }">
						<c:if test="${vo.replyCheck=='N'}">
							<img src="../img/red_x.png">
							<span style="color: #DB423B">답변대기</span>
						</c:if>
					</c:if>
					<c:if test="${vo.replyCheck=='Y' }">
							<img src="../img/blue_check.png">
							답변완료
					</c:if>
				</td>
			</tr>
			<c:if test="${vo.secretCk=='Y' }">
				<tr class="one_password_warp pwd_${vo.groupId }" style="border:none;">
					<td colspan="2" class="one_password_td">
						비밀번호 입력 
					</td>
					<td colspan="4" class="one_password_td">
							<input type="hidden" value="${vo.groupId }" class="one_pwd_groupid">
							<input type="password" name="password" size=20 class="one_password pwdin_${vo.groupId }">
							<input type="button" value="입력" class="one_pwd_submit pwd_submit_${vo.groupId }" 
							groupid=${vo.groupId } page=${curpage } size=15> 
							<span class="one_pwd_span_${vo.groupId } " style='color:red; margin-left:10px'></span>
					</td>
				</tr>
			</c:if>
			</c:forEach>
		</tbody>
	</table>
	<div class="one_paging">
		<div class="one_paging_list">
			<ul>
				<c:if test="${startPage>1 }">
					<li>
						<span class="one_page_btn">
							<a href="../customer/one_inquiry.do?page=1">
							&lt;&lt;&nbsp;&nbsp;
							</a>
						</span>
					</li>
				</c:if>
				<c:if test="${curpage!=startPage }">
					<li class="one_active">
						<span class="one_page_btn">
						<a href="../customer/one_inquiry.do?page=${curpage-1 }">
							&lt;&nbsp;&nbsp;
						</a>
						</span>
					</li>
				</c:if>
				<c:forEach var="i" begin="${startPage }" end="${endPage }" step="1" >
					<c:if test="${i==curpage }">
						<li><span class="current">${i }</span></li>
					</c:if>
					<c:if test="${i!=curpage&&i<totalPage }">
						<li><a href="../customer/one_inquiry.do?page=${i }" class="page-link">${i }</a></li>
					</c:if>
				</c:forEach>
				<c:if test="${curpage<totalPage }">
					<li>
						<span class="one_page_btn">
							<a href="../customer/one_inquiry.do?page=${curpage+1 }">
								&gt;
							</a>
						</span>
					</li>
					<li>
						<span class="one_page_btn">
							<a href="../customer/one_inquiry.do?page=${totalPage }">
								&nbsp;&nbsp;&gt;&gt;
							</a>
						</span>
					</li>
				</c:if>
			</ul>
		</div>
	</div>
	<c:if test="${sessionScope.admin!=1 }">
		<div class="one_insert_btn">
			<a href="../customer/one_insert.do">
				<img src="https://cf.channel.io/file/9494/5e6a5e913fe23712201c/deskimage-c56241fe3a0ef051acd171c75b819bf0">
			</a>
		</div>
	</c:if>
</body>
</html>