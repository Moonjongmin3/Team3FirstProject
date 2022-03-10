let recommendSwiper = new Swiper(".recommendSwiper", {
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
      let recentSwiper = new Swiper(".recentSwiper", {
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
      	    	let data;
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
	  		book['name'] = $('#name-' + $(this).val()).text();
			book['poster'] = $('#img-' + $(this).val()).attr('src');
			book['price'] = parseInt($('#price-' + $(this).val() + '>del').text().replace('원', ''));
  		    
  		    books.push(book);
  		    
      		let url = "../pay/orderlist.do";
    		
      		postToUrl(books, url)
      });
   	  // 주문하기 - 선택 상품
      $('.checkout-selected').click(function(){
    	  let books = [];
    	  let url = "../pay/orderlist.do";
    	  
    	  $.each($("input.book-check:checked"), function(){
			  let book = {};
    		  book['id'] = $(this).val();
    		  book['quantity'] = $('#quantity-' + $(this).val()).val();
    		  book['name'] = $('#name-' + $(this).val()).text();
    		  book['poster'] = $('#img-' + $(this).val()).attr('src');
    		  book['price'] = parseInt($('#price-' + $(this).val() + '>del').text().replace('원', ''));
    		  
    		  books.push(book);
      	  });
    	  
    	  postToUrl(books, url)
    	  
      })
      // 찜하기 - 개별 상품
       $(document).on('click', '#addMyList-btn', function(){
    	    let books = [];
    	    let book = {};
    	    book['id'] = $(this).val();
  		    book['quantity'] = $('#quantity-' + $(this).val()).val();
	  		book['name'] = $('#name-' + $(this).val()).text();
			book['poster'] = $('#img-' + $(this).val()).attr('src');
			book['price'] = parseInt($('#price-' + $(this).val() + '>del').text().replace('원', ''));
  		    
  		    books.push(book);
  		    
      		let url = "../my/Jjim.do";
    		
      		postToUrl(books, url)
      });
   	  // 찜하기 - 선택 상품
      $('.addMyList-selected').click(function(){
		  alert("찜하기 완료! 찜목록으로 이동");
    	  let books = [];
    	  let url = "../my/Jjim.do";
    	  
    	  $.each($("input.book-check:checked"), function(){
    		  let book = {};
    		  book['id'] = $(this).val();
    		  book['quantity'] = $('#quantity-' + $(this).val()).val();
    		  book['name'] = $('#name-' + $(this).val()).text();
    		  book['poster'] = $('#img-' + $(this).val()).attr('src');
    		  book['price'] = parseInt($('#price-' + $(this).val() + '>del').text().replace('원', ''));
    		  
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
    	  let data = $.param({ bookId : arr }, true);
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