<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery.js"></script>
  <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
  <script>
  $( function() {
    $( "#accordion" ).accordion();
  } );
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
								admin
							</div>
						</td>
						<td class="admin_info_first" width="12%">
							<div class="admin_tit">
								생년월일
							</div>
							<div class="admin_info">
								2022-02-03
							</div>
						</td>
						<td class="admin_info_first" width="5%">
							<div class="admin_tit">
								성별
							</div>
							<div class="admin_info">
								남성
							</div>
						</td>
						<td class="admin_info_first" width="10%">
							<div class="admin_tit">
								전화번호
							</div>
							<div class="admin_info">
								01055555555
							</div>
						</td>
						<td class="admin_info_first" width="20%">
							<div class="admin_tit">
								e-mail
							</div>
							<div class="admin_info">
								jim424ds@naver.com
							</div>
						</td>
						<td class="admin_info_first" width="12%">
							<div class="admin_tit">
								가입일
							</div>
							<div class="admin_info">
								2013-03-12
							</div>
						</td>
					</tr>
				</tbody>	
			</table>
			</div>
		<div id="accordion">
		  <h3>주문 승인 대기 목록</h3>
		  <div class="order_stay_list">
			    <table>
			    	<tr>
			    		<th width="10%">주문자 ID</th>
			    		<th>수령자</th>
			    		<th>수령 주소</th>
			    		<th>수령자 번호</th>
			    		<th>배송 요청 사항</th>
			    		<th>주문 날짜</th>
			    		<th>총 가격</th>
			    	</tr>
			    	<tr>
			    		<td>주문자 ID</td>
			    		<td>수령자</td>
			    		<td>수령 주소</td>
			    		<td>수령자 번호</td>
			    		<td>배송 요청 사항</td>
			    		<td>주문 날짜</td>
			    		<td>총 가격</td>
			    	</tr>
			    </table>
		  </div>
		  <h3>1:1 답변 대기 목록</h3>
		  <div>
			    <p>
			    Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet
			    purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor
			    velit, faucibus interdum tellus libero ac justo. Vivamus non quam. In
			    suscipit faucibus urna.
			    </p>
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