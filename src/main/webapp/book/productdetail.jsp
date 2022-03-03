<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

img {
	height: 300px;
	margin-right: 30px;
}

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
	line-height: 22.5px width:400px
}

span.value_p {
	font-size: 24px;
}

.li_1 {
	margin-bottom: 30px;
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
	margin-top: 800px;
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
</style>

</head>

<body>
<c:set var="vo" value="${book }"/>

	<!-- header 인클루드해야해 -->
	<!--de file"/WEB-INF/header.jsp"%> -->
	<div class="container_1">
		<h2> ${vo.name}</h2>
		<h4>${vo.author} , ${vo.publisher} ,<!--  {regdate} --></h4>
		<hr style="color: gray">
		<div style="height: 30px;">

			<div class="bookwrap">
				<div class="col" style="float: left">
					<img id="bookCover" class="imgbox" src="../img/m1.jpg"
						style="width: 502; height: 696px">
				</div>


				<div class="bookInfo_list">
					<ul>
						<li class="li_1">
							<div class="item">책 정가</div>
							<div class="value">${vo.price}</div>
						</li>
						<li class="li_1">
							<div class="item">판매가</div>
							<div class="value">
							<!--   판매가 계산 우예하는고????????????????????? -->
								<span class="value_p">${vo.price}</span> 원 ( ${vo.saleRate}% 할인)
							</div>
						</li>
					</ul>
				</div>
				<div class="bookInfo_list">
					<ul>
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
						<li>
							<div class="item">
								<img src="../img/time.PNG" style="width: 50px; height: 50px;">
							</div>
							<div class="value">
								<ul>
									<li><img src="../img/rocket.PNG"
										style="width: 63.5px; height: 18.2px;"></li>
									<li>밤 10시까지 주문하면 내일 아침 7시 <span style="color: #ef3b96;">출근전
											배송</span></li>
								</ul>
							</div>
						</li>
					</ul>
				</div>
				<br>
				<div class="bookInfo_list star">
					<ul>
						<li><img alt="★★★★★" src="star.png"> {5}</li>
						<!-- 평점 -->
						<li><a href="#">100자평(40)</a></li>
						<li><a href="#">리뷰{리뷰수}</a></li>
						<!-- 클릭 시 리뷰창으로  -->
						<li><img src="../img/howabout.PNG"
							style="width: 77.9px; height: 19.5px;"></li>
					</ul>
				</div>
				<br> <br>
				<div class="t">
					<ul>
						<li><a>카드/간편결제 할인 ></a></li>
						<li><a>무이자 할부 ></a></li>
						<li><a>소득공제 ></a></li>
					</ul>
				</div>
				<br> <br>
				<div class="item">수량</div>
				<div class="value">
					<input type="number" name="" value="1" min="1" max="10">
				</div>
				<br> <br>
				<div class="t">
					<ul>
						<li><input type="button" value="장바구니 담기"
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
		</div>

	</div>
	
	<!-- 책 설명8888888888888888888 -->
	<div class="book_content">
	
					${vo.description }
				</div>








	<!-- 배송안내 -->
	<div id="order_delivery_area" class="tabBox">

		<!-- 리뷰 -->
		<div id="review_area">


			<div id="order_reviews_area" class="tabBox"
				style="flex-direction: column;">
				<div class="tabBox"
					style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid black; padding-bottom: 5px;">
					<div>
						<input type="button" value="구매후기"
							style="background-color: #3A4C67; color: white; width: 100px; height: 40px;">
					</div>

				</div>

				<div class="tabBox"
					style="margin-top: 30px; padding-bottom: 5px; border-bottom: 1px solid #DDDDDD;">
					<ul style="list-style: disc; padding: 0;">

						<li style="margin-left: 20px; font-size: 14px;">매주 10건의 우수리뷰를
							선정하여 용용포인트 3만원을 드립니다..</li>
						<li style="margin-left: 20px; font-size: 14px;">3,000원 이상 구매
							후 리뷰 작성 시 일반회원 300원, 마니아회원 600원의 용용포인트를 드립니다.</li>
					</ul>

				</div>

				<textarea cols="140" rows="5" placeholder='내용을 입력하세요.'
					style="overflow-y: scroll; overflow-x: hidden; resize: none;"
					required></textarea>
				<br>
				<div id="button" style="padding-top: 10px;">
					<input type="submit" value="등록"> <input type="reset"
						value="초기화">



				</div>



			</div>










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
</body>
=======
<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
img {
	height: 300px;
	margin-right: 30px;
}
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
	line-height: 22.5px width:400px
}
span.value_p {
	font-size: 24px;
}
.li_1 {
	margin-bottom: 30px;
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
	margin-top: 800px;
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
</style>

</head>

<body>
	<!-- header 인클루드해야해 -->
	<!--de file"/WEB-INF/header.jsp"%> -->
	<div class="container_1">
		<h2> ${vo.name}</h2>
		<h4>${vo.author} , ${vo.publisher} ,<!--  {regdate} --></h4>
		<hr style="color: gray">
		<div style="height: 30px;">

			<div class="bookwrap">
				<div class="col" style="float: left">
					<img id="bookCover" class="imgbox" src="../img/m1.jpg"
						style="width: 502; height: 696px">
				</div>


				<div class="bookInfo_list">
					<ul>
						<li class="li_1">
							<div class="item">책 정가</div>
							<div class="value">${vo.price}</div>
						</li>
						<li class="li_1">
							<div class="item">판매가</div>
							<div class="value">
							<!--   판매가 계산 우예하는고????????????????????? -->
								<span class="value_p">${vo.price}</span> 원 ( ${vo.saleRate}% 할인)
							</div>
						</li>
					</ul>
				</div>
				<div class="bookInfo_list">
					<ul>
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
						<li>
							<div class="item">
								<img src="../img/time.PNG" style="width: 50px; height: 50px;">
							</div>
							<div class="value">
								<ul>
									<li><img src="../img/rocket.PNG"
										style="width: 63.5px; height: 18.2px;"></li>
									<li>밤 10시까지 주문하면 내일 아침 7시 <span style="color: #ef3b96;">출근전
											배송</span></li>
								</ul>
							</div>
						</li>
					</ul>
				</div>
				<br>
				<div class="bookInfo_list star">
					<ul>
						<li><img alt="★★★★★" src="star.png"> {5}</li>
						<!-- 평점 -->
						<li><a href="#">100자평(40)</a></li>
						<li><a href="#">리뷰{리뷰수}</a></li>
						<!-- 클릭 시 리뷰창으로  -->
						<li><img src="../img/howabout.PNG"
							style="width: 77.9px; height: 19.5px;"></li>
					</ul>
				</div>
				<br> <br>
				<div class="t">
					<ul>
						<li><a>카드/간편결제 할인 ></a></li>
						<li><a>무이자 할부 ></a></li>
						<li><a>소득공제 ></a></li>
					</ul>
				</div>
				<br> <br>
				<div class="item">수량</div>
				<div class="value">
					<input type="number" name="" value="1" min="1" max="10">
				</div>
				<br> <br>
				<div class="t">
					<ul>
						<li><input type="button" value="장바구니 담기"
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
		</div>

	</div>








	<!-- 배송안내 -->
	<div id="order_delivery_area" class="tabBox">

		<!-- 리뷰 -->
		<div id="review_area">


			<div id="order_reviews_area" class="tabBox"
				style="flex-direction: column;">
				<div class="tabBox"
					style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid black; padding-bottom: 5px;">
					<div>
						<input type="button" value="구매후기"
							style="background-color: #3A4C67; color: white; width: 100px; height: 40px;">
					</div>

				</div>

				<div class="tabBox"
					style="margin-top: 30px; padding-bottom: 5px; border-bottom: 1px solid #DDDDDD;">
					<ul style="list-style: disc; padding: 0;">

						<li style="margin-left: 20px; font-size: 14px;">매주 10건의 우수리뷰를
							선정하여 용용포인트 3만원을 드립니다..</li>
						<li style="margin-left: 20px; font-size: 14px;">3,000원 이상 구매
							후 리뷰 작성 시 일반회원 300원, 마니아회원 600원의 용용포인트를 드립니다.</li>
					</ul>

				</div>

				<textarea cols="140" rows="5" placeholder='내용을 입력하세요.'
					style="overflow-y: scroll; overflow-x: hidden; resize: none;"
					required></textarea>
				<br>
				<div id="button" style="padding-top: 10px;">
					<input type="submit" value="등록"> <input type="reset"
						value="초기화">



				</div>



			</div>










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
					<td style="vertical-align: middle">마이페이지 > 반품/교환 신청 및 조회, 1:1
						문의, 고객만족센터(1811-9415) <br> <br> 판매자 배송 상품은 판매자와 반품/교환이
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
						부과할수 있음 <br> 단, 아래의 주문/취소 조건인 경우, 취소 수수료 면제  <br> 오늘 00시
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
</body>
</html>