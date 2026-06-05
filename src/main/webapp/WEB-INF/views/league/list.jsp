<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 리그 목록</title>
<link rel="shortcut icon" href="/img/favicon2.png" type="image/png" />
<link href="/css/common.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&display=swap" rel="stylesheet" />
<style>

    html, body { height: 100%; }

    body {
        background-color: #f5f7fa;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    body::before {
        content: '';
        position: fixed;
        inset: -5%;
        background-image: url('/img/index.png');
        background-size: cover;
        background-position: center 60%;
        filter: blur(10px) brightness(0.85);
        z-index: -1;
    }

    .page-wrapper {
        flex: 1;
        padding: 84px 32px 48px;
    }

    .footer { margin-top: 0 !important; }

    /* ===== 섹션 헤더 ===== */
    .section-header {
        background-color: #1a3d1a;
        color: #FFD700;
        padding: 10px 20px;
        font-family: 'Oswald', sans-serif;
        font-size: 24px;
        font-weight: 700;
        letter-spacing: 3px;
        margin: 0 auto 16px;
        border-radius: 3px;
        max-width: 1160px;
        position: relative;
        overflow: hidden;
    }

    .section-header::after {
        content: '';
        position: absolute;
        top: -20px; right: -10px;
        width: 100px; height: 100px;
        background: repeating-linear-gradient(
            45deg,
            transparent, transparent 5px,
            rgba(255, 215, 0, 0.12) 5px, rgba(255, 215, 0, 0.12) 10px
        );
        pointer-events: none;
    }

    /* ===== 메인 래퍼 ===== */
    .main-wrapper {
        max-width: 1160px;
        margin: 0 auto;
    }

    /* ===== 카드 ===== */
    .list-card {
        background: rgba(249, 249, 234, 0.93);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 28px 32px;
    }

    /* ===== 검색 폼 ===== */
    .search-form {
        display: flex;
        gap: 8px;
        margin-bottom: 16px;
    }

    .search-select {
        padding: 7px 10px;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-size: 13px;
        color: #333;
        background: #fff;
        outline: none;
    }

    .search-input {
        padding: 7px 12px;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-size: 13px;
        width: 200px;
        color: #333;
        background: #fff;
        outline: none;
        transition: border-color 0.15s;
    }

    .search-input:focus { border-color: #1a3d1a; }

    .btn-search {
        padding: 7px 18px;
        background: #1a3d1a;
        color: #fff;
        border: none;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 600;
        cursor: pointer;
        transition: background 0.15s;
    }

    .btn-search:hover { background: #2a5a2a; }

    /* ===== 리그 목록 테이블 ===== */
    .leagues {
        width: 100%;
        border-collapse: collapse;
        border: none !important;
    }

    .leagues tr { border: none !important; }

    .leagues tr:first-of-type td {
        font-family: 'Oswald', sans-serif;
        font-size: 14px !important;
        font-weight: 600 !important;
        color: #1a3d1a !important;
        letter-spacing: 1.5px;
        text-transform: uppercase;
        padding: 8px 12px 10px !important;
        background: rgba(26, 61, 26, 0.08) !important;
        border: none !important;
        border-bottom: 2px solid #1a3d1a !important;
        text-align: center !important;
    }

    .leagues tr:not(:first-of-type) td {
        border: none !important;
        border-bottom: 1px solid #e0dcc8 !important;
        padding: 13px 12px !important;
        font-size: 14px !important;
        color: #222 !important;
        background: rgba(255, 255, 255, 0.4) !important;
        text-align: center !important;
    }

    .leagues tr:not(:first-of-type):hover td {
        background: #ece8d0 !important;
        cursor: pointer;
    }

    .leagues a {
        text-decoration: none;
        color: #1a3d1a;
        font-weight: 600;
    }

    .leagues a:hover { text-decoration: underline; }

    /* ===== 페이징 ===== */
    #paging { margin-top: 20px; text-align: center; }
    #paging table { border: none !important; margin: 0 auto; box-shadow: none; }
    #paging td { border: none !important; padding: 0 2px !important; background: none !important; }
    #paging a {
        display: inline-block;
        padding: 6px 13px;
        color: #1a3d1a;
        text-decoration: none;
        border-radius: 3px;
        font-size: 13px;
        font-family: 'Oswald', sans-serif;
        border: 1px solid #c8c4aa;
        background: rgba(255, 255, 255, 0.7);
        transition: all 0.15s;
    }
    #paging a:hover { background: #1a3d1a; color: #fff; border-color: #1a3d1a; }
    #paging a.active { background: #FFD700; color: #1a3d1a; font-weight: 700; border-color: #FFD700; }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">

        <div class="section-header">리그 목록</div>

        <div class="main-wrapper">
            <div class="list-card">

                <form class="search-form" action="/League/List" method="get">
                    <input type="hidden" name="nowpage" value="1" />
                    <select class="search-select" name="searchType">
                        <option value="league_name"     ${map.searchType == 'league_name'     ? 'selected' : ''}>리그 이름</option>
                        <option value="league_location" ${map.searchType == 'league_location' ? 'selected' : ''}>연고지</option>
                    </select>
                    <input class="search-input" type="text" name="keyword"
                           value="${map.keyword}" placeholder="검색어를 입력하세요" />
                    <button class="btn-search" type="submit">검색</button>
                </form>

                <table class="leagues">
                    <tr>
                        <td>리그 이름</td>
                        <td>연고지</td>
                        <td>소개</td>
                    </tr>
                    <c:forEach var="league" items="${leagueList}">
                    <tr onclick="location.href='/League/Info?league_idx=${league.league_idx}'" style="cursor:pointer;">
                        <td><a href="/League/Info?league_idx=${league.league_idx}">${league.league_name}</a></td>
                        <td>${league.league_location}</td>
                        <td>${league.league_content}</td>
                    </tr>
                    </c:forEach>
                </table>

                <%@ include file="/WEB-INF/include/leaguepaging.jsp" %>

            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

</body>
</html>
