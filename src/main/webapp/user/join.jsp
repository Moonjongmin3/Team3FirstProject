<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="../shadow/css/shadowbox.css">
<link rel="stylesheet" href="../css/join.css">
<script type="text/javascript" src="../shadow/js/shadowbox.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <link rel="stylesheet" href="../css/join.css">
<script type="text/javascript">
Shadowbox.init({
	players:['iframe']
})
$(function(){

	$('#checkBtn').click(function(){
		// 아이디 중복체크 처리 
		Shadowbox.open({
			content:'../user/idcheck.do',
			player:'iframe',
			title:'아이디 중복체크',
			width:420,
			height:250
		})
	})

	$('#postBtn').click(function(){
		// 우편번호 검색
		new daum.Postcode({
			oncomplete:function(data)
			{
				$('#post').val(data.zonecode)
				$('#address1').val(data.address)
			}
		}).open()
	})
	$('#joinBtn').click(function(){
		// 회원 가입 처리 (유효성 검사)  
		// id 
		let id=$('#join_id').val();
		if(id.trim()=="")
		{
			alert("중복체크 버튼을 클릭하세요")
			return;
		}
		
		let pwd=$('#join_pwd').val()
		if(pwd.trim()=="")
		{
			$('#join_pwd').focus();
			return;
		}
		let pwd1=$('#pwd1').val()
		if(pwd1!=pwd) 
		{
		    alert("비밀번호가 틀립니다!!\n다시 입력하세요")
		    $('#pwd1').focus();
		    return;
		}
		let name=$('#name').val()
		if(name.trim()=="")
		{
			$('#name').focus();
			return;
		}
		let day=$('#day').val()
		if(day.trim()=="")
		{
			alert("생년월일을 입력하세요!!") //
			return;
		}
		let post=$('#post').val()
		if(post.trim()=="")
		{
			alert("우편번호를 검색하세요")
			return;
		}
		let tel2=$('#tel2').val()
		if(tel2.trim()=="")
		{
			$('#tel2').focus()
			return;
		}
		let tel4=$('#tel4').val()
		if(tel4.trim()=="")
		{
			$('#tel4').focus()
			return;
		}
		let cont=$('#content').val()
		if(cont.trim()=="")
		{
			$('#content').focus()
			return;
		}
		
		$('#join_frm').submit()
		
	})
})
</script>
</head>
<body>
<div class="wrapper row3">
 <section id="joinwrap">
 <div id="breadcrumb" class="clear"> 

  <div id="login">
   <h3 id="log1" class="text-center" >
    <img src="../img/logo.png" alt="쌍용Books 로고" width="300px">
   </h3>
	<p id="log2" class="text-center"><strong>WELCOME&#33;</strong>&nbsp쌍용BOOKS에 오신것을 환영합니다.</p>
  <div class="wrapper row3">
   <main class="container clear" style="width:80%">
   <form method="post" action="../user/join_ok.do" name="join_frm" id="join_frm">
    <table class="table">
    <div class="exform_txt" align="right">
    <span>* 표시는 필수적으로 입력해주셔야 가입이 가능합니다.</span>
    </div>
      <tr>
       <td class="text-right" width=15%>아이디 *</td>
       <td width=85% class="inline">
         <input type=text name=id id="join_id" size=15 class="input-sm" readonly>
         <input type=button id="checkBtn" value="아이디중복체크" class="btn btn-sm btn-primary">
       </td>
      </tr>
      <tr>
       <td class="text-right" width=15%>비밀번호 *</td>
       <td width=85% class="inline">
         <input type=password name=pwd id=join_pwd size=15 class="input-sm">
         &nbsp;&nbsp;비밀번호 확인*:
         <input type=password name=pwd1 id=pwd1 size=15 class="input-sm">
       </td>
      </tr>
      <tr>
       <td class="text-right" width=15%>이름 *</td>
       <td width=85%>
         <input type=text name=name id=name size=15 class="input-sm">
       </td>
      </tr>
      <tr>
       <td class="text-right" width=15%>성별 *</td>
       <td width=85% class="inline">
         <input type=radio value="남자" name=gender checked="checked">남자
         <input type=radio value="남자" name=gender>여자
       </td>
      </tr>
      <tr>
       <td class="text-right" width=15%>생년월일 *</td>
       <td width=85%>
         <input type=date size=20 name=birth class="input-sm" id="day">
       </td>
      </tr>
      <tr>
       <td class="text-right" width=15%>E-mail *</td>
       <td width=85%>
         <input type=text name=email id=email size=50 class="input-sm">
       </td>
      </tr>
      <tr>
       <td class="text-right" width=15%>우편번호 *</td>
       <td width=85% class='inline'>
         <input type=text name=post id=post size=10 class="input-sm" readonly>
         <input type=button id="postBtn" value="우편번호찾기"
          class="btn btn-sm btn-success">
       </td>
      </tr>
      <tr>
       <td class="text-right" width=15%>주소 *</td>
       <td width=85%>
         <input type=text name=address1 id=address1 size=50 class="input-sm" readonly>
       </td>
      </tr>
      <tr>
       <td class="text-right" width=15%>상세주소 *</td>
       <td width=85%>
         <input type=text name=address2 id=address2 size=50 class="input-sm">
       </td>
      </tr>
      <tr>
       <td class="text-right" width=15%>전화번호*</td>
       <td width=85% class="inline">
         <input type=text name=tel1 id=tel1 size=7 class="input-sm" value="">
         <input type=text name=tel2 id=tel2 size=20 class="input-sm">
       </td>
      </tr>
      <tr>
      <tr>
       <td class="text-right" width=15%>휴대폰번호 *</td>
       <td width=85% class="inline">
         <input type=text name=tel3 id=tel4 size=7 class="input-sm" value="010">
         <input type=text name=tel3 id=tel4 size=20 class="input-sm">
       </td>
      </tr>
      <tr>
       <td class="text-right" width=15%>소개 *</td>
       <td width=85%>
         <textarea rows="8" cols="55" id="content" name="content"></textarea>
       </td>
      </tr>
      <tr>
      	<td class="agree_warp" align="right"><input type="checkbox" id="news_letter" name="news_letter" class="agree_chk"></td>
      	<td><label for="news_letter">[선택]뉴스레터 수신동의</label></td>
      </tr>
      <tr>
       <td class="checkbox_wrap mar27" align="right">
       <input type="checkbox" id="marketing" name="marketing" class="agree_chk">
       </td>
       <td><label for="marketing">[선택]마케팅 목적 개인정보 수집 및 이용에 대한 동의</label>
		<ul class="explan_txt">
		<li><span style=color:red;>항목 : 성별, 생년월일</span></li>
		<li>고객님께서는 위의 개인정보 및 회원정보 수정 등을 통해 추가로 수집하는 개인정보에<br/>
			대해 동의하지 않거나 개인정보를 기재하지 않음으로써 거부하실 수 있습니다.<br/>
			다만 이때 회원 대상 서비스가 제한될 수 있습니다.
		</li>
		</ul>
       </td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
         <input type=button class="btn btn-sm btn-primary" value="회원가입"
           id="joinBtn"
         >
         <input type=button class="btn btn-sm btn-info" value="돌아가기"
          onclick="javascript:history.back()"
         >
        </td>
      </tr>
    </table>
    </form>
   </main>
  </div>
   </div>
 </div>
 </section>
</div>
</body>
</html>