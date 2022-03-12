<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%--price -> "#,##0원" --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
 $(function(){
	
	 $('#order_btn').click(function(){
	    	console.log("click")
	    	let name = $('#receiver_name').val()
	    	 $('#name_data').val(name); 
	    	let addr1 =$('#ship_address1').val()
	    	 $('#addr1_data').val(addr1);
	    	let addr2=$('#ship_address2').val()
	    	 $('#addr2_data').val(addr2);
	    	let zipcode=$('#zipcode').val()
	    	 $('#zip_data').val(zipcode);
	    	let phone1 = $('#receiver_phone1').val()
	    	 $('#rphone1_data').val(phone1);
	    	let phone2=$('#receiver_phone2').val()
	    	 $('#rphone2_data').val(phone2);
	    	let phone3=$('#receiver_phone3').val()
	    	 $('#rphone3_data').val(phone3);
	    	let msg = $('#ship_request').val()
	    	 $('#msg_data').val(msg);
	    	let totalprice=$('#total_price').text()
	    	 $('#total_data').val(totalprice);
	    	 let bookid =$('#book_id').val()
	    	 $('#bid_data').val(bookid);
	    	 let poster=$('#order_poster').val()
	    	 $('#poster_data').val(poster);
	    	 let catename = $('#category_name').val()
	    	 $('#catename_data').val(catename);
	    	 let qty=$('#qty').text()
	    	 console.log(qty)
	    	 $('#qty_data').val(qty);
	    	 
	    	 	let fr = $('#orderFrm')
	    	 	fr.submit()
	    	 })
	 
	 
 })
</script>
</head>
<body>
  <div class="container">
    <h2>주문상품</h2>
    <hr>
    <div class="Lrow">
<!--주문상품--------------------------------------------------------------- -->
      <div class="orderitem">
        <table class="table table_oi">
           <thead>
            <tr>
              <th colspan="2"><strong>상품명</strong></th>
              <th><strong>정가</strong></th>
              <th><strong>판매가</strong></th>
              <th><strong>수량</strong></th>
              <th><strong>합계</strong></th>
              <th><strong>배송일</strong></th>
            </tr>
          </thead>
          <tbody>
           <fmt:parseNumber value="0" var="total"/>
           <c:set var = "sum" value = "0" />
           <c:forEach var="bvo" items="${orderBookList }">
            <tr>
            	<td>
              	<input type="hidden" name="book_id" class="book_id" value="${bvo.id }">
              </td>
            </tr>
            <tr>
             <td class="img_oi"><img alt="poster" id="order_poster" src="${bvo.poster }" width="120px" height="150px"></td>
              <td class="title_oi" style="padding-top:20px" ><a href="#" id="category_name">${bvo.name }</a><br>${bvo.author }</td>
              <td><fmt:formatNumber pattern="#,##0 원" value="${bvo.price}"/><br>
                (10%<img src="../img/arrow.PNG" style="height: 15px;width: 15px;">)<br>
                <img src="../img/point.PNG" style="height: 15px;width: 15px;"><fmt:formatNumber pattern="#,##0"  value="${bvo.price*0.05}"/>
              </td>
              <td><fmt:formatNumber pattern="#,##0 원"  value="${bvo.price*0.9}"/></td>
              <c:set var= "sum" value="${sum+bvo.price*0.9}"/>
              <td class="qty">${bvo.quantity}</td>
              <td id="total_price"><fmt:formatNumber pattern="#,##0 원" value="${bvo.price*0.9*bvo.quantity }"/></td><!--책 개별 합계 -->
              <td>내일<br>도착예정
              </td>
              <td style="display: none">
              	<fmt:parseNumber value="${bvo.price }" var="price"/>
                 ${total=total+price }
              </td>
            </tr>
           </c:forEach>
           <c:if test="${sum < 10000}">
           	<c:set var= "sum" value="${sum+3000}"/>
           </c:if>
          </tbody>
        </table>
        <ul class="caution_ul">
          <li><img alt="" src="../img/caution.PNG" style="height: 20px;width: 20px;"> 
              날씨나 택배사 사정에 따라 배송이 지연될 수 있습니다. </li>        
        </ul>
        <ul style="padding-left:25px;">
          <li>도서정가제 대상 도서는 최대 10% 할인 + 5% 적립 혜택 가능 (쿠폰은 최대 할인 및 적립 범위 내에서만 적용 가능)</li>
          <li>5만원 이상 구매시 2천원 추가적립 : 외국도서(eBook 포함),중고도서 2천원 이상 포함 시</li>
        </ul>            
      </div>
