<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<title> 상세페이지 </title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
ul {
	list-style: none;

}
.container_1 {
	width: 1060px;
	margin: 0 auto;
	margin-top: 50px;
	overflow: hidden;
}

.row {
	margin: 0px auto;
	width: 100%
}

h1 {
	text-align: center;
}

#bookCover .imgbox {
	border-top-style: solid;
	border-top-width: 1px;
	border-right-style: solid;
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-left-style: solid;
	border-left-width: 1px;
	border-image-outset: 0;
	border-image-source: none;
	border-image-width: 1;
}

/* img {
	height: 300px;
	margin-right: 30px;
} */

.bookwrap {
	dispaly: flex;
}

.bookwrap>div {
	flex: 1;
}

div .bookInfo_list {
	
}

.item {
	font-size: 15px;
	width: 100px;
	line-height: 22.5px font-weight: bold;
	float: left;
	padding-bottom: 3px;
}

.value {
	padding-bottom: 3px;
	font-size: 15px;
	line-height: 22.5px width:400px;
	
}

span.value_p {
	font-size: 24px;
}

.li_1 {
	margin-bottom: 30px;
}
.li_1 a{
	text-decoration: none;
	color:black;
}

.star>ul>li {
	display: inline;
	margin-right: 10px;
	
}

.t>ul>li {
	display: inline;
	margin-right: 30px;

}

.btn>ul>li {
	display: inline;
	margin-right: 2px;
}

/* 배송안내 css */
#order_delivery_area {
	width: 1060px;
	/* border: 1px solid black; */
	margin: 0 auto;
	margin-top:30px;
}

#order_delivery_area h2 {
	font-size: 20px;
	padding: 10px 5px;
	border-bottom: 1px solid #000;
}

#order_delivery_area table th, #order_delivery_area table td {
	font-size: 14px;
	font-weight: normal;
	border-bottom: 1px solid #e6e6e6;
}

#order_delivery_area table th {
	width: 210px;
	background: #f8f8f8;
	padding: 24px;
	vertical-align: top;
	word-break: keep-all;
}

#order_delivery_area table td {
	padding: 20px 24px 20px 40px;
	line-height: 24px;
	word-break: keep-all;
}

#order_delivery_area h2.bottom_t {
	padding-top: 54px;
}

