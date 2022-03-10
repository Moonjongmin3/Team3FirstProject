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
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>
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
						<input type="checkbox" id="check-all" checked>
						<label for="all-checked">전체선택</label>&nbsp;&nbsp;&nbsp;
						<div class="btn-group" role="group" aria-label="...">
						  <c:if test="${not empty userId}">
						  	<button type="button" class="btn btn-default checkout-selected">주문하기</button>
						  </c:if>
						  <c:if test="${empty userId}">
						  	<button type="button" class="btn btn-default" onclick="location.href ='../user/login.do'">주문하기</button>
						  </c:if>
						  <c:if test="${not empty userId}">
						  	<button type="button" class="btn btn-default addMyList-selected">찜목록 넣기</button>
						  </c:if>
						  <c:if test="${empty userId}">
						  	<button type="button" class="btn btn-default" onclick="location.href ='../user/login.do'">찜목록 넣기</button>
						  </c:if>
						  <button type="button" class="btn btn-default" id="delete-selected">삭제</button>
						</div>
						<form action="#" id="cart-sort">
						  <select id="cart-sort-select" name="cars">
						    <option id="cart-sort-option" value="default">카트넣기순</option>
						    <option id="cart-sort-option" value="name">상품명순</option>
						    <option id="cart-sort-option" value="priceD">높은가격순</option>
						    <option id="cart-sort-option" value="priceA">낮은가격순</option>
						  </select>
						</form>
					</div>
				</div>
				<c:if test="${empty userId and empty cart}">
					<div class="row">
						<div class="col-xs-12 col-md-10 col-md-offset-1" id="empty-cart-area">
							<img id="empty-cart-img" alt="empty_cart" src="../img/empty_cart.png"><br>
							<span id="empty-warning">장바구니가 비었습니다..</span>
						</div>
					</div>
				</c:if>
				<c:if test="${not empty userId or not empty cart}">
				<div class="row">
					<div class="col-xs-12 col-md-10 col-md-offset-1 cart-table">
						<table class="table">
							<thead>
								<tr id="cart-table-index">
									<th></th>
									<th></th>
									<th>상품정보</th>
									<th id="cart-table-quantity">수량</th>
									<th id="cart-table-info">상품금액</th>
									<th id="cart-table-info">배송정보</th>
									<th id="cart-table-info">주문</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-md-10 col-md-offset-1 price-table">
						<div class="row">
							<div class="col-xs-3 price-table-header-1">총 상품금액<br><span id="price-table-header-price"></span></div>
							<div class="col-xs-2 price-table-header-2">총 추가금액<br><span id="price-table-header-price"></span></div>
							<div class="col-xs-2 price-table-header-3">총 할인금액<br>
								<span id="price-table-header-price">0원</span>								
							</div>
							<div class="col-xs-5 price-table-header-4"><span class="final-price">최종 결제금액</span><br>
									<span id="price-table-header-price" class="final-price"></span>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-3 price-table-info-1">
								정가 <span id="full-price"></span>원에서 <span id="sale-price" class="text-danger"><strong></strong></span>원 즉시 할인
							</div>
							<div class="col-xs-2 price-table-info-2"></div>
							<div class="col-xs-2 price-table-info-3"></div>
							<div class="col-xs-5 price-table-info-4">
								<div class="row">
									<div class="col-xs-6">기본적립 포인트</div>
									<div id="std-point" class="col-xs-6"></div>
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
									<div id="tot-point" class="col-xs-6 text-danger"><strong></strong></div>
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
								<div class="row">배송지 : 
									<c:if test="${not empty userId}">${fullAddress}</c:if>
									<c:if test="${empty userId}">로그인이 필요합니다.</c:if>
								</div>
								<div class="row">YES24배송 : <strong>내일(${deliveryDate})</strong> 도착예정</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-md-10 col-md-offset-1 btn-lg-area">
						<c:if test="${not empty userId}">					
							<button type="button" class="btn btn-primary btn-lg checkout-selected" id="user-btn">주문하기</button>
						</c:if>
						<c:if test="${empty userId}">
							<button type="button" class="btn btn-primary btn-lg" id="user-btn" onclick="location.href ='../user/login.do'">회원 주문</button>
						</c:if>
					</div>
				</div>
				</c:if>
			</div>
		</aritcle>
		<aritcle>
			<div class="jumbotron" style="background-image: url(../img/cart_background.jpg);">
			  	<!-- Recommend-Swiper -->
			  	<h3 id="recommend-title">"장바구니 내 상품"<span id="recommend-subtitle">과 연관된</span>
			  	<span id="recommend-emphtitle">추천 </span><span class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span></h3>
			  	<div class="swiper recommendSwiper">
				    <div class="swiper-wrapper">
				    	<c:if test="${empty userId}">
				    		<span id="sorry-for-recommend">죄송합니다.. 회원에게 만 제공되는 정보입니다</span>
				    	</c:if>
				    	<c:if test="${not empty userId}">
					      	<c:forEach items="${recommendedBooks}" var="recommendedBook">
					    		<div class="swiper-slide" id="swiper-slide">
					    			<a href="../book/productdetail.do?no=${recommendedBook.id}">
										<img src="${recommendedBook.poster}" alt="${recommendedBook.name}">
									</a>
					      		</div>
					    	</c:forEach>
				    	</c:if>
				    </div>
				    <div class="swiper-button-next" id="swiper-button"></div>
				    <div class="swiper-button-prev" id="swiper-button"></div>
				    <div class="swiper-pagination"></div>
			    </div>
			    <!-- Recent-Swiper -->
			    <h3 id="history-title">최근 본 상품 
			    <span class="glyphicon glyphicon-time" id="timeicon" aria-hidden="true"></span></h3>
			  	<div class="swiper recentSwiper">
				    <div class="swiper-wrapper">
				    	<c:forEach items="${historyBooks}" var="historyBook">
				    		<div class="swiper-slide" id="swiper-slide">
				    			<a href="../book/productdetail.do?no=${historyBook.id}">
									<img src="${historyBook.poster}" alt="${historyBook.name}">
								</a>
				      		</div>
				    	</c:forEach>
				    </div>
				    <div class="swiper-button-next" id="swiper-button"></div>
				    <div class="swiper-button-prev" id="swiper-button"></div>
				    <div class="swiper-pagination"></div>
			    </div>
			</div>
		</aritcle>
	</section>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
  		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  		crossorigin="anonymous"></script>
	<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<!-- Compiled and minified JavaScript -->
	<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
	<script type="text/javascript">
	// 상품 테이블 채워넣기 함수
    function fillCartTable(data){
  	  let book_data = '';
  	  let fullPrice = 0;
	    	$.each(data, function(key, value) {
	    		book_data += '<tr>';
	    		book_data += '<td><input type="checkbox" class="book-check" value="' + value.id + '" checked></td>';
	    		book_data += '<td><img id="img-' + value.id + '" src="' + value.poster + '" alt="' + value.name + '"></td>';
	    		book_data += '<td><span id="name-' + value.id + '">[' + value.mainCategory + '] ' + value.name + '</span><br><h5><span class="text-muted" id="price-' + value.id + '"><del>' + value.price + '원</del>';
	    		book_data += '</span> ' + value.price * 0.9 + '원 (10% 할인)</h5></td>';
	    		book_data += '<td style="text-align:center">';
	    		book_data += '<input type="number" id="quantity-' + value.id + '" min="1" max="100" value="' + value.quantity +'" style="text-align:center">';
	    		book_data += '<br><button type="button" class="quantity" name="bookId" value="' + value.id +'" style="width:70px">변경</button></td>';
	    		book_data += '<td id="cart-table-info"><strong>' + value.price * 0.9 + '원</strong></td>';
	    		book_data += '<td id="cart-table-info"><strong>내일</strong><br>(${deliveryDate})</td>';
	    		book_data += '<td id="cart-table-info"><c:if test="${not empty userId}"><button type="button" class="btn btn-primary" id="checkout-btn" value="' + value.id + '" style="width:85px">주문하기</button></c:if>';
	    		book_data += '<c:if test="${empty userId}"><button type="button" class="btn btn-primary" onclick="location.href =\'../user/login.do\'" value="' + value.id + '" style="width:85px">주문하기</button></c:if>';
	    		book_data += '<c:if test="${not empty userId}"><button type="button" class="btn btn-info" id="addMyList-btn" value="' + value.id + '" style="width:85px">찜하기</button></c:if>';
	    		book_data += '<c:if test="${empty userId}"><button type="button" class="btn btn-info" style="width:85px" onclick="location.href =\'../user/login.do\'">찜하기</button></c:if>';
	    		book_data += '<button type="button" class="btn btn-default" id="del-button" value="' + value.id + '" style="width:85px">삭제하기</button></td>';
	    		book_data += '</tr>';
	    		
	    		fullPrice += parseInt(value.price*value.quantity);
	    	});
	    	fillPriceTable(fullPrice);
	    	
	    	return book_data;
    }
	</script>
	<script src="../js/cart.js"></script>
</body>
</html>