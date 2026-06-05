<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 

<nav class="navbar">
    <div class="navbar-inner">

        <%-- 로고 --%>
        <a href="/" class="navbar-brand">
            <img src="/img/logo.png" alt="SBN" class="navbar-logo" />
            <span class="navbar-brand-text">SBN</span>
        </a>

        <%-- 메뉴 (선수, 팀, 리그, 게시판) --%>
        <ul class="navbar-menu">
            <li><a href="/Member/List?nowpage=1&keyword=">선수</a></li>
            <li><a href="/Team/List?nowpage=1&keyword=">팀</a></li>
            <li><a href="/League/List?nowpage=1&keyword=">리그</a></li>
            <li><a href="/Board/List?nowpage=1&keyword=&board_type=BOARD_FREE">게시판</a></li>
        </ul>

        <%-- 로그인 / 로그아웃 --%>
        <div class="navbar-auth">
            <c:choose>
                <c:when test="${not empty sessionScope.login}">
                    <span>${sessionScope.login.member_name} 님</span>
                    <a href="/Member/Mypage" class="btn-mypage">마이페이지</a>
                    <a href="/Member/Logout">로그아웃</a>
                </c:when>
                <c:otherwise>
                    <a href="/Member/LoginForm" class="btn-login">로그인</a>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</nav>