<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>장바구니</title>
	<!-- Cart 페이지 StyleSheet -->
	<link rel="stylesheet" href="../css/cart.css">
</head>
<body>
	<c:import url="../main/main.jsp"/>
	<!-- 카트 페이지 시작 -->
	<section>
		<aritcle>
			<div class="cart-process bg-primary">카트</div>
			<div class="checkout-process bg-primary">결제</div>
			<div class="checksuc-process bg-primary">완료</div>
			<hr id="mid-line">
			<div class="container-fluid cart-area">
				<div class="row">
					<div class="col-xs-12 col-md-10 col-md-offset-1">
						<hr>
						<input type="checkbox" value="yyy" name="all-checked" checked>
						<label for="all-checked">전체선택</label>&nbsp;&nbsp;&nbsp;
						<div class="btn-group" role="group" aria-label="...">
						  <button type="button" class="btn btn-default">주문하기</button>
						  <button type="button" class="btn btn-default">찜목록 넣기</button>
						  <button type="button" class="btn btn-default">삭제</button>
						</div>
						<form action="#" id="cart-sort">
						  <select id="cars" name="cars">
						    <option value="volvo">카트넣기순</option>
						    <option value="saab">상품명순</option>
						    <option value="fiat">높은가격순</option>
						    <option value="audi">낮은가격순</option>
						    <option value="audi">출간일순</option>
						  </select>
						</form>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-md-10 col-md-offset-1 cart-table">
						<table class="table">
							<tr id="cart-table-index">
								<th></th>
								<th></th>
								<th>상품정보</th>
								<th id="cart-table-quantity">수량</th>
								<th id="cart-table-info">상품금액</th>
								<th id="cart-table-info">배송정보</th>
								<th id="cart-table-info">주문</th>
							</tr>
							<tr>
								<td>
									<input type="checkbox" name="나무야 놀자" value="yyy" checked>
								</td>
								<td>
									<img src="http://image.yes24.com/goods/107092661/XL" alt="부과 성공을 부르는 12가지 원칙">
								</td>
								<td>[도서] 12 1/2 부와 성공을 부르는 12가지 원칙 : 당신의 인생을 바꿔 줄 35가지 조언</td>
								<td id="cart-table-quantity">1</td>
								<td id="cart-table-info">15,000원</td>
								<td id="cart-table-info">내일</td>
								<td id="cart-table-info">
									<button type="button" class="btn btn-primary">주문하기</button>
								</td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" name="나무야 놀자" value="yyy" checked>
								</td>
								<td>
									<img src="http://image.yes24.com/goods/107473113/XL" alt="어둠이 걷힌 자리엔">
								</td>
								<td>[도서] 어둠이 걷힌 자리엔 </td>
								<td id="cart-table-quantity">1</td>
								<td id="cart-table-info">15,000원</td>
								<td id="cart-table-info">내일</td>
								<td id="cart-table-info">
									<button type="button" class="btn btn-primary">주문하기</button>
								</td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" name="나무야 놀자" value="yyy" checked>
								</td>
								<td>
									<img src="http://image.yes24.com/goods/107471884/XL" alt="요즘 사는 맛">
								</td>
								<td>[도서] 요즘 사는 맛 : 먹고 사는 일에 누구보다 진심인 작가들의 일상 속 음식 이야기 [‘재생지에 콩기름으로 인쇄한 일기장’ 증정(포인트 차감)]</td>
								<td id="cart-table-quantity">1</td>
								<td id="cart-table-info">16,000</td>
								<td id="cart-table-info">내일</td>
								<td id="cart-table-info">
									<button type="button" class="btn btn-primary">주문하기</button>
								</td>
							</tr>
							<tr>
								<td>
									<input type="checkbox" name="나무야 놀자" value="yyy" checked>
								</td>
								<td>
									<img src="http://image.yes24.com/goods/107511614/XL" alt="나를 마릴린 먼로라고 하자">
								</td>
								<td>[도서] 나를 마릴린 먼로라고 하자 [행운카드 증정 (포인트 차감)]</td>
								<td id="cart-table-quantity">1</td>
								<td id="cart-table-info">14,000</td>
								<td id="cart-table-info">내일</td>
								<td id="cart-table-info">
									<button type="button" class="btn btn-primary">주문하기</button>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-md-10 col-md-offset-1 price-table">
						<div class="row">
							<div class="col-xs-3 price-table-header-1">총 상품금액<br><span id="price-table-header-price">35535원</span></div>
							<div class="col-xs-2 price-table-header-2">총 추가금액<br><span id="price-table-header-price">35535원</span></div>
							<div class="col-xs-2 price-table-header-3">총 할인금액<br><span id="price-table-header-price">35535원</span></div>
							<div class="col-xs-5 price-table-header-4"><span class="final-price">최종 결제금액</span><br>
									<span id="price-table-header-price" class="final-price">35535원</span>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-3 price-table-info-1">정가 60000원에서 6000원 즉시 할인</div>
							<div class="col-xs-2 price-table-info-2"></div>
							<div class="col-xs-2 price-table-info-3"></div>
							<div class="col-xs-5 price-table-info-4">
								<div class="row">
									<div class="col-xs-6">기본적립 포인트</div>
									<div class="col-xs-6">3,980원</div>
								</div>
								<div class="row">
									<div class="col-xs-6">추가적립 포인트</div>
									<div class="col-xs-6">0원</div>
								</div>
								<div class="row">
									<div class="col-xs-6">마니아 포인트</div>
									<div class="col-xs-6">0원</div>
								</div>
								<div class="row">
									<div class="col-xs-6"><hr></div>
									<div class="col-xs-6"><hr></div>
								</div>
								<div class="row">
									<div class="col-xs-6">총 예상적립 포인트</div>
									<div class="col-xs-6">3,980원</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-md-10 col-md-offset-1 delivery-table">
						<div class="row">
							<div class="col-xs-3" id="delivery-table-header">배송일 안내</div>
							<div class="col-xs-9" id="delivery-table-info">
								<div class="row">배송지 : 서울 강남구 강남대로36 157-34 5층</div>
								<div class="row">YES24배송 : 내일(2/24, 목) 도착예정</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</aritcle>
		<aritcle>
			<div class="jumbotron" style="background-image: url(../img/cart_background.jpg);">
			  	<!-- Recommend-Swiper -->
			  	<div class="swiper recommendSwiper">
				    <div class="swiper-wrapper">
				      <div class="swiper-slide">Slide 1</div>
				      <div class="swiper-slide">Slide 2</div>
				      <div class="swiper-slide">Slide 3</div>
				      <div class="swiper-slide">Slide 4</div>
				      <div class="swiper-slide">Slide 5</div>
				      <div class="swiper-slide">Slide 6</div>
				      <div class="swiper-slide">Slide 7</div>
				      <div class="swiper-slide">Slide 8</div>
				      <div class="swiper-slide">Slide 9</div>
				      <div class="swiper-slide">Slide 1</div>
				      <div class="swiper-slide">Slide 2</div>
				      <div class="swiper-slide">Slide 3</div>
				      <div class="swiper-slide">Slide 4</div>
				      <div class="swiper-slide">Slide 5</div>
				      <div class="swiper-slide">Slide 6</div>
				      <div class="swiper-slide">Slide 7</div>
				      <div class="swiper-slide">Slide 8</div>
				      <div class="swiper-slide">Slide 9</div>
				      <div class="swiper-slide">Slide 1</div>
				      <div class="swiper-slide">Slide 2</div>
				      <div class="swiper-slide">Slide 3</div>
				      <div class="swiper-slide">Slide 4</div>
				      <div class="swiper-slide">Slide 5</div>
				      <div class="swiper-slide">Slide 6</div>
				      <div class="swiper-slide">Slide 7</div>
				    </div>
				    <div class="swiper-button-next"></div>
				    <div class="swiper-button-prev"></div>
				    <div class="swiper-pagination"></div>
			    </div>
			    <!-- Recent-Swiper -->
			  	<div class="swiper recentSwiper">
				    <div class="swiper-wrapper">
				      <div class="swiper-slide">Slide 1</div>
				      <div class="swiper-slide">Slide 2</div>
				      <div class="swiper-slide">Slide 3</div>
				      <div class="swiper-slide">Slide 4</div>
				      <div class="swiper-slide">Slide 5</div>
				      <div class="swiper-slide">Slide 6</div>
				      <div class="swiper-slide">Slide 7</div>
				      <div class="swiper-slide">Slide 8</div>
				      <div class="swiper-slide">Slide 9</div>
				    </div>
				    <div class="swiper-button-next"></div>
				    <div class="swiper-button-prev"></div>
				    <div class="swiper-pagination"></div>
			    </div>
			</div>
		</aritcle>
	</section>
	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<!-- Compiled and minified JavaScript -->
	<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
	<script src="js/common.js"></script>
	<!-- Initialize Swiper -->
    <script>
      var recommendSwiper = new Swiper(".recommendSwiper", {
      	slidesPerView: 3,
      	slidesPerGroup: 3,
        spaceBetween: 10,
        pagination: {
          el: ".swiper-pagination",
          type: "fraction",
        },
        navigation: {
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
        },
        breakpoints: {
          768: {
            slidesPerView: 4,
            slidesPerGroup: 4,
            spaceBetween: 10,
          },
          992: {
            slidesPerView: 5,
            slidesPerGroup: 5,
            spaceBetween: 10,
          },
          1200: {
            slidesPerView: 6,
            slidesPerGroup: 6,
            spaceBetween: 30,
          },
        },
      });
      var recentSwiper = new Swiper(".recentSwiper", {
        slidesPerView: 3,
      	slidesPerGroup: 3,
        spaceBetween: 10,
        pagination: {
          el: ".swiper-pagination",
          type: "fraction",
        },
        navigation: {
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
        },
        breakpoints: {
          768: {
            slidesPerView: 4,
            slidesPerGroup: 4,
            spaceBetween: 10,
          },
          992: {
            slidesPerView: 5,
            slidesPerGroup: 5,
            spaceBetween: 10,
          },
          1200: {
            slidesPerView: 6,
            slidesPerGroup: 6,
            spaceBetween: 30,
          },
        },
      });
    </script>
</body>
</html>