<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
function oneInsertnav(){
	let userId = '${sessionScope.userId}'
	if(userId==null){
		alter('로그인 후 이용가능합니다.')
		return;
	}else{
		location.href="../customer/one_insert.do"
	}
}

</script>
</head>
<body>
	<section>
		<div class="notice_nav_wrap">
			<div class="notice_nav_bar">
				<ul style="padding-left:23px;">
					<li><img src="../img/ico_bc_home.svg" style="padding-bottom: 3px;"></li>
					<li>></li>
					<li>고객센터</li>
					<li>></li>
					<li>${path }</li>
				</ul>
			</div>
		</div>
		
		<div class="notice_detail_wrap">
			<div class="notice_side">
				<%--  수정 필요 --%>
				<div class="notice_side_top">
					<img alt="고객센터" src="../img/cscenter.png">
				</div>
				<div class="faq_nav" style="border: 1px solid #cdcdcd">
					<dl>
                  		<dt>
                     		<a href="../customer/Faq.do">FAQ</a>
                  		</dt>
              	    </dl>
					<dl>
						<dt>1:1 문의</dt>
						<dd>
							<ul>
								<!-- 로그인 하지 않은 경우 이동하지 못하도록 수정 예정 -->
								<li><a href="javascript:oneInsertnav()">1:1 문의하기</a></li>
								<li><a href="../customer/one_inquiry.do">1:1 문의내역</a></li>
							</ul>
						</dd>

					</dl>
					<dl>
						<dt><a href="../customer/notice.do">공지사항</a></dt>
					</dl>
				</div>
			</div>
			<div class="cs_wrap">
				<jsp:include page="${cscenter_jsp }"/>
			</div>
		</div>
	</section>
</body>
</html>