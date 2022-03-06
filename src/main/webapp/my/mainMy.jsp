<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
 <!--#6699cc #72a4d9  #112444  #dfdfdf  #fda4ba-->
<style type="text/css">
.container{
	margin-top:50px;
	margin-bottom:50px;
	font-family: '맑은 고딕','Malgun Gothic',Helvetica,AppleSDGothicNeo,sans-serif;
	
}
.wrap_left{
	float:left;
	width:20%;	
}
.wrap_right{
  	float:right;
  	width:60%; /*77*/
  	
}
.color_sky{
	color:#B8F8FB;
	font-weight: bold;
}
.color_wh{
	color:white;
	font-wight: bold;
}
/* .color_pink{
	background-color: #fda4ba;
	color:white;
	font-weight: bold;
} */
.bg_color_navy{
	background-color: #165fa1;
	color:white;
	font-weight: bold;
}
.bg_color_Lgray{
	background-color: #f3f3f3;
}
.color_Mgray{
	color:#999999;
}

.color_sky_point{
	color:#3A85C7;
	font-wight: bold;
}
.path_oh>h3>span>a{
	color:gray;
	font-weight: bold;
	font-size:13px;
}
.path_oh>h3>span>a :hover{
	color:#B8F8FB;
	font-weight: bold;
	font-size:13px;
	cursor: pointer;
}
.radiaus{
	 border-radius: 8px;
	 border: 2px solid #6699cc;	 
}
.menu{	
	padding:10px;
}
.menu_block>dt{
	color:#3A85C7;
}
.menu_block ul{
	padding-top:5px;
	padding-bottom:5px;
	color:#555555;
}
ul{
	list-style: none;
	padding-left: 10px;;
}
select{
	margin: 0;
	padding: 0;
	font-size: 12px;
	vertical-align: middle;	
}
.menu_li>a{
	color:#555555;
}
.menu_li>a:hover{
	color:#6699cc;
	font-weight: bold;
}
hr{
	color: #dedede;    /* IE */
    border-color: #dedede;  /* 사파리 */
    background-color: #dedede;   /* 크롬, 모질라 등, 기타 브라우저 */
}
.floating {	
    position: absolute;
    margin: 0px auto;
    width:9%;
    height:500px;
    margin-left:2px;
    right: 20px;
    box-shadow: 5px 5px 5px 5px #dfdfdf;
}
/*color:하늘 #59c6d5 #B8F8FB / 포인트색: #3A85C7 , #579fd3 옅은블랙: #555555 연그레이:#ABABAB dedede 999999*/
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script> 
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

$(document).ready(function () {
	   let tmp = parseInt($(".floating").css('top'));
	 
	     $(window).scroll(function () {
	         let scrollTop = $(window).scrollTop();
	         let floating_position = scrollTop + tmp + "px";
	 
	          $(".floating").stop().animate({"top": floating_position }, 500);
	 
	     }).scroll();
	});
	
</script>
</head>
<body>
<div class="container">
  <div class="container">
   <main class="clear">
     <div class="path_oh">
       <h3 style="color: gray;">${pageName }&nbsp;&nbsp;&nbsp;&nbsp;
         <span style="font-size:13px;"><a>Home</a> > <a>마이페이지</a> > <a href="#">${pageName }</a></span> 
       </h3>
       <hr>
     </div>
     
     <div class="wrap_left"> 
        <div class="">
          <div class="menu radiaus">
            <d1 class="menu_block">
              <dt style="padding-left:3px;">아이디&nbsp;&nbsp;<span>일반회원</span></dt>
              <table>
                <tr>
                  <td colspan="2">
                  <img src="../img/oh_id1.PNG" style="width:100%;height: 100%">
                  </td>
                </tr>
                <tr>
                  <td style="width:20%">
                    <img src="../img/oh_id2.PNG" style="width:100%;height: 100%;padding-top:0px;padding-right:2px;">
                  </td>
                  <td>
                    3개월간 순수 주문금액이<br>
                    10만원 이상일 경우<br>
					다음달 1일, 로얄 회원<br>
					등급이 됩니다. <a href="#">&nbsp;더보기 ></a>
                  </td>
                </tr>
              </table>
            </d1>
          </div>
          <br>
          <div class="menu radiaus">
	       <dl class="menu_block">
	          <dt>주문내역</dt>
	          <dd>
	            <ul class="menu_ul">
	              <li class="menu_li">
	                <a href="#">주문내역/배송조회</a>
	              </li>
	              <li class="menu_li">
	                <a href="#">취소 주문내역</a>
	              </li>
	              <li class="menu_li">
	                <a href="#">세금계산서</a>
	              </li>
	            </ul>
	          </dd>
	       </dl>
	       <hr>
	       <dl class="menu_block">
	          <dt>계좌내역</dt>
	          <dd>
	            <ul class="menu_ul">
	              <li class="menu_li">
	                <a href="#">쌍용포인트</a>
	              </li>
	              <li class="menu_li">
	                <a href="#">쌍용쿠폰</a>
	              </li>
	              <li class="menu_li">
	                <a href="#">쌍용상품권</a>
	              </li>
	            </ul>
	          </dd>
	       </dl>
	       <hr>
	       <dl class="menu_block">
	          <dt>찜한 도서</dt>
	          <dd>
	            <ul class="menu_ul">
	              <li class="">
	                <a href="#">test</a>
	              </li>
	              <li class="menu_li">
	                <a href="#">test</a>
	              </li>
	              <li class="menu_li">
	                <a href="#">test</a>
	              </li>
	            </ul>
	          </dd>
	       </dl>
	       <hr>
	       <dl class="menu_block">
	          <dt>장바구니</dt>
	          <dd>
	            <ul class="menu_ul">
	              <li class="menu_li">
	                <a href="#">test</a>
	              </li>
	              <li class="menu_li">
	                <a href="#">test</a>
	              </li>
	              <li class="menu_li">
	                <a href="#">test</a>
	              </li>
	            </ul>
	          </dd>
	       </dl>
	       <hr>
	       <dl class="menu_block">
	          <dt>회원정보 관리</dt>
	          <dd>
	            <ul class="menu_ul">
	              <li class="menu_li">
	                <a href="#">회원정보 수정</a>
	              </li>
	              <li class="menu_li">
	                <a href="#">회원탈퇴</a>
	              </li>
	              <li class="menu_li">
	                <a href="#">test</a>
	              </li>
	            </ul>
	          </dd>
	       </dl>
	     </div>
	   </div>	        
     </div>      
<!-- right--------------------------------------------------------------------- -->      
     <div class="wrap_right" style="height: 650px"> 
       <jsp:include page="${mainMy_jsp }"/>
     </div>
<!-- -------------------------------------------------------------------------- -->   
    </main>
    <div class="floating">
       <img src="../img/floating2_pay.PNG" style="width: 100%;height: 100%;">
    </div>   
   </div>
   
  </div>  
</body>
</html>