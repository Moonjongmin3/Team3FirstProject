<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery.js"></script>
  <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  <script>
  $( function() {
    $("#accordion").accordion({
        heightStyle: "content"
    });
    
  });
  
  $.ajax({
  	type:'post',
  	url:'../my/adminPageGet.do',
  	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
  	dataType:'json',
  	success:function(res){
  		
  		let answerStay="";
  		$.each(res, function(key, value) {
  			answerStay += '<tr>';
  			answerStay += '<td>'+value.no +'</td>';
  			answerStay += '<td>'+value.userId +'</td>';
  			answerStay += '<td class="text-left">'+value.title +'</td>';
  			answerStay += '<td>'+value.username +'</td>';
  			answerStay += '<td>'+value.createdAt +'</td>';
  			answerStay += '<td><a href="../customer/one_inquiry_detail.do?groupId='
  							+value.groupId+'"class="btn btn-sm" style="background-color: 4364F7;border-radius: 20px;font-weight: 550;color: white;">답변하기</a></td>';
  			answerStay += '</tr>';
  			
  		})
  		$('#answer_stay tr:first-child').after(answerStay);
  	} 
  })
  
  $.ajax({
  	type:'post',
  	url:'../my/adminPageOrderGet.do',
  	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
  	dataType:'json',
  	success:function(res){
  		console.log(res)
  		let i=0;
  		let row=1;
  		let count=0;
  		$.each(res, function(key, value) {
  			let total =value.total_price.toLocaleString('ko-KR');
  			if(i==value.order_id){
  				count=count+1;
  				let orderStay="";
  				i=value.order_id
  				let j = key-count
  				row= row+1;
  				$('#id_td'+j).attr("rowspan",row)
				$('#user_td'+j).attr("rowspan",row)
				$('#total_td'+j).attr("rowspan",row)
				$('#btn_td'+j).attr("rowspan",row)
  				
  				orderStay += '<tr id="order_tr'+key+'">';
  	  			orderStay += '<td><img src="'+value.poster +'" style="width:70px;height: 90px"/></td>';
  	  			orderStay += '<td style="padding-left: 20px;">'
  	  			orderStay += '<div class="text-left" style="margin-bottom:5px">'+$.trim(value.bookName)+'</div>';
  	  			orderStay += '<div class="text-left">'+addComma(value.bookPirce)+'원</div>' 
  	  			orderStay += '</td>'
  	  			orderStay += '<td>'+value.quantity +'</td>';
  	  			orderStay += '<td>'+value.order_date +'</td>';
  	  			orderStay += '</tr>';
  	  			let n=key-1
  	  			$('#order_tr'+n).after(orderStay);
  			}else{
  				count=0;
  				let orderStay2="";
  				row=1;
  				i=value.order_id
  				orderStay2 += '<tr id="order_tr'+key+'">';
  	  			orderStay2 += '<td id="id_td'+key+'">'+value.order_id +'</td>';
  	  			orderStay2 += '<td id="user_td'+key+'">'+value.user_id +'</td>';
  	  			orderStay2 += '<td id="total_td'+key+'">'+total+'원</td>';
  	  			orderStay2 += '<td><img src="'+value.poster +'" style="width:70px;height: 90px"/></td>';
  	  			orderStay2 += '<td style="padding-left: 20px;">'
  	  			orderStay2 += '<div class="text-left" style="margin-bottom:5px">'+$.trim(value.bookName)+'</div>';
  	  			orderStay2 += '<div class="text-left">'+addComma(value.bookPirce)+'원</div>' 
  	  			orderStay2 += '</td>'
  	  			orderStay2 += '<td>'+value.quantity +'</td>';
  	  			orderStay2 += '<td>'+value.order_date +'</td>';
  	  			orderStay2 += '<td id="btn_td'+key+'"><a href="../customer/one_inquiry_detail.do?groupId='
  	  							+value.order_id+'"class="btn btn-sm" style="background-color: 4364F7;border-radius: 20px;font-weight: 550;color: white;">주문승인</a></td>';
  	  			orderStay2 += '</tr>';
  	  			let u=key-1;
	  	  		if(key==0){
		  				console.log("orderStay first")
					$('#order_stay tr:first-child').after(orderStay2);
				}else{
					$('#order_tr'+u).after(orderStay2);
				}
  	  			
  			}
  			
  			
  		})
  		
  	}
  	
  })
 
  function addComma(value){
        value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return value; 
    }
  </script>
