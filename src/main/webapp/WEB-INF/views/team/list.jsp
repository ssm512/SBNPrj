<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 구단 목록</title>
<link href="/css/common.css" rel="stylesheet" />
<style>

    /* ===== 푸터 flex 레이아웃을 위한 전체 높이 설정 ===== */
    html, body {
        height: 100%;
    }

    /* body를 flex column으로 설정해 footer를 항상 하단에 고정 */
    body {
        background-color: #f5f7fa;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    /* 콘텐츠 영역이 남은 공간을 모두 차지해 푸터를 하단으로 밀어냄 */
    .content-area {
        flex: 1;
        padding: 104px 0 32px;
    }

    /* common.css의 margin-top: 50px 오버라이드 (히어로 이후 불필요한 여백 제거) */
    .footer {
        margin-top: 0 !important;
    }

    /* ===== 섹션 헤더 (그린 라벨 + 대각선 줄무늬 + 하단 구분선) ===== */
    .section-header {
        display: flex;
        align-items: stretch;
        margin-bottom: 16px;
        border-bottom: 2px solid #1a3d1a;
    }

    .section-title {
        background-color: #1a3d1a;
        color: #FFD700;
        font-family: 'Oswald', sans-serif;
        font-size: 15px;
        font-weight: 700;
        padding: 9px 22px;
        letter-spacing: 2px;
        position: relative;
    }

    /* 라벨 우측 대각선 줄무늬 장식 */
    .section-title::after {
        content: '';
        position: absolute;
        right: -18px;
        top: 0;
        width: 18px;
        height: 100%;
        background: repeating-linear-gradient(
            -55deg,
            #1a3d1a 0px,
            #1a3d1a 4px,
            transparent 4px,
            transparent 9px
        );
    }

    /* ===== 컨텐츠 카드 (베이지 배경 + 둥근 모서리) ===== */
    .list-card {
        background: #F5F5DC;
        border-radius: 10px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 28px 32px;
        margin-bottom: 32px;
    }

    /* ===== 검색 + 구단 만들기 버튼 행 ===== */
    .list-toolbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .search-form {
        display: flex;
        gap: 8px;
    }

    /* 검색 입력창 - 베이지 카드 위에서 흰 배경으로 구분 */
    .search-input {
        padding: 8px 14px;
        border: 1px solid #dde2ea;
        border-radius: 6px;
        font-size: 14px;
        width: 240px;
        outline: none;
        color: #333;
        background-color: #ffffff;
        transition: border-color 0.2s;
    }

    .search-input:focus {
        border-color: #1a3d1a;
    }

    /* 검색 버튼 */
    .btn-search {
        padding: 8px 20px;
        background-color: #1a3d1a;
        color: #ffffff;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        font-family: 'Oswald', sans-serif;
        letter-spacing: 0.5px;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .btn-search:hover {
        background-color: #2a5a2a;
    }

    /* 구단 만들기 버튼 (a 태그로 단독 사용 - button 중첩 금지) */
    .btn-create {
        padding: 8px 22px;
        background-color: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        font-family: 'Oswald', sans-serif;
        font-weight: 600;
        letter-spacing: 0.5px;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
        transition: background-color 0.2s;
    }

    .btn-create:hover {
        background-color: #e6c200;
        color: #1a3d1a;
    }

    /* ===== 구단 목록 테이블 ===== */
    /* common.css의 전역 border: 1px solid black 오버라이드 */
    #list {
        width: 100%;
        border-collapse: collapse;
        border: none;
    }

    #list td {
        border: none;
        border-bottom: 1px solid #e0dcc8;
        padding: 14px 16px;
        text-align: center;
        font-size: 14px;
        font-weight: 600;
        color: #111111;
    }

    /* 헤더 행 - 그린 배경 + 골드 하단선 */
    #list tr:first-of-type td {
        background-color: #1a3d1a;
        color: #ffffff;
        font-family: 'Oswald', sans-serif;
        font-size: 14px;
        font-weight: 500;
        letter-spacing: 1px;
        border-bottom: 2px solid #FFD700;
        padding: 13px 16px;
    }

    /* 헤더 좌우 상단 모서리 둥글게 */
    #list tr:first-of-type td:first-child { border-radius: 6px 0 0 0; }
    #list tr:first-of-type td:last-child  { border-radius: 0 6px 0 0; }

    /* 데이터 행 hover */
    #list tr:not(:first-of-type):hover td {
        background-color: #ece8d0;
        cursor: pointer;
    }

    /* 컬럼별 너비 및 색상 */
    #list td:nth-of-type(1) { width: 180px; color: #1a3d1a; }  /* 구단명 - 그린 */
    #list td:nth-of-type(2) { width: 120px; color: #111111; }  /* 감독 */
    #list td:nth-of-type(3) { width: 160px; color: #111111; }  /* 리그 */
    #list td:nth-of-type(4) { text-align: left; color: #111111; } /* 구단 소개 */

    /* ===== 페이징 ===== */
    #paging {
        margin-top: 24px;
        text-align: center;
    }

    /* common.css 전역 테이블 스타일 오버라이드 */
    #paging table {
        border: none;
        margin: 0 auto;
        box-shadow: none;
    }

    #paging td {
        border: none;
        padding: 0 2px;
    }

    #paging a {
        display: inline-block;
        padding: 6px 13px;
        color: #1a3d1a;
        text-decoration: none;
        border-radius: 5px;
        font-size: 14px;
        font-family: 'Oswald', sans-serif;
        border: 1px solid #c8c4aa;
        background: #faf9f0;
        transition: all 0.2s;
    }

    #paging a:hover {
        background-color: #1a3d1a;
        color: #ffffff;
        border-color: #1a3d1a;
    }

    /* 현재 페이지 강조 */
    #paging a.active {
        background-color: #FFD700;
        color: #1a3d1a;
        font-weight: 700;
        border-color: #FFD700;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="content-area">
        <div class="main-wrapper">

            <%-- 섹션 헤더 --%>
            <div class="section-header">
                <span class="section-title">구단 목록</span>
            </div>

            <div class="list-card">

                <%-- 검색 + 구단 만들기 버튼 --%>
                <div class="list-toolbar">
                    <form class="search-form" action="/Team/List" method="get">
                        <input type="hidden" name="nowpage" value="1"/>
                        <input class="search-input" type="text" name="keyword"
                               value="${map.keyword}" placeholder="구단 이름 또는 지역 검색"/>
                        <button class="btn-search" type="submit">검색</button>
                    </form>
                    <%-- a 태그 단독 사용 (button 중첩 금지) --%>
                    <a href="/Team/MakeTeamForm" class="btn-create">구단 만들기</a>
                </div>

                <%-- 구단 목록 테이블 --%>
                <table id="list">
                    <tr>
                        <td>구단 이름</td>
                        <td>감독</td>
                        <td>리그</td>
                        <td>구단 소개</td>
                    </tr>
                    <c:forEach var="team" items="${team_list}">
                        <tr onclick="location.href='/Team/Info?team_idx=${team.team_idx}&keyword='"
                            style="cursor:pointer;">
                            <td>${team.team_name   }</td>
                            <td>${team.member_name }</td>
                            <td>${team.league_name }</td>
                            <td>${team.team_content}</td>
                        </tr>
                    </c:forEach>
                </table>

                <%-- 페이징 --%>
                <%@ include file="/WEB-INF/include/teampaging.jsp" %>

            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>