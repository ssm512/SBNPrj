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
<style>

    /* ===== 히어로 섹션 ===== */
    .hero-section {
        width: 100%;
        height: 1000px;
        background-image: url('/img/index.png');
        background-size: cover;
        background-position: center;
        display: flex;
        align-items: center;
    }

    .hero-content {
        width: 48%;
        padding: 0 80px;
    }

    .hero-title {
        font-size: 52px;
        font-weight: 900;
        color: #006400;
        line-height: 1.25;
        margin-bottom: 16px;
        border: none;
    }

    .hero-underline {
        width: 55px;
        height: 4px;
        background-color: #c8a800;
        margin-bottom: 22px;
    }

    .hero-sub {
        font-size: 15px;
        color: #333;
        line-height: 1.8;
        margin-bottom: 36px;
    }

    .hero-buttons {
        display: flex;
        gap: 14px;
    }

    .btn-hero-primary {
        padding: 14px 38px;
        background-color: #006400;
        color: #fff;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
    }

    .btn-hero-primary:hover {
        background-color: #004d00;
    }

    .btn-hero-secondary {
        padding: 14px 38px;
        background-color: #fff;
        color: #333;
        border: 2px solid #ccc;
        border-radius: 6px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
    }

    .btn-hero-secondary:hover {
        background-color: #f0f0f0;
    }

    /* 히어로 섹션 내 테이블 border 초기화 */
    .hero-section table,
    .hero-section td,
    .hero-section th {
        border: none;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <%-- 히어로 섹션 --%>
    <div class="hero-section">
        <div class="hero-content">
            <h1 class="hero-title">함께하는 야구,<br>더 큰 즐거움</h1>
            <div class="hero-underline"></div>
            <p class="hero-sub">
                사회인 야구인들을 위한 최고의 커뮤니티<br>
                팀 찾기부터 경기 정보, 커뮤니티 활동까지 한 곳에서!
            </p>
            <div class="hero-buttons">
                <a href="/Team/List?nowpage=1&keyword="><button class="btn-hero-primary">팀 찾기</button></a>
                <a href="/League/List?nowpage=1&keyword="><button class="btn-hero-secondary">경기 일정 보기</button></a>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>