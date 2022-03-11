<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="../js/search.js"></script>
<script type="text/javascript">


$(function(){
	 
	var currentPosition = parseInt($("#scroll").css("top"));
	
	  $(window).scroll(function() {
	     var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다.
	     console.log(position)
	     if(position>250){
	     	$('#top_icon').show()
	     	$("#scroll").stop().animate({"top":position+45+"px"},300);
	  	 }else{
		    $('#top_icon').hide()
		     $("#scroll").stop().animate({"top":currentPosition+"px"},300);
	  	 }
	  	 if(position>2674){
		 	$("#scroll").stop().animate({"top":2710+"px"},100);
	     }
	});
	    
	let length =${fn:length(svo.subcategory)}
	let list = [];
	<c:forEach var="cate" items="${svo.subcategory}" varStatus="status">
		list.push("${cate}");
	</c:forEach>
	for(let i=0;i<length;i++){
		$('.subChk_'+list[i]).prop("checked",true)
	}
	
	$('input[name=bookChk]').click(function(){
		let total = $('input[name=bookChk]').length;
		let checked=$('input[name=bookChk]:checked').length;
		
		if(total!=checked){
			$('.bWrap').text("전체선택")
			i=0;
		}
	})
	$('input[name=rekeyword_except]').click(function(){
		if($('input[name=inResearch]').val().trim()==""){
			$('input[name=rekeyword_except]').prop("checked",false)
			alert('검색내 검색 값을 입력하시오!!')
			$('input[name=inResearch]').focus()
			return false;
		}
	})
	$('#go_top').click(function(){
		$(window).scrollTop(0);
	})
	
	$('.search_buy_input').click(function(){
		let id = $(this).attr("value")
		let qty = $('#input_cnt_'+id).val()
		
		var pform = $('<form></form>');
		pform.attr("method","GET")
		pform.attr("action","../pay/order.do")

		pform.append($('<input/>',{type:'hidden',name:'no',value:id}));
		pform.append($('<input/>',{type:'hidden',name:'qty',value:qty}));
		
  		pform.appendTo('body');
  		document.charset="UTF-8"

  		pform.submit();
		
	})
	
	$('.btn_plus').click(function(){
		let id = $(this).attr('book-id')
		console.log(id)
		let count=$("#input_cnt_"+id).val()
		count = (Number(count)+1)
		$("#input_cnt_"+id).val(count)
	})
	
	$('.btn_down').click(function(){
		let id = $(this).attr('book-id')
		let count=$("#input_cnt_"+id).val()
		count = (Number(count)-1)
		if(count===0){
			alert("1개 이상 구입할 수 있습니다.")
			$("#input_cnt_"+id).val(1)
			return;
		}else{
			$("#input_cnt_"+id).val(count)
		}
	})
})
</script>
<style type="text/css">
/*  모달 창 css */
    #cart-modal{
	display: none;
	position: absolute;
	top: 0;
	width: 100vw;
	height: 100vh;
	z-index: 30;
	background-color: rgba(0,0,0,0.5);
}
.modal-content{
	width: 30vw;
	height: 20vw;
	background-color: white;
	top: 50%;
	left: 50%;
	margin: -20vh 0 0 -15vw;
	padding: 10px 0 0 10px;
	text-align: center;
	line-height: 20px;
}
.modal-content>h3{
	margin: 5px 0 -20px 0;
}
.glyphicon-shopping-cart{
	color: #0052D4;
	font-size: 50px;
	margin: 0 0 30px 0;
}
.cart-ok-btn{
	margin-top: 20px;
}
.cart-ok-btn.btn-primary{
	background-color: #0052D4;
}
@media screen and (max-width: 1200px) {
	.modal-content{
		width: 40vw;
		height: 26.6vw;
		top: 50%;
		left: 50%;
		margin: -20vh 0 0 -20vw;
	}
}
@media screen and (max-width: 992px) {
	.modal-content{
		width: 50vw;
		height: 33.3vw;
		top: 50%;
		left: 50%;
		margin: -20vh 0 0 -25vw;
	}
}
@media screen and (max-width: 768px) {
	.modal-content>h3{
		margin: 0 0 -30px 0;
	}
	.glyphicon-shopping-cart{
		font-size: 25px;
		margin: 0 0 10px 0;
	}
}
</style>
</head>
<body>
	<section class="search-result">
		<!-- 장바구니 모달 창 시작 --> 
		<div id="cart-modal">
			<div class="modal-content">
				<h3 class="xs-hidden"><strong>Cart</strong></h3><br>
				<hr class="xs-hidden">
				<span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span><br>카트에 성공적으로 담았습니다!<br>
				<button class="btn cart-ok-btn btn-primary" id="cart-ok-btn">확인</button>
				<button class="btn cart-ok-btn btn-default" onclick="location.href='../cart/Cart.do'">카트로 가기</button>
			</div>
		</div>
		<!-- 장바구니 모달 창 끝 --> 
		<div class="search-result-wrap">
			<div id="scroll_top">
					<span>
						<a href="#" id="go_top">
							<img src="../img/up.jpeg" id="top_icon">
						</a>
					</span>
			</div>
			<!-- 검색내 결과 시작-->
			<div class="search-result-option" id="scroll">
				<div class="left_conts" >
				<!-- 미구현 -->
					<div style="margin-bottom: 7px;">
						<span style="color: #5d5d5d; font-size: 13px;">
							<b>결과내 검색</b>
						</span>
					</div>
					<div style="margin-bottom: 7px;">
						<input type="text" name="inResearch" style="border: 1px solid #dedede;" value="${svo.reKeyword }">
					</div>
					<div style="float: left; ">
						<input type="checkbox" id="except_search" name="rekeyword_except"  ${svo.keywordExcept=='Y'?"checked":""}>
						<label for="except_search" class="bo2">
						검색어 제외
						</label> 
					</div>
					<div style="float: right; padding-top: 3px;">
						<input type="button" class="btn btn-sm" id="research_btn" onclick="search()" value="적용" >
					</div>
					<!-- 미구현 -->
				</div>
				<!-- 검색내 결과 끝 -->
				<div class="ss_space"></div>
				<!-- 검색조건 시작 -->
				<div class="left_conts">
					<div style="margin-bottom: 7px;">
					<!-- 미구현 -->
						<span style="color: #5d5d5d; font-size: 13px;">
							<b>검색조건</b>
						</span>
					</div>
					<form method="post" action="../book/bookList.do" id="taft_frm">
					<div>
						<ul style="list-style: none; padding-left: 0; margin-bottom: 0px;">	
							<c:forEach items="${svo.taft }" var="taft">
								<c:choose>
									<c:when test="${taft=='title'}">
										<c:set var="tCheck" value="checked"/>
									</c:when>
									<c:when test="${taft=='author'}">
										<c:set var="aCheck" value="checked"/>
									</c:when>
									<c:when test="${taft=='publisher'}">
										<c:set var="pCheck" value="checked"/>
									</c:when>
									<c:otherwise>
										<c:set var="gCheck" value="checked"/>
									</c:otherwise>
								</c:choose>
							</c:forEach>				
							<li>
								<input type="checkbox" id="search_field_KeyTitle" name="taftck" value="title" ${tCheck}>
								<label for="search_field_KeyTitle" class="bo2">
									제목
								</label>
							</li>
							<li>
								<input type="checkbox" id="search_field_KeyAuthor" name="taftck" value="author" ${aCheck}>	
								<label for="search_field_KeyTitle" class="bo2">
									저자
								</label>
							</li>
							<li>
								<input type="checkbox" id="search_field_KeyPublisher" name="taftck" value="publisher" ${pCheck}>
								<label for="search_field_KeyTitle" class="bo2">
									출판사
								</label>
							</li>
							<li>
								<input type="checkbox" id="search_field_KeyTag" name="taftck" value="tag" ${gCheck}>
								<label for="search_field_KeyTitle" class="bo2">
									태그
								</label>
							</li>
							<!-- 미구현 -->
						</ul>
						
					</div>
					<div style="float: right;">
						<input type="button" class="btn btn-sm" id="taft_btn" onclick="search();" value="적용">
					</div>
					</form>
				</div>
				<!-- 검색조건 끝 -->
				<div class="ss_space"></div>
				<!-- 분야별 보기 시작 -->
				<div class="left_conts">
					<div style="margin-bottom: 7px;">
						<span style="color: #5d5d5d; font-size: 13px;">
							<b>분야별 보기</b>
						</span>
					</div>
					<form method="post" action="../book/bookList.do" id="subcate_frm">
					<div class="search_left_list">
						<ul style="height: 245px;overflow:auto">
							<c:forEach items="${subCountList}" var="vo">		
								<c:if test="${vo.mainId==1}">
									<c:if test="${vo.subId==0 }">
										<li>
											<span style="font-weight: bold; font-size: 13px;">${vo.mainCateName }</span>
										</li>
									</c:if>
									<c:if test="${vo.subId!=0 }">
									<li>
										<input type="checkbox" value="${vo.subId }" id="serarch_category_1_${vo.subId }" class="subChk_${vo.subId }" 
												name="search_left_categoty">
										<label for="serarch_category_1_${vo.subId }" class="bo2" style="cursor: pointer;" title="${vo.mainCateName }">
												${vo.subCateName }
											<span class="ss_f_g">(${vo.subCount })</span>
										</label>
									</li>
									</c:if>
								</c:if>
								<c:if test="${vo.mainId==2}">
									<c:if test="${vo.subId==0 }">
										<li>
											<span style="font-weight: bold; font-size: 13px;">${vo.mainCateName }</span>
										</li>
									</c:if>
									<c:if test="${vo.subId!=0 }">
									<li>
										<input type="checkbox" value="${vo.subId }" id="serarch_category_2_${vo.subId }" class="subChk_${vo.subId }" 
												name="search_left_categoty">
										<label for="serarch_category_2_${vo.subId }" class="bo2" style="cursor: pointer;" title="${vo.mainCateName }">
											${vo.subCateName }
											<span class="ss_f_g">(${vo.subCount })</span>
										</label>
									</li>
									</c:if>
								</c:if>
								<c:if test="${vo.mainId==3}">
									<c:if test="${vo.subId==0 }">
										<li>
											<span style="font-weight: bold; font-size: 13px;">${vo.mainCateName }</span>
										</li>
									</c:if>
									<c:if test="${vo.subId!=0 }">
									<li>
										<input type="checkbox" value="${vo.subId }" id="serarch_category_3_${vo.subId }" class="subChk_${vo.subId }"
												name="search_left_categoty">
										<label for="serarch_category_3_${vo.subId }" class="bo2" style="cursor: pointer;" title="${vo.mainCateName }">
											${vo.subCateName }
											<span class="ss_f_g">(${vo.subCount })</span>
										</label>
									</li>
									</c:if>
									</c:if>
							</c:forEach>
						</ul>
					</div>
					<div style="float: right;">
					<c:if test="${svo.subcategory[0]!='all'}">
						<input type="button" class="btn btn-sm" id="subcateDelBtn" onclick="subCateDel()" value="전체취소">
					</c:if>
						<input type="button" class="btn btn-sm" id="subcateBtn" onclick="search();" value="적용">
					</div>
					</form>
				</div>
			</div>
			<!-- 메인 출력 시작 -->
			<div class="search-result-content">
				<div class="search-content-top">
					<c:if test="${ svo.subcategory[0]!='all' }">
					<div class="selSubCate">
						선택한 분야 :
						<c:forEach items="${subCountList}" var="subna">
							<c:forEach var="sb" items="${svo.subcategory }">
								<c:if test="${subna.subId==sb }">
									<span>
						  				${subna.subCateName }
									</span>
								</c:if>
							</c:forEach>
						</c:forEach>
					</div>
					</c:if>
					<span class="search_t_g">
						<c:if test="${svo.reKeyword=='' }">
							<c:if test="${svo.keyword!='' }">
								검색어<span class="result_l"><strong>"${keyword }"</strong></span>
							</c:if>
							총
							<span class="search_r_c_count">${totalCount} </span>					
							개의 상품이 검색되었습니다.
						</c:if>
						<c:if test="${svo.reKeyword!='' }">
							검색어
							<c:if test="${svo.keywordExcept=='N'}">
							<span class="result_l"><strong>"${keyword }"</strong></span>
							검색결과 내 재검색어
							</c:if>
							<span class="result_l"><strong>"${svo.reKeyword }"</strong></span>
							총
							<span class="search_r_c_count">${totalCount} </span>					
							개의 상품이 검색되었습니다.
						</c:if>
					</span>
					<table class="search-result-count">
						<tbody>
							<tr>
								<td valign="bottom" style="padding-top:0px; text-align: left;">
									<ul>
										<!-- 통합검색 -->
										<c:if test="${!(mainCountArr[1]==0&&mainCountArr[2]==0||
													mainCountArr[1]==0&&mainCountArr[3]==0||
													mainCountArr[2]==0&&mainCountArr[3]==0) 
													}">
											<c:if test="${category==4}">
	                        	 				<c:set var="cate4" value="current_maincate"/>
	                        				</c:if>
	                        				<c:if test="${svo.subcategory[0]=='all' }">
											<li class="${cate4} main_part" >
												<a href="javascript:mainBtn(4)" >
													<strong>통합검색</strong>
													<br>
													<span class="search_t_w_n">(${mainCountArr[0]})</span>
												</a>
											</li>
											<li class="cate_part"></li>
											</c:if>
										</c:if>
										<c:if test="${mainCountArr[1]!=0 }">
											<!-- 국내도서 -->
											<c:if test="${category==1 || mainCountArr[2] ==0 && mainCountArr[3]==0  }">
	                        	 				<c:set var="cate1" value="current_maincate"/>
	                        				</c:if>
											<li class="${cate1} main_part" >
											<a href="javascript:mainBtn(1)">
												<strong>국내도서</strong>
												<br>
												<span class="search_t_w_n">(${mainCountArr[1]})</span>
											</a>
											</li>
										</c:if>
										<c:if test="${mainCountArr[1]!=0 && mainCountArr[2]!=0 }">
											<li class="cate_part"></li>
										</c:if>
										<c:if test="${mainCountArr[2]!=0 }">
										<!-- 외국도서 -->
											<c:if test="${category==2 || mainCountArr[1] ==0 && mainCountArr[3]==0}">
	                        	 				<c:set var="cate2" value="current_maincate"/>
	                        				</c:if>
											<li class="${cate2} main_part">
												<a href="javascript:mainBtn(2)" >
													<strong>외국도서</strong>
													<br>
													<span class="search_t_w_n">(${mainCountArr[2]})</span>
												</a>
											</li>
										</c:if>
										<c:if test="${mainCountArr[3]!=0 }">
										<li class="cate_part"></li>
											<!-- eBook -->
											<c:if test="${category==3 || mainCountArr[1] ==0 && mainCountArr[2]==0}">
	                        	 				<c:set var="cate3" value="current_maincate"/>
	                        				</c:if>
											<li class="${cate3} main_part">
												<a href="javascript:mainBtn(3)">
													<strong>eBook</strong>
													<br>
													<span class="search_t_w_n">(${mainCountArr[3]})</span>
												</a>
											</li>
										</c:if>
									</ul>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="ss_line">
					<table width="100%" cellspacing="0" cellpadding="0">
						<tbody>
							<tr >
							<!-- 미구현 -->
								<td height="29" width="600">
									<ul>
									<c:choose>
										<c:when test="${svo.sort=='hot' }">
											<c:set var="sort1" value="currnt_sort"/>
										</c:when>
										<c:when test="${svo.sort=='sellsort' }">
											<c:set var="sort2" value="currnt_sort"/>
										</c:when>
										<c:when test="${svo.sort=='day' }">
											<c:set var="sort3" value="currnt_sort"/>
										</c:when>
										<c:when test="${svo.sort=='review' }">
											<c:set var="sort4" value="currnt_sort"/>
										</c:when>
										<c:otherwise>
											<c:set var="sort5" value="currnt_sort"/>
										</c:otherwise>
									</c:choose>
										<li>
											<a class="search_sort ${sort1 }"  onclick="sortBtn('hot')" sorted="hot">인기순</a>
										</li>
										<li>
											<a class="search_sort ${sort2 }" onclick="sortBtn('sellsort')" sorted="sellsort">판매량순</a>
										</li>
										<li>
											<a class="search_sort ${sort3 }" onclick="sortBtn('day')" sorted="day">출시일순</a>
										</li>
										<li>
											<a class="search_sort ${sort5 }" onclick="sortBtn('price')" sorted="price">저가격순</a>
										</li>
									</ul>
								</td>
								<td>
									<a href="javascript:checkAll()" class="check_all_btn">
										<span class="bWrap">
											전체선택
										</span>
									</a>
								</td>
								<!-- 미구현 -->
								<td style="text-align: center">
									<select id="except" onchange="search()">
										<option value="Y" ${svo.stockCheck=='Y'?'selected':'' }>품절포함</option>
										<option value="N" ${svo.stockCheck=='N'?'selected':'' }>품절제외</option>
									</select>
								</td>
								<td style="text-align: center">
									<select id="rowSize" onchange="search()">
										<option value="10" ${svo.rowSize==10?'selected':'' }>10개씩 보기</option>
										<option value="20" ${svo.rowSize==20?'selected':'' }>20개씩 보기</option>
										<option value="40" ${svo.rowSize==40?'selected':'' }>40개씩 보기</option>
									</select>
								</td>
								<!-- 미구현 -->
							</tr>
						</tbody>
					</table>
				</div>
				<div class="ss_line_2">
					<div class="search_paging_bar">
						<c:if test="${startPage>1 }">
						<a href="javascript:pageNum(1)" class="btn_prev">
							<img src="../img/btn_prev05_on.gif" alt="첫 페이지">
						</a>
						<a href="javascript:pageNum(${endPage-5 })" class="btn_prev">
							<img src="../img/btn_prev03_on.gif" alt="이전 블록 첫 페이지">
						</a>
						</c:if>
						<ul id="paging">
							<c:forEach var="i" begin="${startPage }" end="${endPage }">
							<c:if test="${i==curpage }">
                        	 <c:set var="style" value="class=current_page"/>
                        	</c:if>
                        	<c:if test="${i!=curpage }">
                        	 <c:set var="style" value=""/>
                        	</c:if>
                        	<li ${style }><a href="javascript:pageNum(${i })">${i }</a></li>
							</c:forEach>
						</ul>
							<c:if test="${endPage<totalPage }">
							<a href="javascript:pageNum(${endPage+1 })" class="btn_prev">
								<img src="../img/btn_next03_on.gif" alt="다음 블록 첫페이지">
							</a>
							<a href="javascript:pageNum(${totalPage })" class="btn_prev">
								<img src="../img/btn_next05_on.gif" alt="마지막 페이지">
							</a>
							</c:if>
						<div class="search_total_page">
						<!-- 미구현 -->
							<input type="text" class="search_count_input" id="jumpPagetxt" value="${curpage }">
							/ 총
							<span>${totalPage }</span>
							페이지
						</div>
						<div class = "search_paging_btn">
							<a href="#">
								<span>
									카트에넣기
								</span>
							</a>
							<a href="#">
								<span>
									찜목록에넣기
								</span>
							</a>
							<!-- 미구현 -->
						</div>
					</div>
					<ul class="search_book_list_wrap">
						<c:forEach var="vo" items="${list }">
						<li>
							<div class="search_book_unit">
								<div class="img_canvas">
									<span class="img_item">
										<a href="../book/productdetail.do?no=${vo.id}">
											<img src="${vo.poster }">	
										</a>	
									</span>
								</div>
								<div class="search_book_info">
									<div class="search_book_name sbi">
										<c:choose>
											<c:when test="${vo.mainCategory==1 }">
											<span>[국내도서]</span>
											</c:when>
											<c:when test="${vo.mainCategory==2 }">
											<span>[외국도서]</span>
											</c:when>
											<c:otherwise>
											<span>[e-Book]</span>
											</c:otherwise>
										 </c:choose>
										<a href="../book/productdetail.do?no=${vo.id}" class="search_book_name">${vo.name }</a>
									</div>
									<div class="search_book_pubGrp sbi">
									<c:if test="${vo.author!=null }">
										<span class="authPub info_auth">${vo.author }</span>
									</c:if>
									<c:if test="${vo.publisher!=null }">
										<span class="authPub info_pub">${vo.publisher }</span>
									</c:if>
									<c:if test="${vo.regdate!=null }">	
										<span class="authPub info_date"><fmt:formatDate value="${vo.regdate }" pattern="yyyy년 MM월"/></span>
									</c:if>
									</div>
									<div class="search_book_price sbi">
										<span>정가&nbsp;<strong>${vo.price }</strong>원</span>
										<c:if test="${vo.saleRate!=0 }">
										<span>(10% 할인)</span>
										</c:if>
									</div>
									<div class="search_book_rating sbi">
										<span calss="saleNum">판매지수 ${vo.sellCount }</span>
										<!-- 리뷰 생성 후 재 구현 -->
										<!-- <span class="rating_rvCount"><a>회원리뷰(<em>?</em>건)</a></span> -->
									
										<c:choose>
											<c:when test="${vo.score==5 }">
												<span class="rating_rvCount"><img src="../img/starFive.png"><strong>${vo.score }점</strong></span>
											</c:when>
											<c:when test="${vo.score==4 }">
												<span class="rating_rvCount"><img src="../img/starFour.png"><strong>${vo.score }점</strong></span>
											</c:when>
											<c:when test="${vo.score==3 }">
												<span class="rating_rvCount"><img src="../img/starThree.png"><strong>${vo.score }점</strong></span>
											</c:when>
											<c:when test="${vo.score==2 }">
												<span class="rating_rvCount"><img src="../img/starTwo.png"><strong>${vo.score }점</strong></span>
											</c:when>
											<c:when test="${vo.score==1 }">
												<span class="rating_rvCount"><img src="../img/starOne.png"><strong>${vo.score }점</strong></span>
											</c:when>
											<c:otherwise>
												<span class="rating_rvCount"><img src="../img/starZero.png"><strong>${vo.score }점</strong></span>
											</c:otherwise>
										</c:choose>
									</div>
									<div class="search_book_tag sbi">
									<c:if test="${vo.tag!=null }">
										<c:set var="tagf" value="${vo.tag }"/>
										<c:set var="tagfn" value="${fn:split(tagf,'#')}"/>
										<c:forEach var="tagli" items="${tagfn}">
											<span><a href="#">${tagli }</a></span>
										</c:forEach>
									</c:if>
									</div>
									<div class="search_book_content sbi">
										<p class ="search_bc">
										${vo.description }
										</p>
									</div>
								</div>
								<div class="search_book_check">
									<div class="search_book_state">
										<c:forTokens var="s" delims="|" items="${vo.state }">
											<div>${s }</div>
										</c:forTokens>
									</div>
									<div>
										<input type="checkbox" class="book_list_check" name="bookChk" value="${vo.id }">
										<span class="btn_count">
										<label style="color:#666; font-size:11px;">
											수량
											<input type="text" name="qty" value="1" size="4" id="input_cnt_${vo.id }">
										</label>
											<a book-id="${vo.id }" class="btn_plus plus_${vo.id }">수량 더하기</a>
											<a book-id="${vo.id }" class="btn_down down_${vo.id }">수량 빼기</a>
										</span>
										<div style="margin-top:7px;overflow: hidden;">
											<a href="#">
												<span class="search_cart_input" value="${vo.id}">
													<em class ="search_btn_txt">카트에 넣기</em>
												</span>
											</a>
										</div>
										<c:if test="${vo.state=='판매중' }">
										<div style="margin-top:7px;overflow: hidden;">
												<span class="search_buy_input" value=${vo.id }>
													<em class ="search_btn_txt">바로구매</em>
												</span>
										</div>
										</c:if>
										<div style="margin-top:7px;overflow: hidden;">
											<a href="#">
												<span class="search_list_input">
													<em class ="search_list_txt">찜목록에 넣기</em>
												</span>
											</a>
										</div>
									</div>
								</div>
							</div>	
						</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	</section>
	<script
	  src="https://code.jquery.com/jquery-3.6.0.min.js"
	  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	  crossorigin="anonymous"></script>
	<script type="text/javascript">
		/* 장바구니 모달 창 시작 */
		$('.search_cart_input').click(function(){
			$.ajax({
				url:'http://localhost:8080/FirstProject/cart/addCart',
				type:'POST',
				data:{"bookId": $(this).attr('value')},
				success:function(){
					$('#cart-modal').css('display','block');
					$('#cart-modal').css('overflow','hidden');
					$('#cart-modal').css('position','fixed');
				}
			});
		})
		$('#cart-ok-btn').click(function(){
			$('#cart-modal').css('display','none');
		})
		/* 장바구니 모달 창 끝 */
	</script>
</body>
</html>