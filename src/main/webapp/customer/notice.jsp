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
</head>
<body>
	<section>
		<div class="notice_nav_wrap">
			<div class="notice_nav_bar">
				<ul>
					<li><img src="../img/ico_bc_home.svg" style="padding-bottom: 3px;"></li>
					<li>></li>
					<li>고객센터</li>
					<li>></li>
					<li>공지사항</li>
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
						<dt>FAQ</dt>
						<dd>
							<ul>
								<li>상품</li>
								<li>주문/결제</li>
								<li>배송</li>
								<li>환불</li>
							</ul>
						</dd>

					</dl>
					<dl>
						<dt>1:1 문의</dt>
						<dd>
							<ul>
								<li>1:1 문의하기</li>
								<li>1:1 문의내역</li>
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