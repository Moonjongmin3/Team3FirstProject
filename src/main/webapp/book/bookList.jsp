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
<script type="text/javascript">
/* function checkAll(){
    if( $(".check_all_btn").click ){
      $("#book_list_check").prop("checked", true);
    }else{
      $("#book_list_check").prop("checked", false);
    }
} */

</script>
</head>
<body>
	<section class="search-result">
		<div class="search-result-wrap">
			<!-- 검색내 결과 시작-->
			<div class="search-result-option" id="scroll">
				<div class="left_conts">
				<!-- 미구현 -->
					<div style="margin-bottom: 7px;">
						<span style="color: #5d5d5d; font-size: 13px;">
							<b>결과내 검색</b>
						</span>
					</div>
					<div style="margin-bottom: 7px;">
						<input type="text" name="research" style="border: 1px solid #dedede;">
					</div>
					<div style="float: left; ">
						<input type="checkbox" id="except_search">
						<label for="except_search" class="bo2">
						검색어 제외	
						</label> 
					</div>
					<div style="float: right; padding-top: 3px;">
						<input type="submit" class="btn btn-sm" value="적용">
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
					<form method="post" action="../book/bookList.do">
					<div>
						<ul style="list-style: none; padding-left: 0; margin-bottom: 0px;">
							<li>
								<input type="checkbox" id="search_field_KeyTitle" checked="checked" name="title_ck" value="title">
								<label for="search_field_KeyTitle" class="bo2">
									제목
								</label>
							</li>
							<li>
								<input type="checkbox" id="search_field_KeyAuthor" checked="checked" name="author_ck" value="author">	
								<label for="search_field_KeyTitle" class="bo2">
									저자
								</label>
							</li>
							<li>
								<input type="checkbox" id="search_field_KeyPublisher" checked="checked" name="publisher_ck" value="publisher">
								<label for="search_field_KeyTitle" class="bo2">
									출판사
								</label>
							</li>
							<li>
								<input type="checkbox" id="search_field_KeyTag">
								<label for="search_field_KeyTitle" class="bo2">
									태그
								</label>
							</li>
							<!-- 미구현 -->
						</ul>
						
					</div>
					<div style="float: right;">
						<input type="submit" class="btn btn-sm" value="적용">
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
						<!-- 전체선택 javascript ex)알라딘 -->
					</div>
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
										<input type="checkbox" value="${vo.subCateName }" id="serarch_category_1_1" name="search_left_categoty">
										<label for="serarch_category_1_1" class="bo2" style="cursor: pointer;" title="${vo.mainCateName }">
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
										<input type="checkbox" value="${vo.subCateName }" id="serarch_category_2_1" name="search_left_categoty">
										<label for="serarch_category_2_1" class="bo2" style="cursor: pointer;" title="${vo.mainCateName }">
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
										<input type="checkbox" value="${vo.subCateName }" id="serarch_category_3_1" name="search_left_categoty">
										<label for="serarch_category_3_1" class="bo2" style="cursor: pointer;" title="${vo.mainCateName }">
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
						<input type="submit" class="btn btn-sm" value="적용">
					</div>
				</div>
			</div>
			<!-- 메인 출력 시작 -->
			<div class="search-result-content">
				<div class="search-content-top">
					<span class="search_t_g">
						검색어"<span class="result_l"><strong>${keyword }</strong></span>
						"총
						<span class="search_r_c_count">${mainCountArr[0] }</span>
						개의 상품이 검색되었습니다.
					</span>
					<table class="search-result-count">
						<tbody>
							<tr>
								<td width="18" height="47"><img src="../img/ss_m_l.jpeg"></td>
								<td valign="bottom" style="width:400px; background:url(../img/ss_m_c.jpeg) top left repeat-x; padding-top:0px; text-align: left;">
									<ul>
										<li>
											<a href="#">
												<img src="../img/ss_m_1.png">
												<br>
												<span class="search_t_w_n">(${mainCountArr[0]})</span>
											</a>
										</li>
										<li style="width: 2px;">
											<img src="../img/ss_m_line.png">
										</li>
										<!-- 미구현 -->
										<li><a href="#">
											<img src="../img/ss_m_2.png">
											<br>
											<span class="search_t_w_n">(${mainCountArr[1]})</span>
										</a>
										</li>
										<li style="width: 2px;">
											<img src="../img/ss_m_line.png">
										</li>
										<li>
											<a href="#">
												<img src="../img/ss_m_3.png">
												<br>
												<span class="search_t_w_n">(${mainCountArr[2]})</span>
											</a>
										</li>
										<li style="width: 2px;">
											<img src="../img/ss_m_line.png">
										</li>
										<li>
											<a href="#">
												<img src="../img/ss_m_15.png">
												<br>
												<span class="search_t_w_n">(${mainCountArr[3]})</span>
											</a>
										</li>
										<!-- 미구현 -->
									</ul>
								</td>
								<td width="18" height="47"><img src="../img/ss_m_r.jpeg"></td>
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
										<li>
											<a href="#">인기순</a>
										</li>
										<li>
											<a href="#">판매량순</a>
										</li>
										<li>
											<a href="#">출시일순</a>
										</li>
										<li>
											<a href="#">리뷰순</a>
										</li>
										<li>
											<a href="#">저가격순</a>
										</li>
									</ul>
								</td>
								<td>
								<!-- 미구현 -->
									<a href="#" onclick="checkAll()" class="check_all_btn">
										<span class="bWrap">
											전체선택
										</span>
									</a>
								</td>
								<td style="text-align: center">
									<select>
										<option value selected>품절포함</option>
										<option value="Y">품절제외</option>
									</select>
								</td>
								<td style="text-align: center">
									<select>
										<option value="10" selected>10개씩 보기</option>
										<option value="20">20개씩 보기</option>
										<option value="40">40개씩 보기</option>
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
						<a href="../book/bookList.do?page=1&keyword=${keyword}&searchCategory=${category}" class="btn_prev">
							<img src="../img/btn_prev05_on.gif" alt="첫 페이지">
						</a>
						<a href="../book/bookList.do?page=${curpage-5}&keyword=${keyword}&searchCategory=${category}" class="btn_prev">
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
                        	<li ${style }><a href="../book/bookList.do?page=${i }&keyword=${keyword}&searchCategory=${category}">${i }</a></li>
							</c:forEach>
						</ul>
							<c:if test="${endPage<totalPage }">
							<a href="../book/bookList.do?page=${endPage+1}&keyword=${keyword}&searchCategory=${category}" class="btn_prev">
								<img src="../img/btn_next03_on.gif" alt="다음 블록 첫페이지">
							</a>
							<a href="../book/bookList.do?page=${totalPage}&keyword=${keyword}&searchCategory=${category}" class="btn_prev">
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
					<ul id="search_book_list_wrap">
						<c:forEach var="vo" items="${list }">
						<li>
							<div class="search_book_unit">
								<div class="img_canvas">
									<span class="img_item">
										<a href="#">
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
										<a href="#" class="search_book_name">${vo.name }</a>
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
										<span><strong>${vo.price }</strong>원</span>
										<c:if test="${vo.saleRate!=0 }">
										<span>(${vo.saleRate }% 할인)</span>
										</c:if>
									</div>
									<div class="search_book_rating sbi">
										<span calss="saleNum">판매지수 ${vo.sellCount }</span>
										<!-- 리뷰 생성 후 재 구현 -->
										<span class="rating_rvCount"><a>회원리뷰(<em>?</em>건)</a></span>
									
										<c:choose>
											<c:when test="${vo.score==5 }">
												<span><img src="../img/starFive.png"><strong>${vo.score }점</strong></span>
											</c:when>
											<c:when test="${vo.score==4 }">
												<span><img src="../img/starFour.png"><strong>${vo.score }점</strong></span>
											</c:when>
											<c:when test="${vo.score==3 }">
												<span><img src="../img/starThree.png"><strong>${vo.score }점</strong></span>
											</c:when>
											<c:when test="${vo.score==2 }">
												<span><img src="../img/starTwo.png"><strong>${vo.score }점</strong></span>
											</c:when>
											<c:when test="${vo.score==1 }">
												<span><img src="../img/starOne.png"><strong>${vo.score }점</strong></span>
											</c:when>
											<c:otherwise>
												<span><img src="../img/starZero.png"><strong>${vo.score }점</strong></span>
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
								<!-- 체크박스/장바구니 넣기/ 구매버튼 만들어야함 -->
								<div class="search_book_check">
									<div>
										<input type="checkbox" id="book_list_check">
										<span class="btn_count">
										<label style="color:#666; font-size:11px;">
											수량
											<input type="text" name="qty" value="1" size="4" class="input_cnt">
										</label>
											<a href="#" class="btn_plus">수량 더하기</a>
											<a href="#" class="btn_down">수량 더하기</a>
										</span>
										<div style="margin-top:7px;overflow: hidden;">
											<a href="#">
												<span class="search_cart_input" value="${vo.id}">
													<em class ="search_btn_txt">카트에 넣기</em>
												</span>
											</a>
										</div>
										<div style="margin-top:7px;overflow: hidden;">
											<a href="#">
												<span class="search_buy_input">
													<em class ="search_btn_txt">바로구매</em>
												</span>
											</a>
										</div>
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
		$('.search_cart_input').click(function(){
			$.ajax({
				url:'http://localhost:8080/FirstProject/cart/addCart',
				type:'POST',
				data:{"bookId": $(this).attr('value')},
				success:function(){
					alert('장바구니에 넣었습니다.');
				}
			});
		})
	</script>
</body>
</html>