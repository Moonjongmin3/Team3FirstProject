<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Login &#124; 쌍용books</title>

    <script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous">
        // intergrity 속성과 crossorigin속성은 해킹 방지용
    </script>
    <script src="https://code.jquery.com/jquery-migrate-3.3.2.js" integrity="sha256-BDmtN+79VRrkfamzD16UnAoJP8zMitAz093tvZATdiE=" crossorigin="anonymous"></script>
	<script src="https://kit.fontawesome.com/8f6fa300a9.js" crossorigin="anonymous"></script>
    <!--    웹폰트 영역    -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    
    <!--    파비콘링크 영역    -->
    <link rel="shortcut icon" href="#" type="image/x-icon">
    
  <link rel="stylesheet" href="../css/login.css">
</head>
    <style>
        /*ID Style*/
        #ididcon{
            width: 40px;
            height: 40px;
            padding: 0px 0px 0px 0px;
            margin: 0px 0px 0px 0px;
            border: 1px solid #dfe1e5;
        }
        #id{
            width: 400px;
            height: 40px;
            padding: 0px 0px 0px 0px;
            margin: 0px 0px 0px 0px;
            border: 1px solid #dfe1e5;
        }

    </style>
        <style>
        /*ID Style*/
        #pwdidcon{
            width: 20px;
            height: 40px;
            padding: 0px 0px 0px 0px;
            margin: 0px 0px 0px 0px;
            border: 1px solid #dfe1e5;
        }
        #pwd{
            width: 400px;
            height: 40px;
            padding: 0px 0px 0px 0px;
            margin: 0px 0px 0px 0px;
            border: 1px solid #dfe1e5;
        }

    </style>
<body>
    <div id="wrap">
        <section id="contentwrap">
            <div>
                <div id="loginwrap">
                    <h3>로그인</h3>
                    <div id="login">
                        <h3 id="log1" class="text-center" >
                            <img src="../img/logo.png" alt="쌍용Books 로고" width="300px">
                        </h3>
                        <p id="log2"><strong>WELCOME&#33;</strong>&nbsp쌍용BOOKS에 오신것을 환영합니다.</p>
						<form method="post" name="f1">
							
							<div class="login">
							<i id = idicon class ="fa-solid fa-user"></i>
							<input id="id" name="id" type="text" placeholder="아이디를 입력해주세요." maxlength="20" onKeyDown="if(event.keyCode == 13) loginChk()" />
	                  		 
	                  		 </div>
	                       <div class="password">
	                   		 <i  id = pwdicon class="fa-solid fa-lock"></i>
	                        <input id="pwd" name="pwd" type="password" placeholder="비밀번호를 입력해주세요." maxlength="20" onKeyDown="if(event.keyCode == 13) loginChk()">
	                   		 
	                        </div>
	                        <!-- id저장 아직 미구현 -->
	                        	                        <input id="check" name="check" type="checkbox"><p id="checktext">아이디저장</p>
	                        <button class="login_btn" type="button"  onclick="loginChk()">로그인</button>
                        </form>
                        <!-- 아직 미구현 -->
                        <span class="btn_find">
                        <a href="../user/join.do" onclick="location(this.href, '_black', 'width=500, height=350'); return false;">회원가입</a>
                        |
                        <a href="../user/idfind.do" onclick="window.open(this.href, '_black', 'width=500, height=350'); return false;">아이디</a>
                         / 
                        <a href="../user/pwdfind.do" onclick="window.open(this.href, '_blank', 'width=500, height=350'); return false;">비밀번호 찾기</a></span>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <script>
function loginChk() {
    var form = document.f1;
    if (!form.id.value) {
        alert("아이디를 입력해 주십시오.");
        form.id.focus();
        return;
    }
 
    if (!form.pwd.value) {
        alert("비밀번호를 입력해 주십시오.");
        form.pwd.focus();
        return;
    }
    form.action = "../user/login_ok.do";
    form.submit();
}
</script>
</body>
</html>