<!--배송정보------------------------------------------------------------------ -->
      <div class="wrap_gray_div">
        <h2>배송정보</h2>
        <hr>
        <div class="wrap_gray">
        <div class="wrap_gray_content" >        
          <table class="table_addr" style="width:100%;">
             <tr>
              <th width=15%><strong>배송지</strong></th>
              <td width=85%>
                <label><input type="radio" id="user_addr" name="addr_mtd" value="user_addr" checked="checked">  회원정보와 동일</label>   
                <label><input type="radio" id="new_addr" name="addr_mtd" value="new_addr" style="margin-left:20px">  새로입력</label>
              </td>
            </tr>
            <tr>
              <th width=15%><strong>이름</strong></th>
              <td width=85%><input type="text" id="receiver_name" name="receiver_name" value="${uvo.name }" size="10"> </td><!-- user.name -->
            </tr>
            <tr>
              <th width=15%><strong>배송주소</strong></th>
              <td width=85%>
                <input type="text" name="zipcode" id="zipcode" value="${uvo.post }" readonly="readonly" size="10"style="margin-bottom:8px;">&nbsp;&nbsp;<input type="button" id="postBtn_pay" value="주소찾기"><br>
                도로명 주소<input type="text" name="ship_address1" id="ship_address1" value="${uvo.address1 }" readonly="readonly" size="35"style=";margin-bottom:8px;"><br>
                상세 주소<input type="text" name="ship_address2" id="ship_address2" value="${uvo.address2 }"size="35" style="margin-left:14px;margin-bottom:8px;"><br>                
                <ul class="caution_ul">
                  <li style="font-size: 10px">
                    <img alt="!!" src="../img/caution_sm.PNG" style="height: 13px;width: 5px;margin-top:0px;"> 
                     &nbsp;주소/우편번호 체계가 새롭게 변경되었습니다.<br>
                    &nbsp;&nbsp; 정확하고 빠른 배송을 위해 입력된 주소를 확인 해주시기 바랍니다.
                  </li>
                </ul>     
              </td>
            </tr>
            <tr>
              <th width=15%><strong>휴대폰</strong></th>
              <td width=85%>
                <select name="r_phone1" value="${fn:substring(uvo.tel,0,2) }" id="receiver_phone1">
               <option value="010" selected="selected">010</option>
                   <option value="011">011</option>
                   <option value="016">016</option>
                   <option value="017">017</option>
                   <option value="018">018</option>
                   <option value="019">019</option>
            </select>&nbsp;-&nbsp;
                 <input type='tel' name='r_phone2' value="${fn:substring(uvo.tel,2,6) }" size="2" id="receiver_phone2"/>&nbsp;-&nbsp;
             <input type='tel' name='r_phone3' value="${fn:substring(uvo.tel,6,10) }" size="2" id="receiver_phone3"/><br>
                <div class="caution">
                  연락처는 하나만 입력하셔도 결제가 가능합니다.
                </div>
              </td>
            </tr>
            <tr>
              <th width=15%><strong>일반전화</strong></th>
              <td width=85%>
             <select name="tel1">
               <option value="-1" selected="selected">선택</option>
                   <option value="02">02</option>
                   <option value="031">031</option>
                   <option value="032">032</option>
                   <option value="070">070</option>                   
            </select>&nbsp;-&nbsp;
                 <input type='tel' name='tel2' size="2"/>&nbsp;-&nbsp; 
                <input type='tel' name='tel3' size="2"/>
           </td>
            </tr>          
          </table>
        </div>
<!-- 주문고객정보------------------------------------------------------------------ -->
        <div class="wrap_white_div">
          <div class="wrap_white">
          <h4 class="text-center">주문고객</h4>
          <hr>
          <table class="table_wh_addr" style="vertical-align: center;" >          
            <tr>
              <th width=23%>이름</th>
              <td><input type="text" id="username_pay" value="${uvo.name}" size="10" class="input_gray" readonly="readonly"> </td>
            </tr>
            <tr>
              <th>휴대폰</th>
              <td>
                <input type='tel' id="u_phone1" value="0${fn:substring(uvo.tel,0,2) }"  size="2" class="input_gray" readonly="readonly"/>&nbsp;-&nbsp;
                <input type='tel' id='u_phone2' value="${fn:substring(uvo.tel,2,6) }" size="2" class="input_gray" readonly="readonly"/>&nbsp;-&nbsp;
				<input type='tel' id='u_phone3' value="${fn:substring(uvo.tel,6,10) }" size="2" class="input_gray" readonly="readonly"/><br>
                <div class="caution">
                  <img class="caution_img" alt="SMS" src="../img/sms_2.PNG"><span class="caution">&nbsp;이 번호로 주문진행과정이 SMS로 안내됩니다.</span>
                </div>
              </td>              
            </tr>
            <tr>
              <th>일반전화</th>
              <td>
                <input type='tel' name="u_tel1" id="u_tel1_pay" size="2" class="input_gray" readonly="readonly"/>&nbsp;-&nbsp;
                <input type='tel' name='u_tel2' id="u_tel1_pay" size="2" class="input_gray" readonly="readonly"/>&nbsp;-&nbsp;
                <input type='tel' name='u_tel3' id="u_tel1_pay" size="2" class="input_gray"readonly="readonly"/>
              </td>
            </tr>
            <tr>
              <th>이메일</th>
              <td>
                <input type="email" name="u_email" id="u_email_pay"size="24"value="${uvo.email }"class="input_gray" readonly="readonly"/>
                <div class="caution">
                  <img class="caution_img" alt="SMS" src="../img/email.PNG"><span class="caution">&nbsp;이 이메일로 주문진행과정이 SMS로 안내됩니다.</span>
              	</div>
              </td>
            </tr>
            <!-- <tr><td><br></td></tr> -->
            <tr>
              <td colspan="2" align="right">
                <a href="#">회원정보 수정하러 가기</a>
              </td>
            </tr>            
          </table>      
        </div>
        </div>
      </div>
      </div> 
      
