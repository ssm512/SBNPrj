<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN</title>
<link rel="shortcut icon" href="/img/favicon.png" type="image/x-icon" />
<link href="/css/common.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet" />
<style>

    /* ===== 스크롤바 고정 (레이아웃 중앙 일치용) ===== */
    html {
        overflow-y: scroll;
    }

    /* ===== 상단 고정 그라디언트 (네비바 가독성) ===== */
    .top-gradient {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 130px;
        background: linear-gradient(to bottom, rgba(0, 0, 0, 0.5) 0%, transparent 100%);
        pointer-events: none;
        z-index: 99;
    }

    /* ===== 네비바 오버라이드 (완전 투명) ===== */
    .navbar {
        position: fixed !important;
        background-color: transparent !important;
        backdrop-filter: none;
        -webkit-backdrop-filter: none;
        box-shadow: none;
    }

    .navbar-inner {
        width: 100%;
        padding: 0 48px;
        position: relative;
    }

    .navbar-brand {
        color: #FFD700;
        text-shadow: none;
    }

    .navbar-menu {
        position: absolute;
        left: 50%;
        transform: translateX(calc(-60% + 20px));
    }

    .navbar-menu a {
        color: #ffffff;
        text-shadow: 0 1px 8px rgba(0, 0, 0, 0.9);
    }

    .navbar-menu a:hover {
        color: #FFD700;
    }

    /* 로그인 / 로그아웃 */
    .navbar-auth a {
        color: #ffffff;
        text-shadow: 0 1px 8px rgba(0, 0, 0, 0.9);
    }

    .navbar-auth a:hover {
        color: #FFD700;
    }

    .navbar-auth span {
        color: #ffffff;
        text-shadow: 0 1px 8px rgba(0, 0, 0, 0.9);
    }

    .navbar-auth .btn-login {
        border-color: rgba(255, 255, 255, 0.8);
    }

    /* ===== 히어로 섹션 (100vh 꽉 채움 + 배경 줌인) ===== */
    .hero-section {
        width: 100%;
        height: 100vh;
        background-image: url('/img/index.png');
        background-size: 110%;
        background-position: 39% 80%;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        animation: heroZoom 10s ease-out forwards;
    }

    @keyframes heroZoom {
        from { background-size: 110%; }
        to   { background-size: 116%; }
    }

    /* ===== 메인 텍스트 (SOCIAL BASEBALL NET) ===== */
    .hero-text {
        text-align: center;
        position: relative;
        z-index: 1;
            transform: perspective(700px) rotateX(12deg) translateX(10px);
    transform-origin: center center;
    }

    .hero-line {
        font-family: 'Bebas Neue', sans-serif;
        font-size: 100px;
        font-weight: 900;
        line-height: 1.08;
        letter-spacing: 10px;
        opacity: 0;
        animation: fadeInUp 0.7s ease forwards;
    }

    /* 각 줄 애니메이션 딜레이 */
    .line-1 { animation-delay: 0.2s; }
    .line-2 { animation-delay: 0.65s; }
    .line-3 { animation-delay: 1.1s; }

    /* S, B, N - 골드 */
    .letter-gold {
        color: #FFD700;
        text-shadow: 0 2px 18px rgba(0, 0, 0, 0.2);
    }

    /* OCIAL, ASEBALL, ET - 흰색 */
    .letter-rest {
        color: rgba(255, 255, 255, 0.92);
        text-shadow: 0 2px 18px rgba(0, 0, 0, 0.45);
    }

    /* ===== 애니메이션 ===== */
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(18px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* ===== 푸터 여백 제거 (스크롤해야 보임) ===== */
    .footer {
        margin-top: 0 !important;
    }

</style>
</head>
<body>
    <div class="top-gradient"></div>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <%-- 히어로 섹션 --%>
    <div class="hero-section">
        <div class="hero-text">
            <div class="hero-line line-1">
                <span class="letter-gold">S</span><span class="letter-rest">OCIAL</span>
            </div>
            <div class="hero-line line-2">
                <span class="letter-gold">B</span><span class="letter-rest">ASEBALL</span>
            </div>
            <div class="hero-line line-3">
                <span class="letter-gold">N</span><span class="letter-rest">ET</span>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>