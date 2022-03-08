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
						  <button type="button" class="btn btn-default checkout-selected">주문하기</button>
						  <button type="button" class="btn btn-default">찜목록 넣기</button>
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
							<div class="col-xs-2 price-table-header-3">총 할인금액<br><span id="price-table-header-price">0원</span></div>
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
								<div class="row">배송지 : <c:if test="${not empty userId}">${fullAddress}</c:if></div>
								<div class="row">YES24배송 : <strong>내일(${deliveryDate})</strong> 도착예정</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-12 col-md-10 col-md-offset-1 btn-lg-area">
						<c:if test="${not empty userId}">					
							<button type="button" class="btn btn-primary btn-lg" id="user-btn">주문하기</button>
						</c:if>
						<c:if test="${empty userId}">
							<button type="button" class="btn btn-primary btn-lg" id="user-btn" onclick="location.href ='../user/login.do'">회원 주문</button>			
							<button type="button" class="btn btn-default btn-lg checkout-selected" id="guest-btn">비회원 주문</button>
						</c:if>
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
			    <h3 id="history-title">최근 본 상품 
			    <span class="glyphicon glyphicon-time" id="timeicon" aria-hidden="true"></span></h3>
			  	<div class="swiper recentSwiper">
				    <div class="swiper-wrapper">
				    	<c:forEach items="${historyBooks}" var="historyBook">
				    		<div class="swiper-slide" id="history-slide">
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
	<script src="js/common.js"></script>
	<!-- Initialize Swiper -->
    <script>
      var recommendSwiper = new Swiper(".recommendSwiper", {
      	slidesPerView: 3,
      	slidesPerGroup: 3,
        spaceBetween: 5,
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
      
      
      // 카트 가져오기
      $.ajax({
    	    type : 'GET',
    	    url : 'http://localhost:8080/FirstProject/cart/get',
    	    dataType:'json',
    	    success:function(data){
    	    	$('div.cart-table tbody').append(fillCartTable(data));
    	    }
    	})
      // 카트 정렬하기
      $('#cart-sort-select').on('change',function(){
    	  let sortOpt = $(this).val();
    	  $.ajax({
      	    type : 'GET',
      	    url : 'http://localhost:8080/FirstProject/cart/get',
      	    dataType:'json',
      	    success:function(json){
      	    	$('div.cart-table tbody').html('');
      	    	var data;
      	    	if (sortOpt === 'name') {
      	    		data = json.sort((a,b)=>a[sortOpt] < b[sortOpt] ? -1 : a[sortOpt] == b[sortOpt] ? 0 : 1);
      	    	} else if (sortOpt === 'priceD') {
      	    		data = json.sort((a,b)=>b['price'] - a['price']);
      	    	} else if (sortOpt === 'priceA') {
      	    		data = json.sort((a,b)=>a['price'] - b['price']);
      	    	} else {
      	    		data = json;
      	    	}
      	    	$('div.cart-table tbody').append(fillCartTable(data));
      	    }
      	});
    	  
      })
      // 주문하기 - 개별 상품
       $(document).on('click', '#checkout-btn', function(){
    	    let books = [];
    	    let book = {};
    	    book['id'] = $(this).val();
  		    book['quantity'] = $('#quantity-' + $(this).val()).val();
  		    books.push(book);
  		    
      		let url = "../pay/order.do";
    		
      		postToUrl(books, url)
      });
   	  // 주문하기 - 선택 상품
      $('.checkout-selected').click(function(){
    	  let books = [];
    	  let url = "../pay/order.do";
    	  
    	  $.each($("input.book-check:checked"), function(){
    		  let book = {};
    		  book['id'] = $(this).val();
    		  book['quantity'] = $('#quantity-' + $(this).val()).val();
    		  books.push(book);
      	  });
    	  
    	  postToUrl(books, url)
    	  
      })
      // 카트 삭제 - 개별 상품
      $(document).on('click', '#del-button', function(){
    	  $.ajax({
      	    type : 'POST',
      	    url : 'http://localhost:8080/FirstProject/cart/delete',
      	    dataType:'json',
      	    data: { bookId : $(this).val() },
      	    success:function(data){
      	    	$('div.cart-table tbody').html('');
      	    	$('div.cart-table tbody').append(fillCartTable(data));
      	    }
      	})
      });
      // 카트 삭제 - 선택 상품
      $('#delete-selected').click(function(){
    	  let arr = [];
    	  $.each($("input.book-check:checked"), function(){            
              arr.push($(this).val());
      	});
    	  var data = $.param({ bookId : arr }, true);
    	  console.log(arr);
    	  $.ajax({
        	    type : 'POST',
        	    url : 'http://localhost:8080/FirstProject/cart/delete',
        	    dataType:'json',
        	    data: data,
        	    success:function(data){
        	    	$('div.cart-table tbody').html('');
        	    	$('div.cart-table tbody').append(fillCartTable(data));
        	    }
        	})
      })
      
      // 카트 변경 - 상품 수량
      $(document).on('click', 'button.quantity', function(){
    	  let bookId = $(this).val();
    	  let quantity = $('#quantity-'+ bookId).val();
    	  $.ajax({
      	    type : 'POST',
      	    url : 'http://localhost:8080/FirstProject/cart/update',
      	    dataType:'json',
      	    data: {
      	    	bookId: bookId,
      	    	quantity: quantity
      	    },
      	    success:function(data){
      	    	$('div.cart-table tbody').html('');
      	    	$('div.cart-table tbody').append(fillCartTable(data));
      	    }
      	})
      });
      
      // 체크박스 전체 선택&해제
      $('input#check-all').click(function(){
    	 $("input[type='checkbox']").prop('checked',this.checked)
      })
      
      // 상품 테이블 채워넣기 함수
      function fillCartTable(data){
    	  var book_data = '';
    	  let fullPrice = 0;
	    	$.each(data, function(key, value) {
	    		book_data += '<tr>';
	    		book_data += '<td><input type="checkbox" class="book-check" value="' + value.id + '" checked></td>';
	    		book_data += '<td><img src="' + value.poster + '" alt="' + value.name + '"></td>';
	    		book_data += '<td>[' + value.mainCategory + '] ' + value.name + '<br><h5><span class="text-muted"><del>' + value.price + '원</del>';
	    		book_data += '</span> ' + value.price * 0.9 + '원 (10% 할인)</h5></td>';
	    		book_data += '<td style="text-align:center">';
	    		book_data += '<input type="number" id="quantity-' + value.id + '" min="1" max="100" value="' + value.quantity +'" style="text-align:center">';
	    		book_data += '<br><button type="button" class="quantity" name="bookId" value="' + value.id +'" style="width:70px">변경</button></td>';
	    		book_data += '<td id="cart-table-info"><strong>' + value.price * 0.9 + '원</strong></td>';
	    		book_data += '<td id="cart-table-info"><strong>내일</strong><br>(${deliveryDate})</td>';
	    		book_data += '<td id="cart-table-info"><button type="button" class="btn btn-primary" id="checkout-btn" value="' + value.id + '" style="width:85px">주문하기</button>';
	    		book_data += '<button type="button" class="btn btn-info" style="width:85px">찜하기</button>';
	    		book_data += '<button type="button" class="btn btn-default" id="del-button" value="' + value.id + '" style="width:85px">삭제하기</button></td>';
	    		book_data += '</tr>';
	    		
	    		fullPrice += parseInt(value.price*value.quantity);
	    	});
	    	fillPriceTable(fullPrice);
	    	
	    	return book_data;
      }
      // 가격 테이블 채워넣기 함수
      function fillPriceTable(fullPrice) {
    	  	let salePrice = fullPrice * 0.1;
	    	let totalPrice = fullPrice - salePrice;
	    	
	    	let delivery = (totalPrice >= 10000) ? 0 : 3000;
	    	
	    	let finalPrice = totalPrice + delivery;
	    	let totalPoint = Math.round(finalPrice * 0.05);
	    	
	    	if (finalPrice >= 10000) {
	    		$('div.price-table-info-2').text('만원 이상 배송비 무료');
	    	} else {
	    		$('div.price-table-info-2').text('만원 미만 배송비 3000원');
	    	}
	    	
	    	fullPrice = fullPrice.toLocaleString("en-US");
	    	salePrice = salePrice.toLocaleString("en-US");
	    	totalPrice = totalPrice.toLocaleString("en-US");
	    	delivery = delivery.toLocaleString("en-US");
	    	finalPrice = finalPrice.toLocaleString("en-US");
	    	totalPoint = totalPoint.toLocaleString("en-US");
	    	
	    	$('div.price-table-header-1>span#price-table-header-price').text(totalPrice + '원');
	    	$('div.price-table-info-1>span#full-price').text(fullPrice);
	    	$('div.price-table-info-1>span#sale-price>strong').text(salePrice);
	    	$('div.price-table-header-2>span#price-table-header-price').text(delivery + '원');
	    	$('div.price-table-header-4>span#price-table-header-price').text(finalPrice + '원');
	    	$('#std-point').text(totalPoint + '원');
	    	$('#tot-point>strong').text(totalPoint + '원');
      }
      function postToUrl(books, url) {
    	    let data = JSON.stringify(books)
    	  
  	        let form = document.createElement('form');
		
	  	    let obj1;
	  		obj1 = document.createElement('input');
	  		obj1.setAttribute('type', 'hidden');
	  		obj1.setAttribute('name', 'books');
	  		obj1.setAttribute('value', data);

	  		form.appendChild(obj1);

	  		form.setAttribute('method', 'post');
	  		form.setAttribute('action', url);
	
	  		document.body.appendChild(form);
	
	  		form.submit();
      }
      
      
      // $.('div.cart-table tbody').innerHTML = '';
    </script>
</body>
</html>