<!--결제방법------------------------------------------------------------------ -->    
      <div class="wrap_gray_div">
        <h2>결제방법</h2>
        <hr>
        <div class="wrap_gray">
        <!-- left------------------------------------------------------------------ -->
          <div class="wrap_gray_content" >        
            <table class="table_payment" style="width:100%;">
              <tr>
                <td colspan="2">
                  <button class="btn btn-default checkout-btn" value="credit-card">신용카드</button>             
                  <button class="btn btn-default checkout-btn" value="kakao-pay">카카오페이</button>             
                </td>
              </tr>               
            </table>
          </div>
            
        <!-- right--------------------------------------------------------------- -->
          <div class="wrap_white_div">
            <div class="wrap_white">
              <table>               
                <tr>
                  <th width="60%"><strong>최종 결제금액</strong></th>
                  <td style="font-size: 25px;text-align: right;">
                    <strong>
                      <fmt:formatNumber pattern="#,##0 원" value="${sum}"/>
                    </strong>
                    <input type="hidden" id = "tot-price" value = "${sum}">
                  </td>
                </tr>              
              </table>
              <button onclick="requestPay()" style="font-size:20px;height:50px;color:white;font-weight: bold;">결제하기</button>
            </div>
          </div><!-- 결제방법R 끝 --------------------------------------------- -->         
       </div> <!-- 결제방법L 끝 ----------------------------------------------- -->        
      </div><!--결제방법 끝---------------------------------------------------- -->      
  </div> <!-- Lrow 끝-->
  </div>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script type="text/javascript">
let books = '';
let qtys = '';
$('.book_id').each(function(){
	books += ',' + $(this).val();
})
$('.qty').each(function(){
	qtys += ',' + $(this).text();
})
console.log(books);
console.log(qtys);

IMP.init("imp14408257");
let pg = '';
let payMethod = '';

let today = new Date();
today = today.getFullYear() + '' + (today.getMonth()+1) + '' + today.getDate() + '' 
		+ today.getHours() + '' + today.getMinutes() + '' + today.getSeconds();
let merchantUid = $('#u_phone3').val() + today;

function requestPay() {
	let data = {
		pg: pg,
		pay_method: payMethod,
		merchant_uid: merchantUid,
		name: $('#username_pay').val() + "의 책 주문",
		amount: parseInt($('#tot-price').val()),
		buyer_email: $('#u_email_pay').val(),
		buyer_name: $('#username_pay').val(),
		buyer_tel: $('#u_phone1').val() + "-" + $('#u_phone2').val() + "-" + $('#u_phone3').val(),
		buyer_addr: $('#ship_address1').val() + "/" + $('#ship_address2').val(),
		buyer_postcode: $('#zipcode').val()
	};
	IMP.request_pay(data, function (rsp) {
    	if (rsp.success) {
        	postToUrl(JSON.stringify(data), books, qtys, "http://localhost:8080/FirstProject/pay/order_ok.do")
    	} else {
    		alert(rsp.error_msg);
        }
	});
}
$('.checkout-btn').click(function(){
	if($(this).val() == 'credit-card') {
		pg = 'html5_inicis.MID-a';
		payMethod = 'card';
	} else {
		pg = 'kakaopay';
		payMethod = 'kakaopay';
	}
})
function postToUrl(data, books, qtys, url) {
	let form = document.createElement('form');
		
	let obj1;
	obj1 = document.createElement('input');
	obj1.setAttribute('type', 'hidden');
	obj1.setAttribute('name', 'payInfo');
	obj1.setAttribute('value', data);
	
	let obj2;
	obj2 = document.createElement('input');
	obj2.setAttribute('type', 'hidden');
	obj2.setAttribute('name', 'books');
	obj2.setAttribute('value', books);
	
	let obj3;
	obj3 = document.createElement('input');
	obj3.setAttribute('type', 'hidden');
	obj3.setAttribute('name', 'qtys');
	obj3.setAttribute('value', qtys);

	form.appendChild(obj1);
	form.appendChild(obj2);
	form.appendChild(obj3);

	form.setAttribute('method', 'post');
	form.setAttribute('action', url);
	
	document.body.appendChild(form);
	
	form.submit();
}
</script>
</body>
</html>