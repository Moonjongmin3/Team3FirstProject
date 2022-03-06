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
  	width:77%;
  	
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
/*color:하늘 #59c6d5 #B8F8FB / 포인트색: #3A85C7 , #579fd3 옅은블랙: #555555 연그레이:#ABABAB dedede 999999*/
</style>
</head>
<body>

<!-- right--------------------------------------------------------------------- -->      
      
        <h2 class="color_sky_point">주문/배송 조회</h2>
        <table class="table">
         <tr>
          <td>
           <strong>주문한 상품의 배송상태를 확인할 수 있습니다. 언제나 빠른 발송,배송이 가능하도록 노력하겠습니다!<br>
           <span class="color_sky_point">아래의 주문번호를 클릭하시면, 자세히 볼 수 있습니다 :)</span></strong>
          </td>
         </tr>
        </table>
        <!-- 기간 검색 조회 구현 예정--> 
        <table class="table">
	      <tr class="bg_color_Lgray">
	        <th><input type="checkbox"></th>
	        <th width=10% class="text-center color_Mgray">주문번호</th>
	        <th width=45% class="text-center color_Mgray">상품명</th>
	        <th width=15% class="text-center color_Mgray">결제금액</th>
	        <th width=20% class="text-center color_Mgray">주문일</th>
	        <th width=10% class="text-center color_Mgray">주문상태</th>
	      </tr>
	      <c:forEach var="vo" items="${list }">
	       <tr>
	        <td width=10% class="text-center">${vo.order_id }</td>
	        <%-- .do =>Model --%>
	        <td width=45%><a href="../.do?no=${vo.no }">${vo.name }</a></td>
	        <td width=15% class="text-center">${vo.total_price }</td>
	        <td width=20% class="text-center">
	          <fmt:formatDate value="${vo.order_date }" pattern="yyyy-MM-dd"/>
	        </td>
	        <td width=10% class="text-center">${vo.state }</td>
	       </tr>
	      </c:forEach>
	    </table>
	    <table class="table">
	      <tr>
	       <td class="text-center">
	        <a href="../my/orderHistory.do?page=${curpage>1?curpage-1:curpage }" class="btn btn-sm bg_color_navy" style="box-shadow: 2px 2px 2px 2px #dfdfdf">이전</a>
	         &nbsp;${curpage } page / ${totalpage } pages&nbsp;
	        <a href="../my/orderHistory.do?page=${curpage<totalpage?curpage+1:curpage }" class="btn btn-sm bg_color_navy"style="box-shadow: 2px 2px 2px 2px #dfdfdf">다음</a>
	       </td>
	      </tr>
	    </table>
      

</body>
</html>