<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%--price -> "#,##0원" --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 
   private int id;
    private String name;
    private String img;
    private int price;
    private int quantity;
    private String contentId;
    private String author;
    private String publisher;
    private String description;
    private int saleRate;
    private int score;
    private String isbn;
    private String bsize;
    private String state;
    private String tag;
    private String mainCategory;
    private String subCategory;
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

 <!-- #72a4d9  #112444-->
<style type="text/css">
.container{
  margin-top: 50px;
  margin-bottom:50px;
}
.Lrow {
   margin: 0px auto;
   width:80%;
   float:left;  
}
.wrap_gray_div{
   width:100%;
   margin-top:70px;
}
.wrap_gray{
   background-color: #f6f6f6;
   display:flex;
   border-radius: 15px;
}
.wrap_gray_content{
   padding:30px 20px;
   float:left;
   flex:6;
}
.wrap_white_div{
   width:100%;
   float:right;
   flex:4;
   padding:18px;
}
.wrap_white{
   background-color: white;
   padding:12px;
   width: 100%;
   height:100%;
   border-radius: 15px;
}
.table_oi{
box-shadow: 0px 1px #dfdfdf;
}

h2{
    text-align: left;
    /* color: #72a4d9; */   
    font-weight: bold;     
}
td,th{
   padding-bottom:10px;
}
.tr_dot{
   border-bottom:thin dotted;
}
.tr_sol{
   border-bottom:thin solid #dedede;
}
.table_oi>thead>tr>th{
   text-align: center;
   background-color: #72a4d9;
   color:white;   
}
.table_oi>thead>tr>th:first-child, 
.table_oi>thead>tr>td:first-child {
    border-left: none;   
    border-right:none; 
}
.caution{
   font-size:10px;
   padding-top:10px;
}

.caution_ul{
   list-style: none;
   padding-left:0px
}

div>div>div>.table_oi>tbody>tr>td:not(.title_oi,.img_oi){
   
   vertical-align:middle;    
    text-align: center;
    line-height: 1.4;
    
}
div>div>div>.table_oi>tbody>tr>td{
   border-bottom: 1px solid;
   border-bottom-color: #f6f6f6; 
}

input[type=checkbox],input[type=radio]{
   cursor: pointer;
}
input[type=text], input[type=tel] , input[type=email]{   
     height: 32px;
    border: 0;
    border-radius: 10px;
     outline: none;
    padding-left: 10px;
   background-color: white;
   box-shadow: 1px 1px gray;
}
.input_gray[type=text], .input_gray[type=tel] , .input_gray[type=email]{   
     height: 32px;
    border: 0;
    border-radius: 10px;
     outline: none;
    padding-left: 10px;
   background-color: #f6f6f6;
   box-shadow: 1px 1px gray;
}

.radio-input input[type="radio"]{
   cursor:pointer;
}
.box-radio-input input[type="radio"]{
   display:none;
}
.box-radio-input input[type="radio"] +span{
  display:inline-block;
  background:none;
  border:1px solid #dfdfdf;  
  padding:0px 10px;
  text-align:center;
  height:40px;
  line-height:33px;
  font-weight:500;
  cursor:pointer;
  border-radius: 15px;
}
.box-radio-input input[type="radio"]:checked +span{
  border:1px solid;
  background:#72a4d9;
  color:white;
  border-radius: 15px;
  font-weight: bold;
  
}
.button_pay{
   background-color:#72a4d9; 
   align:center;
   border-radius:15px;
   border:none; 
   width:100%;
   height:50px
}
.button_pay>span{
   font-size:25px;
   color:white;
   font-weight:bold;
   border:1px;
}
.Rrow:not(button){
   padding:10px;
   border-radius: 15px;
    position: absolute;
   margin: 0px auto;
    width:18%;
    background-color: #fda4ba;
    color:white;
    margin-left:2px;
    right: 50px;
    box-shadow: 5px 5px 5px 5px #dfdfdf;
} 


</style>
<link rel="stylesheet" href="shadow/css/shadowbox.css">
<script type="text/javascript" src="shadow/js/shadowbox.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script> 
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(document).ready(function () {
   let tmp = parseInt($(".Rrow").css('top'));
 
     $(window).scroll(function () {
         let scrollTop = $(window).scrollTop();
         let Rrow_position = scrollTop + tmp + "px";
 
          $(".Rrow").stop().animate({"top": Rrow_position }, 500);
 
     }).scroll();
});

