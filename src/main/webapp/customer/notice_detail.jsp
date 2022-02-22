<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세</title>
</head>
<body>
    <section>
        <div class="nav_wrap">
            <div class="nav_bar" style="padding-left: 20px">
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
                <div class="notice_detail">
                <h3>공지사항</h3>
                <table class="table">
                    <tr style="background-color: #cdcdcd">
                        <td width="15%" colspan="1" class="text-center">제목</td>
                        <td width="85%" colspan="3" style="background-color: white">${notice.title}</td>
                    </tr>
                    <tr>
                        <td width="15%" class="text-center" style="background-color: #cdcdcd">날짜</td>
                        <td width="25%">${notice.created_At}</td>
                        <td width="15%" class="text-center" style="background-color: #cdcdcd">조회수</td>
                        <td width="25%">${notice.hit}</td>
                    </tr>
                    <tr>
                        <td colspan="4" height="300px" valign="top" style="padding:10px 15px;">
                        <pre>${notice.content}</pre>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-right" colspan="4">
                            <c:if test="${sessionScope.admin==1}">
                                <a href="notice_update.do?page=${page}&no=${notice.no}" class="btn btn-xs btn-info">수정</a>
                                <a href="notice_delete.do?page=${page}&no=${notice.no}" class="btn btn-xs btn-danger">삭제</a>
                            </c:if>
                            <a href="notice.do?page=${page }" class="btn btn-xs btn-success">목록</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </section>
</body>
</html>