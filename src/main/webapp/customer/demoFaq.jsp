<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<script src="http://code.jquery.com/jquery.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>



<style>
#content {
	margin-left: 30px;
}

/*  */
}
#container {
	width: 1000px;
	margin: 0 auto;
	margin-top: 30px;
	margin-bottom: 200px;
	/* border: 1px solid black; */
	/* box-sizing: border-box; */
}

#qus {
	
	font-weight: 900;
}
#cs_top3{
	margin-top: 60px;


}

#top3_1 {
	margin-bottom: 35px;
}

#top3_1_1>p {
	margin-left: 20px;
	margin-top: 35px;
}

#top3_2 {
	margin-top: 50px;

	margin-bottom: 35px;
}

#top3_2_1>p {
	margin-left: 20px;
	margin-top: 35px;
}


#top3_3 {
	margin-top: 40px;
	margin-bottom: 35px;
}

#top3_3_1>p {
	margin-left: 20px;
	margin-top: 35px;
}


}
#tabs {
	/* background: #f8f8f8; */
	margin-left: 14px;
	font-family: 'InfinitySans-RegularA1';
}

#tabs-1-1 {
	margin-bottom: 60px;
}

#tabs-1-1>p {
	margin-top: 20px;
	margin-left: 20px;
}

#tabs-1-2 {
	margin-bottom: 60px;
}

#tabs-1-2>p {
	margin-top: 20px;
	margin-left: 20px;
}

#tabs-1-3 {
	margin-bottom: 60px;
}

#tabs-1-3>p {
	margin-top: 20px;
	margin-left: 20px;
}

#tabs-2-1 {
	margin-bottom: 60px;
}

#tabs-2-1>p {
	margin-top: 30px;
	margin-left: 20px;
}

#tabs-2-2 {
	margin-bottom: 60px;
}

#tabs-2-2>p {
	margin-top: 30px;
	margin-left: 20px;
}

#tabs-2-3 {
	margin-bottom: 60px;
}

#tabs-2-3>p {
	margin-top: 30px;
	margin-left: 20px;
}

< /*
3 
 */
#tabs-3-1 {
	margin-bottom: 60px;
}

#tabs-3-1>p {
	margin-top: 30px;
	margin-left: 20px;
}

#tabs-3-2 {
	margin-top: 60px;
	margin-bottom: 60px;
}

#tabs-3-2>p {
	margin-top: 30px;
	margin-left: 20px;
}

#tabs-4-1 {
	margin-bottom: 60px;
}

#tabs-4-1>p {
	margin-top: 40px;
	margin-left: 20px;
}

#tabs-4-2 {
	margin-top: 60px;
	margin-bottom: 60px;
}

#tabs-4-2>p {
	margin-top: 40px;
	margin-left: 20px;
}

#tabs-4-3 {
	margin-top: 60px;
	margin-bottom: 60px;
}

#tabs-4-3>p {
	margin-top: 40px;
	margin-left: 20px;
}

/* #tabsna>tabs>ul>li: {
	margin-left: 20px;
		border: 1px solid black;
} */
</style>


<script>
	$(function() {
		$("#tabs").tabs();
	});
</script>