//수정 필요
/* $(function(){
Shadowbox.init({   
})
$('.payBtn').click(function(){      
    Shadowbox.open({
       content:'order_complete.jsp',
       player:'iframe',
       title:'주문완료',
       width:600,
       height:540
    })
})
}) */

$(function(){   
   <%-- 주소찾기 --%>
      $('#postBtn_pay').click(function(){
      //alert("Post")
      new daum.Postcode({
         oncomplete:function(data)
         {
            $('#post_pay').val(data.zonecode)
            $('#addr1_pay').val(data.address)
         }
      }).open()
      })
      
      //
   
})


//주문상품 판매가,할인가,합계 계산
function total(){
   var price=$("#price").val();//정가
   var saleRate=10;//할인율
   var qty=$("#qty").val();//주문 수량
   
    var discount=price*(salerate/100);//할인금액
    var sellingPrice=price-discount; // 판매금액 (사용point 제외)
    var bTotal=sellingPrice*qty;//총합계(할인적용O)
    var disTotal=price*qty;//총합계(할인적용X)
   // var total+=bTotal//list total
    $("#disTotal").val(disTotal);
    $("#sellingPrice").val(sellingPrice);
    $(".discount").val(discount);
    $(".bTotal").val(bTotal);   
}
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
            <tr>
             <td class="img_oi"><img alt="poster" src="${poster }" width="120px" height="150px"></td>
              <td class="title_oi" style="padding-top:20px"><a href="#">[ ${ mainCategory} ] ${title }</a><br>${author }</td>
              <td><fmt:formatNumber pattern="#,##0 원" id="price" value="${price}"/><br>
                (<span>${saleRate }%</span><img src="../img/arrow.PNG" style="height: 15px;width: 15px;">)<br>
                <img src="../img/point.PNG" style="height: 15px;width: 15px;"><fmt:formatNumber pattern="#,##0"  value="${point}"/>
              </td>
              <td><fmt:formatNumber pattern="#,##0 원"  id="sellingPrice" value="${sellingPrice}"/></td>
              <td id="#qty">${qty}</td>
              <td><fmt:formatNumber pattern="#,##0 원" class="bTotal" value=""/></td><!--책 개별 합계 -->
              <td><fmt:formatDate value ="${diliveryDate}" pattern ="MM/dd" var="now"/><br>도착예정</td>
            </tr>
            <!-- <tr> ....위치 고민중.....
            <td colspan="7"><img alt="" src="../img/caution.PNG" style="height: 20px;width: 20px;"> 
              날씨나 택배사 사정에 따라 배송이 지연될 수 있습니다.</td>
            </tr>  -->
          </tbody>
        </table>
        <ul class="caution_ul">
          <li><img alt="" src="../img/caution.PNG" style="height: 20px;width: 20px;"> 
              날씨나 택배사 사정에 따라 배송이 지연될 수 있습니다.</li>        
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
            <!-- <input type="radio" name="chk_info" value="recent">최근배송지 -->
              </td>
            </tr>
            <tr>
              <th width=15%><strong>이름</strong></th>
              <td width=85%><input type="text" name="name_addr" value="${userName }" size="10"> </td><!-- user.name -->
            </tr>
            <tr>
              <th width=15%><strong>배송주소</strong></th>
              <td width=85%>
                <input type="text" id="post_pay" value="${userAddr1 }" readonly="readonly" size="10"style="margin-bottom:8px;">&nbsp;&nbsp;<input type="button" id="postBtn_pay" value="주소찾기"><br>
                도로명 주소<input type="text" id="addr1_pay" value="${userAddr2 }" readonly="readonly" size="35"style=";margin-bottom:8px;"><br>
                상세 주소<input type="text" id="addr2_pay" size="35" style="margin-left:14px;margin-bottom:8px;"><br>                
                <ul class="caution_ul">
                  <li style="font-size: 10px">
                    <img alt="!!" src="../img/caution_sm.PNG" style="height: 9px;width: 9px;"> 
                     주소/우편번호 체계가 새롭게 변경되었습니다.<br>
                    정확하고 빠른 배송을 위해 입력된 주소를 확인 해주시기 바랍니다.
                  </li>
                </ul>     
              </td>
            </tr>
            <tr>
              <th width=15%><strong>휴대폰</strong></th>
              <td width=85%>
                <select name="phone1" value="${fn:substring(userPhone,0,3) }" id="phone1_pay">
               <option value="010" selected="selected">010</option>
                   <option value="011">011</option>
                   <option value="016">016</option>
                   <option value="017">017</option>
                   <option value="018">018</option>
                   <option value="019">019</option>
            </select>&nbsp;-&nbsp;
                 <input type='tel' name='phone2' value="${fn:substring(userPhone,3,7) }" size="2" id="phone2_pay"/>&nbsp;-&nbsp;
                <input type='tel' name='phone3' value="${fn:substring(userPhone,7,11) }" size="2" id="phone3_pay"/><br>
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
              <td><input type="text" name="username_pay" value="${userName }" size="10" class="input_gray" readonly="readonly"> </td>
            </tr>
            <tr>
              <th>휴대폰</th>
              <td>
                <input type='tel' name="u_phone1" value="${fn:substring(userPhone,0,3) }" id="u_phone1_pay" size="2" class="input_gray" readonly="readonly"/>&nbsp;-&nbsp;
                <input type='tel' name='u_phone2' value="${fn:substring(userPhone,3,7) }" id="u_phone1_pay" size="2" class="input_gray" readonly="readonly"/>&nbsp;-&nbsp;
                <input type='tel' name='u_phone3' value="${fn:substring(userPhone,7,11) }" id="u_phone1_pay" size="2" class="input_gray" readonly="readonly"/><br>
                <img alt="SMS" src="../img/sms.PNG"><p class="caution">이 번호로 주문진행과정이 SMS로 안내됩니다.</p>
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
                <input type="email" name="u_email" id="u_email_pay"size="24"value="${userEmail }"class="input_gray" readonly="readonly"/>
              </td>
            </tr>
            <!-- <tr><td><br></td></tr>공백용 .. 수정예정!! -->
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
                  <label class="box-radio-input"><input type="radio" id="without_BK" name="payment_mtd" value="bkX" 
                     class="rdbtn"><span class="mtd" checked="checked">무통장입금</span>
                  </label>
                  <label class="box-radio-input">
                    <input type="radio" id="cc" name="payment_mtd" value="cc" 
                      class="rdbtn" ><span class="mtd">신용카드</span>
                  </label>
                  <label class="box-radio-input">
                    <input type="radio" id="phone" name="payment_mtd" value="phone" 
                      class="rdbtn"><span class="mtd">휴대폰</span>
                  </label>                  
                </td>
              </tr> 
              <tr>
                <th width="15%">입금은행</th>
                <td>
                  <select>
                    <option name="bank" value="n" size="10" selected>입금하실 은행을 선택하세요.</option>
                    <option name="bank" value="우리은행">우리은행</option>
                    <option name="bank" value="국민은행">국민은행</option>
                    <option name="bank" value="신한은행">신한은행</option>
                  </select>
                </td>
              </tr>
              <tr class="tr_sol">
                <th>입금자</th>
                <td>
                  <input type="text" size="10"/>
                </td>
              </tr>               
            </table>
            <hr>
            <table>
              <tr class="tr_sol">
                <th width="20%">무통장입금<br><span class="text-center">안내</span></th>
                <td fontsize="10">
                  <ul>
                    <li padding="0px">정확한 주문 금액(원 단위까지) 입금 요망</li>
                    <li>주문 완료 후 7일 이내에 미입금시 주문 자동 취소</li>
                    <li>입금 완료 시점 기준 배송 일정이 최종 확정되며, 재고 상황에 따라 품절 및 지연될 수 있음</li>
                    <li>증권사 현금카드, 제휴카드 이체 불가</li>
                    <li>은행업무 시간이 아닌 경우 입금 확인이 지연될 수 있음(토요일, 공휴일 등)</li>
                    <li>은행 수수료 부과 및 예약이체(불가) 주의</li>
                    <li>해외송금 시 국민은행 가상계좌이용불가</li>                    
                  </ul>
                </td>
              </tr>
            </table>
            <hr>
            <table>
              <tr >
                <th rowspan="4" width="25%">문화비소득공제<br>현금영수증신청   </th>
                <td>
              <label><input type="radio" name="deduction" value="true" >&nbsp;신청 </label>&nbsp;&nbsp;
                  <label><input type="radio" name="deduction" value="false">&nbsp;신청안함</label>
                </td>
              </tr>
              <tr> 
                <td font-size="10px">
                  현금성 결제 수단사용 시 문화비소득공제를 신청하시면 현금영수증은 자동 발행됩니다.<br>
              문화비소득공제 미 신청 주문은 마이페이지에서 현금영수증으로 발행가능합니다.
                </td>
              <tr>
            </table>
          </div>
            
        <!-- right--------------------------------------------------------------- -->
          <div class="wrap_white_div">
            <div class="wrap_white">
              <table table="table_pay" style="margin-top:20px; margin-bottom:15px;">
                <tr>
                  <th width=30%><strong>선물포장</strong></th>
                  <td>
                    <label>
                      <input type="radio" name="gift_wrapping" value="false" checked="checked"/>&nbsp;안함
                    </label>
                    <label>
                      <input type="radio" name="gift_wrapping" value="true"/>&nbsp;요청
                    </label><span style="font-size:10px">(1,000원 추가)</span>
                  </td>
                </tr>
                <tr>
                  <th width=25%><strong>영수증</strong></th>
                  <td>
                    <label>
                      <input type="radio" name="receipt" value="false" checked="checked"/>&nbsp;가격표시
                    </label>
                    <label>
                      <input type="radio" name="receipt" value="true"/>&nbsp;가격표시 안함
                    </label>
                  </td>
                </tr>
                <tr>
                  <th width=25%><strong>택배사<br>직원에게</strong></th>
                  <td>
                    <input type="text" class="input_gray" size="25"/><br>
                    <div class="caution">택배회사 송장에 출력되는 메시지
                  </td>
                </tr>
                <tr>
                  <th width=25%><strong>받는분께<br>메세지</strong></th>
                  <td>
                    <input type="text" size="25" style="background-color:#f6f6f6"/><br>
                    <div class="caution">영수증 상단에 출력<br>(공백포함 36자 제한)
                  </td>
                </tr>
              </table>
              <table>
                <tr>
                  <th width="60%"><strong>최종 결제금액</strong></th>
                  <td style="font-size: 25px;text-align: right;">
                    <strong>
                      <fmt:formatNumber pattern="#,##0 원"  value="${price_var}"/>
                    </strong>
                  </td>
                </tr>
              </table>
              <hr>
              <p>주문하실 상품, 가격, 배송정보, 할인정보 등을 확인하였으며, 구매에 동의하시겠습니까?</p>
              <p>
                <label><input type="checkbox" value="true"/>&nbsp;동의합니다.</label>
                <sapn class="caution">(전자상거래법 제 8조 제2항)</sapn>
              </p>
              <br>
              <p>
                <button type="button" class="button_pay payBtn" >
                  <span>결제하기</span>
                </button>
              </p>
            </div>
          </div><!-- 결제방법R 끝 --------------------------------------------- -->         
       </div> <!-- 결제방법L 끝 ----------------------------------------------- -->        
      </div><!--결제방법 끝---------------------------------------------------- -->      
  </div> <!-- Lrow 끝-->
