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
  		$('#order_stay tr:first-child').after(answerStay);
  	}
  })
  
  $.ajax({
  	type:'post',
  	url:'../my/adminPageOrderGet.do',
  	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
  	dataType:'json',
  	success:function(res){
  		console.log(res)
  		let orderStay="";
  		 /* $.each(res, function(key, value) {
  			answerStay += '<tr>';
  			answerStay += '<td>'+value.order_id +'</td>';
  			answerStay += '<td>'+value.userId +'</td>';
  			answerStay += '<td class="text-left">'+value.total_price +'</td>';
  			answerStay += '<td>'+value.username +'</td>';
  			answerStay += '<td>'+value.createdAt +'</td>';
  			answerStay += '<td><a href="../customer/one_inquiry_detail.do?groupId='
  							+value.groupId+'"class="btn btn-sm" style="background-color: 4364F7;border-radius: 20px;font-weight: 550;color: white;">답변하기</a></td>';
  			answerStay += '</tr>';
  		})
  		$('#order_stay tr:first-child').after(answerStay);  */
  	}
  })
 /* <tr>
			    		<td>주문자 ID</td>
			    		<td>수령자</td>
			    		<td>수령 주소</td>
			    		<td>수령자 번호</td>
			    		<td>배송 요청 사항</td>
			    		<td>주문 날짜</td>
			    	</tr> */
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
			    <table style="width: 100%"class="order_stay_list_table">
			    	<tr>
			    		<th width="10%">주문 번호</th>
			    		<th width="10%">주문자 ID</th>
			    		<th width="10%">주문 금액</th>
			    		<th colspan="2" width="40%">상품 정보</th>
			    		<th width="5%">수량</th>
			    		<th width="10%">주문 날짜</th>
			    		<th width="15%">주문 상태</th>
			    	</tr>
			    	<tr>
			    		<td>1</td>
			    		<td>test1</td>
			    		<td>94,000</td>
			    		<td>
			    			<img src="../img/1.jpg" style="width:70px;height: 90px">
			    		</td>
			    		<td>
			    			<div class="text-left">
			    				정보처리기사 
			    			</div>
			    			<div class="text-left">
			    				34,000원 / 1개
			    			</div>
			    		</td>
			    		<td>2</td>
			    		<td>2022-03-12</td>
			    		<td>주문승인</td>
			    	</tr>
			    </table>
		  </div>
		  <h3>1:1 답변 대기 목록</h3>
		  <div style="height: 400px">
			    <table style="width: 100%"class="order_stay_list_table" id="order_stay">
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