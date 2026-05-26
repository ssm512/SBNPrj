<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>


<a href="/" >HOME - 이미지로 대체</a><br>
<a href="/Member/List" >선수</a><br>
<a href="/Team/List" >팀</a><br>
<a href="/League/List" >리그</a><br>
<a href="/Board/List" >게시판</a><br>
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

