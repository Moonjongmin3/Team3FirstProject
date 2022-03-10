<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 카트 페이지 시작 -->
	<section>
		<aritcle>
			<hr id="mid-line">
			<div class="container-fluid cart-area">
				<div class="row">
					<div class="col-xs-12 col-md-10 col-md-offset-1">
						<hr>
						<input type="checkbox" id="check-all" checked>
						<label for="all-checked">전체선택</label>&nbsp;&nbsp;&nbsp;
						<div class="btn-group" role="group" aria-label="...">
						  <c:if test="${not empty userId}">
						  	<button type="button" class="btn btn-default addMyList-selected">장바구니에 넣기</button>
						  </c:if>
						  <c:if test="${empty userId}">
						  	<button type="button" class="btn btn-default" onclick="location.href ='../user/login.do'">장바구니에 넣기</button>
						  </c:if>
						  <button type="button" class="btn btn-default" id="delete-selected">삭제</button>
						</div>
					</div>
				</div>
				<c:if test="${empty userId and empty jjim}">
					<div class="row">
						<div class="col-xs-12 col-md-10 col-md-offset-1" id="empty-cart-area">
							<span id="empty-warning">찜 목록이 비었습니다..</span>
						</div>
					</div>
				</c:if>
				<c:if test="${not empty userId or not empty jjim}">
				<div class="row">
					<div class="col-xs-12 col-md-10 col-md-offset-1 cart-table">
						<table width="100%" cellspacing="0" cellpadding="0" border="0">
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
				</c:if>
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
	    		book_data += '<td valign="top" align="center"><input type="checkbox" class="book-check" value="' + value.id + '" checked></td>';
	    		book_data += '<td><img id="img-' + value.id + '" src="' + value.poster + '" alt="' + value.name + '"></td></tr>';
	    		book_data += '<td><span id="name-' + value.id + '">[' + value.mainCategory + '] ' + value.name + '</span><br><h5><span class="text-muted" id="price-' + value.id + '"><del>' + value.price + '원</del>';
	    		book_data += '</span> ' + value.price * 0.9 + '원 (10% 할인)</h5></td>';
	    		book_data += '<tr><td style="padding-top:3px;" align:"center">';
	    		book_data += '<td id="cart-table-info"><strong>' + value.price * 0.9 + '원</strong></td>';
	    		book_data += '<c:if test="${not empty userId}"><button type="button" class="btn btn-info" id="addMyList-btn" value="' + value.id + '" style="width:85px">장바구니에 넣기</button></c:if>';
	    		book_data += '<c:if test="${empty userId}"><button type="button" class="btn btn-info" style="width:85px" onclick="location.href =\'../user/login.do\'">장바구니에 넣기</button></c:if>';
	    		book_data += '<button type="button" class="btn btn-default" id="del-button" value="' + value.id + '" style="width:85px">삭제하기</button></td>';
	    		book_data += '</tr>';
	    		
	    	});
	    	
	    	return book_data;
    }
	</script>
	<script src="../js/cart.js"></script>
</body>
</html>