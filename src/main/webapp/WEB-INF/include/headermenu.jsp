<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>


<a href="/" >HOME - 이미지로 대체</a><br>
<a href="/Member/List?nowpage=1&keyword=" >선수</a><br>
<a href="/Team/List?nowpage=1&keyword=" >팀</a><br>
<a href="/League/List?nowpage=1&keyword=" >리그</a><br>
<a href="/Board/List?nowpage=1&keyword=" >게시판</a><br>
<c:choose>
    <c:when test="${not empty sessionScope.login}">
    		<p>${ sessionScope.login.member_name } 님 환영합니다.</p>
        <a href="/Member/Mypage?member_idx=${ sessionScope.login.member_idx }">마이페이지</a><br>
        <a href="/Member/Logout">로그아웃</a><br>
    </c:when>
    <c:otherwise>
        <a href="/Member/LoginForm">로그인</a><br>
    </c:otherwise>
</c:choose>




