<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<script src="http://code.jquery.com/jquery.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
<script>
 $(function(){
    $("#tabs").tabs();
    
    $('#telBtn').on('click',function(){
    	let tel=$('#tel').val(); // 사용자 입력값을 얻어 온다 
    	if(tel.trim()=="")
    	{
    		$('#tel').focus();
    		$('#tel_find').text("전화번호를 입력하세요")
    		return;
    	}
    	// idfind.jsp에서 요청/응답을 동시에 처리 
    	$.ajax({
    		type:'post',
    		url:'../member/idfind_result.do',
    		data:{"tel":tel},
    		success:function(res) // res가 정상수행시 데이터 읽기 
    		{
    			let t=res.trim();
    			if(t=='no')
    			{
    				$('#tel_find').text('전화번호가 존재하지 않습니다!!')
    				// 전화 번호가 없는 상태
    			}
    			else
    			{
    				$('#tel_find').text(t);
    				// 전화번호로 아이디를 찾은 경우 
    			}
    			
    		}
    	})
    })
    $('#emailBtn').click(function(){
    	let email=$('#email').val();
    	if(email.trim()=="")
    	{
    		$('#email').focus();
    		$('#email_find').text("이메일을 입력하세요!!");
    		return;
    	}

    	$.ajax({
    		type:'post',
    		url:'../member/email_result.do',
    		data:{"email":email},
    		success:function(res)
    		{
    			let r=res.trim();
    			if(r=="no")
    			{
    				$('#email_find').text("이메일이 존재하지 않습니다!!");
    			}
    			else
    			{
    				$('#email_find').text(r);
    			}
    		}
    	})
    })
 });
  </script>
 <script type="text/javascript">
 function pw_search(){

	  var frm=document.pwfindscreentel;

	  if(frm.member_pwd_id.value.length<1){
	   alert("아이디를 올바르게 입력해주세요");
	   return;
	  }

	   if (frm.member_pwd_tel.value.length <1) {
				  alert("핸드폰번호를 입력해주세요");
				  return;
			 }
		
	  frm.method="post";
	  frm.action="pwdfind_result.do"; //넘어간화면
	  frm.submit(); //등록이 될수 있는 조건이면, 정보를 보내겠다.
	  }
 function pw_search1(){

	  var frm=document.pwfindscreentel;

	  if(frm.member_pwd_id1.value.length<1){
	   alert("아이디를 올바르게 입력해주세요");
	   return;
	  }

	   if (frm.member_pwd_email.value.length <1) {
				  alert("이메일 주소를 입력해주세요");
				  return;
			 }
		
	  frm.method="post";
	  frm.action="pwdfind_result.do"; //넘어간화면
	  frm.submit(); //등록이 될수 있는 조건이면, 정보를 보내겠다.
	  }
 </script>
</head>
<body>
  <div class="wrapper row3">
  <div id="breadcrumb" class="clear"> 
    <!-- ################################################################################################ -->
    <ul>
      <li></li>
    </ul>
    <!-- ################################################################################################ --> 
   </div>
  </div>
  <div class="wrapper row3">
   <div style="height:650px">
	   <main class="container clear">
	    <h2 class="sectiontitle">비밀번호 찾기</h2>
	    <div id="tabs">
		  <ul>
		    <li><a href="#tabs-1">전화번호</a></li>
		    <li><a href="#tabs-2">이메일</a></li>
		  </ul>
		  <div id="tabs-1">
						<form name="pwfindscreentel" method="POST">
							<div class="search-title">
								<h3>등록한 정보로 인증</h3>
							</div>
							<section class="form-search">
								<div class="find-id">
									<label>아이디:</label> <input type="text" name="member_pwd_id"
										class="btn-name" placeholder="ID를 입력하세요."> <br>
								</div>

								<div class="find-tel">
									<label>번   호 :</label> <input type="text" onKeyup="addHypen(this);"
										name="member_pwd_tel" class="btn-phone"
										placeholder="휴대폰번호를 '-'없이 입력">
								</div>
								<br>
							</section>
							<div class="btnSearch">
								<input type="button" name="enter" value="찾기" class="btn btn-sm btn-primary" onClick="pw_search()"> 
								<input type="button" name="cancle" value="취소" class="btn btn-sm btn-danger" onClick="history.back()">
							</div>
						</form>
						<p id="tel_find" style="font-size: 15pt;color:red"></p>
		  </div>
		  <div id="tabs-2">
						<form name="pwfindscreenemail" method="POST">
							<div class="search-title">
								<h3>등록한 정보로 인증</h3>
							</div>
							<section class="form-search">
								<div class="find-id">
									<label>아이디 :</label> <input type="text" name="member_pwd_id1"
										class="btn-name" placeholder="ID를 입력하세요."> <br>
								</div>

								<div class="find-tel">
									<label>이메일 :</label> <input type="text" onKeyup="addHypen(this);"
										name="member_pwd_email" class="btn-phone"
										placeholder="이메일을 입력하세요">
								</div>
								<br>
							</section>
							<div class="btnSearch">
								<input type="button" name="enter" value="찾기"
									class="btn btn-sm btn-primary" onClick="pw_search()"> <input
									type="button" name="cancle" value="취소"
									class="btn btn-sm btn-danger" onClick="history.back()">
							</div>
						</form>
					</div>
	   </main>
   </div>
  </div>
</body>
</html>