</head>
<body>







	<!-- content  -->
	<div id="content">
		<div id="container">

			<div id="qus">

				<h3>FAQ 자주 묻는 질문 TOP 3</h3>

			</div>
			<hr>
			<div id="cs_top3">
				<h4>주문 확인,주소 변경,배송 확인,교환/반품 방법,취소 방법,회수 조회 방법 안내드립니다.</h4>

				<div id="top3_1">
					<div id="top3_1_1">

						<p>

							1. 주문 : 마이페이지 주문내역에서 확인이 가능합니다.<br><br>  2. 주소 변경: 마이페이지 주문 내역에서
							상품 준비 중 상태까지 직접 가능합니다.<br> <br> 3. 배송 : 마이페이지 주문내역/ 배송조회 항목에서 도착
							예상일 확인, 배송 조회가 가능합니다. <br><br>  4. 교환 : 마이페이지 반품/교환 항목에서 직접 접수 및
							접수내역 조회가 가능합니다.<br><br>  5. 반품 : 마이페이지 반품/교환 항목에서 출고 후 10일 이내 직접
							접수 및 접수 내역 조회가 가능합니다.<br><br>  6. 취소 : 마이페이지 주문내역에서 발송 준비 중 단계까지
							직접 취소가 가능합니다. <br> <br>단, 부분 취소는 PC 버전에서만 처리됩니다.<br> <br>7. 회수 :
							교환/ 반품 접수 내역의 회수는 마이페이지 반품/교환 항목에서 반송장 확인이 가능합니다.<br><br>  감사합니다.
						</p>
					</div>

				</div>