</head>
<body>
	<div class="admin_wrap">
		<div class="admin_top">
			<h3>관리자 페이지</h3>
		</div>
		<div class="admin_info_wrap">
			<div class="admin_section">
				<div class="admin_name">
					김장군 (운영자)
				</div>
				<div class="admin_info_btn_group">
					<a class="admin_info_btn">관리자 삭제</a>
					<a class="admin_info_btn">관리자 계정 수정</a>
				</div>
			</div>
			<table class="admin_info_list">
				<tbody>
					<tr>
						<td class="admin_info_first" width="12%">
							<div class="admin_tit">
								아이디
							</div>
							<div class="admin_info">
								${admin.id }
							</div>
						</td>
						<td class="admin_info_first" width="12%">
							<div class="admin_tit">
								생년월일
							</div>
							<div class="admin_info">
								${admin.birth }
							</div>
						</td>
						<td class="admin_info_first" width="5%">
							<div class="admin_tit">
								성별
							</div>
							<div class="admin_info">
								${admin.gender }
							</div>
						</td>
						<td class="admin_info_first" width="10%">
							<div class="admin_tit">
								전화번호
							</div>
							<div class="admin_info">
								0${admin.tel }
							</div>
						</td>
						<td class="admin_info_first" width="20%">
							<div class="admin_tit">
								e-mail
							</div>
							<div class="admin_info">
								${admin.email }
							</div>
						</td>
						<td class="admin_info_first" width="12%">
							<div class="admin_tit">
								가입일
							</div>
							<div class="admin_info">
								${admin.registered_at }
							</div>
						</td>
					</tr>
				</tbody>	
			</table>
			</div>
		<div id="accordion">
		  <h3>주문 승인 대기 목록</h3>
		  <div class="order_stay_list">
			    <table style="width: 100%"class="order_stay_list_table" id="order_stay">
			    	<tr>
			    		<th width="10%">주문 번호</th>
			    		<th width="10%">주문자 ID</th>
			    		<th width="10%">주문 금액</th>
			    		<th colspan="2" width="40%">상품 정보</th>
			    		<th width="5%">수량</th>
			    		<th width="10%">주문 날짜</th>
			    		<th width="15%">주문 상태</th>
			    	</tr>
			    </table>
		  </div>
		  <h3>1:1 답변 대기 목록</h3>
		  <div style="height: 400px">
			    <table style="width: 100%"class="order_stay_list_table" id="answer_stay">
			    	<tr>
			    		<th width="10%">문의 번호</th>
			    		<th width="10%">문의자 ID</th>
			    		<th width="45%">제목</th>
			    		<th width="10%">문의자 이름</th>
			    		<th width="15%">문의 날짜</th>
			    		<th width="10%"></th>
			    	</tr>
			    </table>
		  </div>
		  <h3>Section 3</h3>
		  <div>
			    <p>
			    Nam enim risus, molestie et, porta ac, aliquam ac, risus. Quisque lobortis.
			    Phasellus pellentesque purus in massa. Aenean in pede. Phasellus ac libero
			    ac tellus pellentesque semper. Sed ac felis. Sed commodo, magna quis
			    lacinia ornare, quam ante aliquam nisi, eu iaculis leo purus venenatis dui.
			    </p>
			    <ul>
			      <li>List item one</li>
			      <li>List item two</li>
			      <li>List item three</li>
			    </ul>
		  </div>
		</div>
	</div>
</body>
</html>