<!--결제 플로팅 ------------------------------------------------------------------- -->
    <div class="Rrow" >
      <h3 class="text-center tr_sol" style="padding-bottom:15px;font-weight: bold; border-color:white;">
        결제예정금액
      </h3>
      <table class="table_f">
          <tr >
            <th width=40%><strong>상품가격</strong></th>
            <td><fmt:formatNumber pattern="#,##0 원" id="disTotal"/></td>
          </tr>
          <tr class="tr_dot">
            <th><strong>할인금액</strong></th>
            <td><fmt:formatNumber pattern="#,##0 원" class="discount"/></td><!--(${Price}*${saleRate })+${usePoint} .. UserVO에 point가 없어서 일단  -->
          </tr>
          <tr>
            <th colspan="2" style="padding-top:10px;" ><strong>총 결제 금액</strong></th> 
          </tr>
          <tr>
            <td colspan="2" style="text-align:right; font-size:30px;"><fmt:formatNumber pattern="#,##0 원"  class="bTotal"/></td>
          </tr> 
          <tr>
            <td colspan="2" style="font-size:18px"><label><input type="checkbox"/><strong>&nbsp;구매 및 이용약관 모두 동의</strong></label></td>
          </tr>
          <tr><br></tr>         
      </table>
      <button type="button" class="payBtn" style="background-color:white;align:center;font-size:20px;border-radius:15px;border:none; width:100%;height:50px"><span style="color:#fda4ba;font-weight: bold;">결제하기</span></button>
    </div><!-- Rrow ------------------------------------------------------------>
  </div> <!-- container -->

</body>
</html>