#order_delivery_area table.bottom td {
	font-size: 14px;
}
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
<c:set var="vo" value="${book }"/>
	<div class="container_1">
		<h2 style="margin-left:31px"> ${vo.name}</h2>
		<h4 style="margin-left:31px">${vo.author} , ${vo.publisher} , <fmt:formatDate value="${vo.regdate }" pattern="yyyy년 MM월"/></h4>
		<hr style="color: gray">
			<div class="bookwrap">
				<div class="col-sm-6" style="float: left">
					<img id="bookCover" class="imgbox" src="${vo.poster }"
						style="width: 450px; height: 630px;margin-left:20px">
				</div>
				<div class="bookInfo_list col-sm-6">
					<ul>
						<li class="li_1">
							<div class="item">책 정가</div>
							<div class="value">${vo.price}</div>
						</li>
						<li class="li_1">
							<div class="item">판매가</div>
							<div class="value">
								<fmt:parseNumber var="saleprice" integerOnly="true" value="${vo.price-(vo.price*(vo.saleRate*0.01))}"/>
								<span class="value_p"> ${saleprice}원 </span>(${vo.saleRate}% 할인)
							</div>
						</li>
						<li class="li_1">
							<div class="item">마일리지</div>
							<div class="value">
								<ul>
									<li><!-- {750원} -->(5% 적립)</li>
									<li>+ 5만원이상 구매시 2000원 적립</li>
								</ul>
							</div>
						</li>
						<li class="li_1">
							<div class="item">배송료</div>
							<div class="value">
								3,000원 (15,000원이상 무료배송>
							</div>
						</li>
						<li class="li_1">
							<div class="item">
								<img src="../img/time.png" style="width: 50px; height: 50px;">
							</div>
							<div class="value">
								<ul>
									<li>
										<img src="../img/rocket.png"
											style="width: 63.5px; height: 18.2px;">
									</li>
									<li>밤 10시까지 주문하면 내일 아침 7시 <span style="color: #ef3b96;">출근전
											배송</span></li>
								</ul>
							</div>
						</li>
						<li class="li_1">
							<c:choose>
									<c:when test="${vo.score==5 }">
										<span><img src="../img/starFive.png"><strong>&nbsp;${vo.score }점</strong></span>
									</c:when>
									<c:when test="${vo.score==4 }">
										<span><img src="../img/starFour.png"><strong>&nbsp;${vo.score }점</strong></span>
									</c:when>
									<c:when test="${vo.score==3 }">
										<span><img src="../img/starThree.png"><strong>&nbsp;${vo.score }점</strong></span>
									</c:when>
									<c:when test="${vo.score==2 }">
										<span><img src="../img/starTwo.png"><strong>&nbsp;${vo.score }점</strong></span>
									</c:when>
									<c:when test="${vo.score==1 }">
										<span><img src="../img/starOne.png"><strong>&nbsp;${vo.score }점</strong></span>
									</c:when>
									<c:otherwise>
										<span><img src="../img/starZero.png"><strong>&nbsp;${vo.score }점</strong></span>
									</c:otherwise>
							</c:choose>
							<span style="margin-left: 15px">
								<a href="#">100자평(40)</a>
							</span>
							<span style="margin-left: 15px">
								<a href="#">리뷰{리뷰수}</a>
							</span>
						</li>
						<li>
							<img src="../img/howabout.png" style="width: 77.9px; height: 19.5px;">
						</li>
						<li class="li_1">
							<span>
								<a href="#">카드/간편결제 할인</a>
							</span>
							<span style="margin-left: 15px">
								<a href="#">무이자 할부</a>
							</span>
							<span style="margin-left: 15px">
								<a href="#">소득공제</a>
							</span>
						</li>
						<li class="li_1">
						수량&nbsp;&nbsp;&nbsp;<input type="number" name="" value="1" min="1" size=3 style="width: 40px">
						</li>
					</ul>
				</div>
				<div class="t">
					<ul>
						<li><input type="button" class="search_cart_input" value="장바구니 담기"
							style="background-color: #ef3b96; color: white; width: 130px; height: 50px; border: none;"></li>
						<li><input type="button" value="바로구매"
							style="background-color: #ef3b96; color: white; width: 130px; height: 50px; border: none;"></li>
						<li><input type="button" value="선물하기"
							style="color: #ef3b96; background-color: white; height: 55px; border-color: #ef3b96; font: bold;"></li>
						<li><input type="button" value="보관함 +"
							style="color: #ef3b96; background-color: white; height: 55px; border-color: #ef3b96; font: bold;"></li>
					</ul>
				</div>
				<br> <br>
				<div class="t">
					<ul>
						<li><a>전자책 출간알림 신청 ></a></li>
						<li><a>중고 등록알림 신청 ></a></li>
						<li><a>중고로 팔기 ></a></li>

					</ul>
				</div>
			</div>
		<!-- 책 설명 -->
		<div class="book_content">
			<pre class="book_description" style="white-space: pre-wrap;">${vo.description }</pre>
		</div>
		<!-- 배송안내 -->
		<div id="order_delivery_area" class="tabBox">
			<!-- 리뷰 -->
			<div id="review_area">
				
				<table style="width: 100%;">
					<tr>
						<th style="width: 20%; vertical-align: middle">배송 구분</th>
						<td style="vertical-align: middle;">CJ대한통운(1588-1255),
							롯데택배(1588-2121), 로젠택배(1588-9988)</td>
					</tr>
					<tr>
						<th style="vertical-align: middle;">배송 지역</th>
						<td style="vertical-align: middle;">전국</td>
					</tr>
					<tr>
						<th style="vertical-align: middle;">배송 비용 및 기간</th>
						<td style="vertical-align: middle;">3,000원 (15,000원이상 무료배송)<br>
							제주도 및 도서산간 지역 추가 운임 : 4,000원<br> 결제(입금)일로부터 1~2일 후 (주말/공휴일
							제외)
						</td>
					</tr>
					<tr>
						<th style="vertical-align: middle;">포장 안내</th>
						<td style="vertical-align: middle;">안전하고 정확한 포장을 위해 CCTV를 설치하여
							운영하고 있습니다.<br> 고객님께 배송되는 모든 상품을 CCTV로 녹화하고 있으며, 철저한 모니터링을 통해
							작업 과정에 문제가 없도록<br>최선을 다 하겠습니다.<br> <br> 목적 : 안전한 포장
							관리<br> 촬영범위 : 박스 포장 작업<br>
						</td>
					</tr>
					<tr>
						<th style="vertical-align: middle;">주말 출고</th>
						<td style="vertical-align: middle;">목요일 배송 마감 시간 이후 주문은 금요일
							출고되어 토요일에 배송됩니다.<br> 토요일 수령이 어려우신 고객님께서는 배송 메시지에 “월요일출고” 라고
							적어주시면 월요일에 출고되어 화요일에 받아보실 수 있습니다. (공휴일인 경우 다음 영업일 출고)<br>
						</td>
					</tr>
				</table>
	
				<table class="bottom" style="width: 100%;">
	
					<tr>
						<th style="" width: 20%; vertical-align:middle">반품/교환 방법</th>
						<td style="vertical-align: middle">마이페이지 > 반품/교환 신청 및 조회, 1:1
							문의, 고객만족센터(1811-9415) <br> <br> 판매자 배송 상품은 판매자와 반품/교환이
							협의된 상품에 한해 가능합니다. <br>
						</td>
					</tr>
					<tr>
						<th style="vertical-align: middle">반품/교환 가능기간</th>
						<td style="vertical-align: middle">출고 완료 후 10일 이내의 주문 상품<br>
							디지털 콘텐츠인 eBook의 경우 구매 후 7일 이내의 상품우<br> 배송사의 귀책 사유에 따른 배송 지연
							발생 및 제품이 변질 된 경우<br></td>
					</tr>
					<tr>
						<th style="vertical-align: middle">반품/교환 비용</th>
						<td style="vertical-align: middle">고객의 단순변심 및 착오구매일 경우 상품
							반송비용은 고객 부담<br> 직수입양서/직수입일서중 일부는 변심 또는 착오로 취소시 해외주문취소수수료 20%를
							부과할수 있음 <br> 단, 아래의 주문/취소 조건인 경우, 취소 수수료 면제  <br> 오늘 00시
							~ 06시 30분 주문을 오늘 오전 06시 30분 이전에 취소 <br> 오늘 06시 30분 이후 주문을 익일
							오전 06시 30분 이전에 취소 <br> 박스포장은 택배 배송이 가능한 규격과 무게를 준수하며, 고객의
							단순변심 및 착오구매일 경우 상품의 반송비용은 박스 당 부과됩니다.<br>
						</td>
					</tr>
					<tr>
						<th style="vertical-align: middle">반품/교환 불가사유</th>
						<td style="vertical-align: middle">소비자의 책임 있는 사유로 상품 등이 손실 또는
							훼손된 경우<br> 소비자의 사용, 포장 개봉에 의해 상품 등의 가치가 현저히 감소한 경우 : 예) 화장품,
							식품, 가전제품, 전자책 단말기 등<br> 복제가 가능한 상품 등의 포장을 훼손한 경우 : 예)
							CD/LP,DVD/Blu-ray,소프트웨어, 만화책, 잡지, 영상 화보집 소비자의 요청에 따라 개별적으로 주문 제작되는
							상품의 경우<br> 디지털 컨텐츠인 eBook, 오디오북 등을 1회 이상 다운로드를 받았을 경우 <br>
							eBook 대여 상품은 대여 기간이 종료 되거나, 2회 이상 대여 했을 경우 취소 불가<br>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<script
	  src="https://code.jquery.com/jquery-3.6.0.min.js"
	  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	  crossorigin="anonymous"></script>
	<script type="text/javascript">
		/* 장바구니 모달 창 시작 */
		$('.search_cart_input').click(function(){
			let bookId = window.location.search.replace('?no=','');
			$.ajax({
				url:'http://localhost:8080/FirstProject/cart/addCart',
				type:'POST',
				data:{"bookId": bookId},
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