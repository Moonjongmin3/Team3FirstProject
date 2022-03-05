<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
.container{
  margin:0px auto;
  vertical-align: center;
  border:8px solid;
  border-color:#72a4d9;
  width:600px;
  height:540px;
  

}
.row {
   margin:0px 100px;
   width:400px;
   
}
h1{
    text-align: center;
}
input[type=button]{
   align:center;
    border-radius:15px;
    border:none;
   width:150px;
   height:50px;
   box-shadow: 5px 5px 5px 5px #dfdfdf;
   font-size:18px;
   font-weight: bold;
   margin: 20px 5px;
}
input[type=button]:hover{
   background-color:#fda4ba;
   color:white;
   
}
td{
   text-align: center;
   font-size:18px;
   
}

</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
</head>
<body>
   <div class="container">
     <div class="row" >
       
       <table class="tbl">     
         <tr>
           <img src="../img/order_complete.PNG" >
         </tr>    
         <tr>
           <td style="font-size:25px;text-align:center;font-weight:bold"><strong>주문완료!<br></strong></td>
         </tr>
         <tr>
           <td style="color:#72a4d9;"><strong>주문번호:</strong>${oder_id } </td>
         </tr>
         <tr>
           <td class="font-center" style="color:gray;font-size:18px;text-align:center;">"예쁘게 포장해서 보내드릴게요 !<br>조금만 기다려요 <strong>:)</strong></td>
         </tr>
         <tr>
           <td>
           <input class="inline" type="button" value="주문 상세보기" />
           <input class="inline" type="button" value="메인으로 이동" />
           </td>
         </tr>
       </table>
    </div>
   </div>
   

</body>
</html>