<hr>

				<div id="top3_2">
					<h4>도서정가제란 무엇인가요?</h4>
					<div id="top3_2_1">
						<p>
							품절, 절판 상품은 유통이 중단되어 주문이 불가능합니다.<br><br>  하지만 품절 상품 중 일부는 재출간이 되는
							경우도 있으니,판매 알림 신청을 이용부탁드립니다.<br><br>  판매 알림 신청은 도서 상세페이지>우측에 위치하며,
							재출간 시 SMS와 메일로 안내해드립니다. <br> <br> 또는 도서 상세페이지에 안내되고 있는 중고상품을 구매하셔도
							됩니다.<br> <br>
						</p>
					</div>
				</div>
				<hr>

				<div id="top3_3">
					<h4>품절, 절판 상품은 구입할 수 없습니까?</h4>
					<div id="top3_3_1">
						<p>
							도서정가제는 한국출판문화산업진흥법 개정안을 쉽게 부르는 명칭으로 2003년 2월부터 시행되었습니다. <br>
							<br> 2014년 11월 개정된 도서정가제는 모든 도서를 종류에 관계없이 10% 가격할인에 간접
							할인(적립)을 5%까지,<br> 최대 15%의 할인으로 제한하였으며, 출판사가 출간 후 18개월 이상 지난
							도서의 정가를 조정할 수 있도록 보완되었습니다.<br>이에 따라 온오프라인 서점의 도서 판매 가격 격차를
							줄이고 도서 정가를 인하하도록 유도하는 것입니다. <br> <br> 도서정가제로 인해 할인 판매에는
							제약이 생겼습니다만, 무료 배송, 제휴 카드 할인 및 제휴 포인트 사용/적립 등은 시행 이후에도 동일하게 진행
							중입니다. <br><br> 저희 쌍용북스는 제휴카드 출시, 양질의 사은품 제작 등 고객님의 최대 혜택을 위하여 계속
							노력하겠습니다.
						</p>
					</div>
				</div>

				<hr>




				<div id=tabs>

					<ul style="margin-top: 30px; margin-bottom: 40px">
						<li><a href="#tabs-1"> 상품 </a></li>
						<li><a href="#tabs-2"> 주문/결제 </a></li>
						<li><a href="#tabs-3"> 배송 </a></li>
						<li><a href="#tabs-4"> 환불 </a></li>
					</ul>

					<div id="tabs-1">
						<p class="inline">
						<h3>[외국도서] 책 단면이 울퉁불퉁한데 반품/교환이 가능한가요?</h3>
						<div id="tabs-1-1">
							<p>
								책 단면이 울퉁불퉁한 외국도서는 고급 제본 방식으로(Deckle Edge/Rough Cut) 일부러 울퉁불퉁하게
								처리하여 자연미를 강조하고,<br> 손가락 베임을 방지하기 위해 제본 상품 이므로 반품/교환 대상이
								아닙니다. 해외 도서 정보 부족으로 해당 특징이 표기 되어 있지 않을 수 있으나, <br>파본이 아니므로
								해당 사유로 반품 및 교환이 불가한 점 양해 부탁 드립니다.
							</p>
						</div>
						<div id="tabs-1-2">
							<h3>쌍용북스에 없는 제품은 따로 요청하여 구입할 수 있나요?</h3>

							<p>
								구입을 원하시는 상품이나 쌍용북스에서 구매를 희망하시는 상품이 있으시면 1:1 상담에서 상품에 대한 정보를
								넘겨주시길 바랍니다.<br> 해당 업체와 협력하여 최대한 반영하도록 노력하겠습니다.<br> <br>
								단, 지속적인 공급이 어려운 상품은 판매하지 않는 것을 원칙으로 하고 있습니다.
							</p>
						</div>
						<h3>국내도서에서 품절(절판)과 일시품절은 어떻게 다른가요?</h3>
						<div id="tabs-1-3">
							<p>
								* 품절 <br> <br> 출판사에서 당분간 재출간할 계획이 없는 상품으로 유통이 되지 않아 판매하지 않는
								상품입니다.<br> 도서의 경우 소량의 재고가 서점 등에 남아 있을 수 있지만, 유통 시장 내에서는 구할
								수 없는 경우가 많습니다.<br> 또한 인쇄와 제본의 과정을 거쳐야 하는 도서의 특성상 베스트셀러 도서라
								할지라도 일시적으로는 유통 시장에서 구할 수 없는 경우도 있습니다.<br> 상황의 변화에 따라서 다시
								공급이 재개되는 경우가 있으며, 특히 꾸준한 판매가 이루어지는 도서나<br> 상품의 경우에는 시일이 지난
								후에 정상적으로 판매되기도 합니다. <br><br>  *절판<br>  <br> 재출간 계획이 없거나 판권 소멸로
								출판이 불가능한 상품입니다.<br> <br> <br> *일시품절<br><br>  출판사나 상품제작사의
								사정에 따라 재고부족등의 사유로 한동안 판매중단이 된 상품입니다.<br> 제작사 상황에 따라 판매가 정상화
								되거나 품절, 절판될 수 있습니다. <br>



							</p>
						</div>
					</div>

					<div id="tabs-2">
						<p class="inline">
						<h3>쌍용북스에서 사용 가능한 결제수단은 어떤 것들이 있나요?</h3>
						<div id="tabs-2-1">
							<p>
								당사에서는 회원님들께 다양한 결제 수단을 제공하고 있습니다.<br> <br> 1. 기본 결제수단
								신용카드, 무통장 입금(은행송금), 계좌이체, 휴대폰결제, 간편결제(카카오페이, 페이코, 시럽페이, 네이버페이,
								삼성페이) <br>2. 할인/적립 결제수단 쿠폰, 가족계좌, 예치금, YES머니, YES24상품권 <br>3.
								외부상품권/포인트 기프티쇼, 문화상품권, 해피머니 상품권, 도서문화상품권, 네이버책쿠폰, 모바일상품권,
								GS&POINT, OK캐쉬백 포인트, L.POINT (홈플러스 상품권의 경우 현재 일시적으로 사용 중단되었습니다.)
								<br> <br>※ 외부상품권은 각각 사용 방법이 다르니 자세한 안내를 확인 후 이용하시기
								바랍니다.<br> ※ 기본 결제수단과 할인/적립 결제수단 및 외부상품권/포인트는 같이 사용 가능합니다. ※
								네이버책쿠폰은 모바일에서는 사용이 불가능하니 참고 부탁드립니다. <br>
							</p>
						</div>


						<h3>무통장입금(은행송금)은 어떻게 하나요?</h3>
						<div id="tabs-2-2">
							<p>
								무통장 입금을 통한 결제 방법은 다음과 같습니다.<br> <br> 저희 쌍용북스에서는 무통장
								입금(은행송금)을 통해 주금 대금을 결제할 수 있습니다.<br> <br> 결제단계에서 무통장 입급
								> 입금은행 선택 후 입금자 이름을 입력하여 [동의 합니다] 체크박스를 클릭하면 주문이 완료됩니다.<br>
								<br> 이후 고객님 주문만의 고유 가상계좌가 발급되면 입금을 해주시면 됩니다.<br> <br>
							</p>
						</div>
						<div id="tabs-2-3">
							<h3>도서문화 상품권 사용은 어떻게 하나요?</h3>

							<p>
								한국도서보급 주식회사에서 발행한 도서문화상품권, 도서생활권 (북앤라이프 문화상품권) 사용 방법입니다.<br>
								<br> ● PC http://www.yes24.com/Exchange/Exchange01.aspx <br>
								<br> 1. (YES24 첫 화면 하단 왼쪽 > YES24 대표서비스 > 믿을 수 있다 > [YES
								환전소] > [도서문화상품권 / 도서생활권]을 클릭 > [YES상품권으로 환전] 버튼을 클릭 후 사용 <br>
								2. 카트에 담은 상품 [주문하기]를 클릭한 후 [결제] 단계에서 [외부상품권/포인트] 메뉴 중 [도서문화상품권]
								을 클릭 > [YES상품권으로 환전] 버튼을 클릭 후 북앤라이프 사이트의 아이디 와 비밀번호를 입력하신 후, 캐시
								잔액을 확인 후 [YES24상품권으로 환전]하여 사용 가능합니다. <br> <br> ● 모바일
								[카트] 메뉴 하단 [주문하기] > [결제] 단계에서 [할인적용] 하단의 [외부상품권/포인트] 메뉴 중
								[도서문화상품권(북앤라이프)]를 선택 > 북앤라이프 아이디 와 비밀번호를 입력 후 [캐시잔액 조회] >
								[사용하기]를 선택 후 바로 사용 가능합니다.<br>
							</p>
						</div>
					</div>
					<div id="tabs-3">
						<p class="inline">
						<div id="tabs-3-1">
							<h3>[배송] 부분 출고란 무엇인가요?</h3>

							<p>
								부분 출고란, 전체 주문 중 상품출발 예상일이 지나도 일부 상품이 확보되지 못하는 경우 재고가 확보된 상품을 먼저
								발송하는 제도입니다. <br>부분 출고 후, 미 발송된 상품은 추후 확보 되는대로 바로 발송해 드리며 만약
								확보가 어려울 경우 안내와 함께 환불됩니다. <br>(부분 출고 시 추가되는 비용은 당사에서 부담합니다.)<br>
							</p>
						</div>
						<div id="tabs-3-2">
							<h3>[배송] 배송비 착불 상품은 무엇이며 배송비는 어떻게 지불하나요?</h3>

							<p>
								배송비 착불 상품은 결제 시 배송비 결제가 아닌, 주문한 상품을 수령할 때 직접 택배기사에게 배송 비를 지불하는
								방식입니다. <br> 상품공급처에서 직접 배송되는 일부 상품 중 착불배송상품이 있을 수 있으며, 한
								주문번호에 서로 다른 공급처의 착불상품을 여러 개 주문하셨다면 상품종류만큼 착불배송비를 지불해야 합니다. <br>
								배송 비 금액은 정해져 있지 않으며 각 제품 정보에 예상 배송비로 안내되어 있으니,주문 전 착불배송비를 꼭 확인하신
								후 구매해 주시기 바랍니다.<br>
							</p>
						</div>

					</div>

					<div id="tabs-4">
						<p class="inline">
						<div id="tabs-4-1">
							<h3>휴대폰 결제로 주문한 경우 취소시 환불은 어떻게 되나요?</h3>

							<p>
								휴대폰결제를 통한 주문 시 결제대금이 다음 달 휴대폰요금과 함께 청구되며, 이동통신사 정책에 따라 결제 승인 취소는
								해당 월 내에만 가능합니다. <br> <br> ※ 휴대폰 결제 취소는 주문한 달의 말일까지만 가능 익월 취소시에는
								YES24 예치금으로 환불 (통신사 정책에 따라 승인취소 불가능) <br>단, 예치금 -> 계좌환불접수 시
								환불 시기는 결제 익월 28일 이후<br>
							</p>
						</div>
						<div id="tabs-4-2">
							<h3>파본이나 오발송, 배송지연 반품은 어떻게 하나요 ?</h3>

							<p>
								주문한 상품과는 다른 상품을 수령 했거나 파본,배송지연의 경우 무료로 반품이 가능합니다.<br> <br>
								1. 고객센터를 통해 접수하는 방법 1:1 친절상담 또는 대표번호 1544-3800번으로 요청해 주시면, 신속하게
								처리해 드리겠습니다. (주문번호와 상품명을 알려주시면 보다 빠르게 처리 가능합니다.) <br> <br>
								2. 홈페이지를 통해 접수하는 방법 <br> <br>YES24홈페이지 로그인 - 마이페이지 -
								반품/교환 신청 및 조회 - 반품/교환 신청하기 선택 - 반품선택 -[상품파손],[오배송],[배송지연]해당하는 반품
								항목 선택 <br> - 주문번호 조회 후 상품선택 -택배방법과 회송정보 입력 후 확인 버튼 선택하시면
								됩니다.<br> 상품은 수령하신 상태 그대로 포장 부탁드리며,메모지에 반품 도서의 주문번호, 성함,
								연락처, 반품사유를 기재하여 동봉 부탁드립니다. <br>반품 신청 후 1~3일 내(평일기준) 택배기사가
								방문하여 상품을 수거하며, 물류센터 도착 후 환불이 됩니다. <br><br> 3. 모바일 앱에서는 접수가 불가하니
								PC나 PC버전으로 접속 후 접수해 주시기 바랍니다. <br> <br> ※ 참고사항 <br>
								1.파본,오발송,지연반품의 경우 YES24지정택배를 통한 반품만 가능합니다.<br> 2.반송시, 파본
								도서의 경우 인쇄되지 않은 페이지나, 중복된 페이지, 찢어진 부분 등 구체적인 파본 부분을 메모지에
								기재부탁드립니다.<br> 3.사서함, 군부대, 도서산간 지역 등은 지정택배로 반품이 불가능하오니 신청 후
								상품을 직접 반품해주시기 바랍니다.<br> (상품파손, 오배송의 경우 반품 배송비는 고객센터로 연락 주시면
								환불해 드리겠습니다.) <br> 4.문제점 발견이 단기간에 어려운 (파본)의 경우 문제점 발견 후
								30일(늦어도 수령일로부터 3개월) 이내 가능합니다.<br>
							</p>
						</div>
						<div id="tabs-4-3">
							<h3>[도서분철] 분철 상품 주문 시 '취소/교환/반품' 이 가능한가요?</h3>

							<p>
								일반상품을 편집하여 제공되는 분철서비스 특성 상 편집 완료 된 상품의 '취소/교환/반품'은 불가능 합니다. <br>분철편집이
								진행되기 전 단계인 "발송 준비 중" 상태인 경우만 취소 가능하며, 분철 상품은 반품 및 교환 신청이 불가능합니다.
								<br>수령하신 분철상품의 문제가 있으실 경우 고객센터 1544-3800 또는 고객센터>1:1친절상담으로
								문의해주시길 바랍니다.
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>


<!--  <script>
$(document).ready(function(){
  $(".nav nav-tabs").click(function(){
    $(this).tab('show');
  });
  $('.nav nav-tabs').on('shown.bs.tab', function(event){
    var x = $(event.target).text();         // active tab
    var y = $(event.relatedTarget).text();  // previous tab
   
  });
});
</script> -->

</html>