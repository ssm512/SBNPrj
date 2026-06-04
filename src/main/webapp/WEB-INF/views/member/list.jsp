<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 선수 목록</title>
<link rel="shortcut icon" href="/img/favicon.png" type="image/x-icon" />
<link href="/css/common.css" rel="stylesheet" />
<style>

    /* ===== 푸터 flex 레이아웃을 위한 전체 높이 설정 ===== */
    html, body { height: 100%; }

    /* body를 flex column으로 설정해 footer를 항상 하단에 고정 */
    body {
        background-color: #f5f7fa;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    /* 콘텐츠 영역 - ::before 로 index.png 블러 배경 적용 */
    .content-area {
        flex: 1;
        padding: 104px 0 32px;
        position: relative;
        overflow: hidden;
    }

    .content-area::before {
        content: '';
        position: absolute;
        inset: 0;
        background-image: url('/img/index.png');
        background-size: cover;
        background-position: center 60%;
        filter: blur(10px) brightness(0.85);
        transform: scale(1.05);
        z-index: 0;
    }

    /* main-wrapper가 블러 배경 위에 뜨도록 */
    .main-wrapper {
        position: relative;
        z-index: 1;
    }

    /* common.css의 margin-top: 50px 오버라이드 */
    .footer { margin-top: 0 !important; }

    /* ===== 섹션 헤더 (그린 라벨 + 대각선 줄무늬 + 하단 구분선) ===== */
    .section-header {
        display: flex;
        align-items: stretch;
        margin-bottom: 0;
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
            #1a3d1a 0px, #1a3d1a 4px,
            transparent 4px, transparent 9px
        );
    }

    /* ===== 컨텐츠 카드 (반투명 베이지 + 섹션 헤더와 붙어 상단 모서리 제거) ===== */
    .list-card {
        background: rgba(245, 245, 220, 0.88);
        border-radius: 0 0 10px 10px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 28px 32px;
        margin-bottom: 32px;
    }

    /* ===== 좌우 2분할 레이아웃 ===== */
    .content-body {
        display: flex;
        gap: 28px;
        align-items: flex-start;
    }

    /* 좌측: 선수 목록 */
    .member-section { flex: 3; }

    /* 우측: 명예의 전당 */
    /* padding-top으로 검색 툴바 높이(입력창 + margin-bottom)만큼 내려서 테이블 헤더와 줄 맞춤 */
    .ranker-section {
        flex: 1;
        min-width: 220px;
        padding-top: 52px;
    }

    /* ===== 검색 툴바 ===== */
    .list-toolbar {
        display: flex;
        justify-content: flex-start;
        margin-bottom: 16px;
    }

    .search-form {
        display: flex;
        gap: 8px;
        align-items: center;
    }

    /* 검색 셀렉트 */
    .search-select {
        padding: 8px 10px;
        border: 1px solid #c8c4aa;
        border-radius: 6px;
        font-size: 14px;
        color: #333;
        background-color: #ffffff;
        outline: none;
        cursor: pointer;
    }

    /* 검색 입력창 */
    .search-input {
        padding: 8px 14px;
        border: 1px solid #c8c4aa;
        border-radius: 6px;
        font-size: 14px;
        width: 200px;
        outline: none;
        color: #333;
        background-color: #ffffff;
        transition: border-color 0.2s;
    }

    .search-input:focus { border-color: #1a3d1a; }

    /* 검색 버튼 */
    .btn-search {
        padding: 8px 20px;
        background-color: #1a3d1a;
        color: #ffffff;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        font-family: 'Oswald', sans-serif;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .btn-search:hover { background-color: #2a5a2a; }

    /* ===== 선수 목록 테이블 ===== */
    /* common.css의 전역 border 오버라이드 */
    .member-table {
        width: 100%;
        border-collapse: collapse;
        border: none;
    }

    .member-table td {
        border: none;
        border-bottom: 1px solid #e0dcc8;
        padding: 12px 14px;
        text-align: center;
        font-size: 14px;
        font-weight: 600;
        color: #111111;
    }

    /* 헤더 행 - 그린 배경 + 골드 하단선 */
    .member-table tr:first-of-type td {
        background-color: #1a3d1a;
        color: #ffffff;
        font-family: 'Oswald', sans-serif;
        font-size: 14px;
        font-weight: 500;
        letter-spacing: 1px;
        border-bottom: 2px solid #FFD700;
    }

    /* 헤더 좌우 상단 모서리 둥글게 */
    .member-table tr:first-of-type td:first-child { border-radius: 6px 0 0 0; }
    .member-table tr:first-of-type td:last-child  { border-radius: 0 6px 0 0; }

    /* 데이터 행 hover */
    .member-table tr:not(:first-of-type):hover td {
        background-color: #ece8d0;
        cursor: pointer;
    }

    /* 조회 링크 */
    .member-table a {
        color: #1a3d1a;
        font-weight: 700;
        text-decoration: none;
    }

    .member-table a:hover { text-decoration: underline; }

    /* ===== 페이징 ===== */
    #paging {
        margin-top: 20px;
        text-align: center;
    }

    #paging table {
        border: none;
        margin: 0 auto;
        box-shadow: none;
    }

    #paging td { border: none; padding: 0 2px; }

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

    #paging a.active {
        background-color: #FFD700;
        color: #1a3d1a;
        font-weight: 700;
        border-color: #FFD700;
    }

    /* ===== 우측: 명예의 전당 ===== */
    /* 타이틀 - 그린 배경 바 */
    .hall-of-fame-title {
        background-color: #1a3d1a;
        color: #FFD700;
        font-family: 'Oswald', sans-serif;
        font-size: 14px;
        font-weight: 700;
        letter-spacing: 2px;
        padding: 10px 16px;
        margin-bottom: 14px;
        border-radius: 6px;
        text-align: center;
    }

    /* 타자/투수 전환 - 세그먼트 컨트롤 */
    .toggle-btn-group {
        display: flex;
        border: 1.5px solid #1a3d1a;
        border-radius: 6px;
        overflow: hidden;
        margin-bottom: 14px;
    }

    .toggle-btn {
        flex: 1;
        padding: 9px 0;
        border: none;
        background: transparent;
        color: #1a3d1a;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 600;
        letter-spacing: 1px;
        cursor: pointer;
        transition: all 0.15s;
    }

    /* 두 버튼 사이 구분선 */
    .toggle-btn + .toggle-btn {
        border-left: 1.5px solid #1a3d1a;
    }

    .toggle-btn.active {
        background-color: #1a3d1a;
        color: #FFD700;
    }

    /* 항목 버튼 - 언더라인 탭 */
    .item-btn-group {
        display: flex;
        border-bottom: 2px solid #ddd8c0;
        margin-bottom: 14px;
    }

    .item-btn {
        padding: 6px 12px;
        border: none;
        background: transparent;
        color: #aaa;
        font-size: 12px;
        font-weight: 600;
        letter-spacing: 0.5px;
        cursor: pointer;
        position: relative;
        transition: color 0.15s;
    }

    /* 활성 탭 언더라인 인디케이터 */
    .item-btn::after {
        content: '';
        position: absolute;
        bottom: -2px;
        left: 0;
        right: 0;
        height: 2px;
        background-color: #FFD700;
        transform: scaleX(0);
        transition: transform 0.15s;
    }

    .item-btn.active {
        color: #1a3d1a;
        font-weight: 700;
    }

    .item-btn.active::after {
        transform: scaleX(1);
    }

    /* ===== 랭커 테이블 ===== */
    /* common.css 전역 border 오버라이드 */
    .ranker-table {
        width: 100%;
        border-collapse: collapse;
        border: none;
    }

    /* 타이틀 행 */
    .ranker-table .ranker-title td {
        background-color: #1a3d1a;
        color: #FFD700;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 700;
        letter-spacing: 1.5px;
        text-align: center;
        padding: 9px 8px;
        border: none;
        border-bottom: 2px solid #FFD700;
        border-radius: 6px 6px 0 0;
    }

    /* 데이터 행 */
    .ranker-table .rank-row td {
        border: none;
        border-bottom: 1px solid #e0dcc8;
        padding: 10px 8px;
        vertical-align: middle;
    }

    .ranker-table .rank-row:hover td { background-color: #ece8d0; }

    /* 순위 숫자 */
    .rank-num {
        font-family: 'Oswald', sans-serif;
        font-size: 20px;
        font-weight: 700;
        color: #bbb;
        width: 32px;
        text-align: center;
    }

    /* 1~3위 금/은/동 */
    .ranker-table tr:nth-child(2) .rank-num { color: #FFD700; }
    .ranker-table tr:nth-child(3) .rank-num { color: #A8A9AD; }
    .ranker-table tr:nth-child(4) .rank-num { color: #CD7F32; }

    /* 선수명 + 팀명 셀 */
    .rank-info { text-align: left; }

    .rank-name {
        display: block;
        font-size: 13px;
        font-weight: 700;
    }

    .rank-name a {
        color: #1a3d1a;
        text-decoration: none;
    }

    .rank-name a:hover { text-decoration: underline; }

    .rank-team {
        display: block;
        font-size: 11px;
        color: #999;
        font-weight: 400;
        margin-top: 2px;
    }

    /* 스탯 값 */
    .rank-stat {
        font-family: 'Oswald', sans-serif;
        font-size: 15px;
        font-weight: 700;
        color: #1a3d1a;
        text-align: right;
        white-space: nowrap;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="content-area">
        <div class="main-wrapper">

            <%-- 섹션 헤더 --%>
            <div class="section-header">
                <span class="section-title">선수 목록</span>
            </div>

            <div class="list-card">
                <div class="content-body">

                    <%-- 좌측: 선수 목록 --%>
                    <section class="member-section">

                        <%-- 검색 툴바 --%>
                        <div class="list-toolbar">
                            <form class="search-form" action="/Member/List" method="get">
                                <input type="hidden" name="nowpage" value="1" />
                                <select class="search-select" name="searchType">
                                    <option value="member_name" ${map.searchType == 'member_name' ? 'selected' : ''}>선수명</option>
                                    <option value="team_name"   ${map.searchType == 'team_name'   ? 'selected' : ''}>소속 팀</option>
                                </select>
                                <input class="search-input" type="text" name="keyword" value="${map.keyword}" placeholder="검색어를 입력하세요" />
                                <button class="btn-search" type="submit">검색</button>
                            </form>
                        </div>

                        <%-- 선수 목록 테이블 --%>
                        <table class="member-table">
                            <tr>
                                <td>이미지</td>
                                <td>선수 이름</td>
                                <td>소속 팀</td>
                                <td>선출 여부</td>
                                <td>조회</td>
                            </tr>
                            <c:forEach var="member" items="${memberList}">
                            <tr onclick="location.href='/Member/Stats?member_idx=${member.member_idx}'" style="cursor:pointer;">
                                <td>선수 사진</td>
                                <td>${member.member_name}</td>
                                <td>
                                    ${member.join_team_name}
                                    <c:if test="${member.join_team_count eq 0}">
                                        <span style="color:#aaa; font-weight:400;">무소속</span>
                                    </c:if>
                                    <c:if test="${member.join_team_count gt 1}">
                                        <b>외 ${member.join_team_count - 1}팀</b>
                                    </c:if>
                                </td>
                                <td>${member.elite}</td>
                                <td><a href="/Member/Stats?member_idx=${member.member_idx}">조회</a></td>
                            </tr>
                            </c:forEach>
                        </table>

                        <%-- 페이징 --%>
                        <%@ include file="/WEB-INF/include/memberpaging.jsp" %>

                    </section>

                    <%-- 우측: 명예의 전당 --%>
                    <section class="ranker-section">
                        <div class="hall-of-fame-title">SBN 명예의 전당</div>

                        <%-- 타자 / 투수 전환 버튼 --%>
                        <div class="toggle-btn-group">
                            <button type="button" class="toggle-btn active" id="hitRankerBtn">타자</button>
                            <button type="button" class="toggle-btn"        id="pitchRankerBtn">투수</button>
                        </div>

                        <%-- 타자 랭킹 --%>
                        <div id="hitRankerArea">
                            <div class="item-btn-group">
                                <button type="button" class="item-btn active" data-target="avgArea">타율</button>
                                <button type="button" class="item-btn"        data-target="homeRunArea">홈런</button>
                                <button type="button" class="item-btn"        data-target="getScoreArea">타점</button>
                                <button type="button" class="item-btn"        data-target="hitArea">안타</button>
                            </div>
                            <div id="avgArea">
                                <table class="ranker-table">
                                    <tr class="ranker-title"><td colspan="3">타율 TOP 5</td></tr>
                                    <c:forEach var="m" items="${rankerList.avgRanker}" varStatus="vs">
                                    <tr class="rank-row">
                                        <td class="rank-num">${vs.index + 1}</td>
                                        <td class="rank-info">
                                            <span class="rank-name"><a href="/Member/Stats?member_idx=${m.member_idx}">${m.member_name}</a></span>
                                            <c:choose>
                                                <c:when test="${m.join_team_count eq 0}"><span class="rank-team">무소속</span></c:when>
                                                <c:when test="${m.join_team_count eq 1}"><span class="rank-team">${m.join_team_name}</span></c:when>
                                                <c:otherwise><span class="rank-team">${m.join_team_name} 외 ${m.join_team_count - 1}팀</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="rank-stat">${m.hitstats.avg}</td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                            <div id="homeRunArea" style="display:none;">
                                <table class="ranker-table">
                                    <tr class="ranker-title"><td colspan="3">홈런 TOP 5</td></tr>
                                    <c:forEach var="m" items="${rankerList.homeRunRanker}" varStatus="vs">
                                    <tr class="rank-row">
                                        <td class="rank-num">${vs.index + 1}</td>
                                        <td class="rank-info">
                                            <span class="rank-name"><a href="/Member/Stats?member_idx=${m.member_idx}">${m.member_name}</a></span>
                                            <c:choose>
                                                <c:when test="${m.join_team_count eq 0}"><span class="rank-team">무소속</span></c:when>
                                                <c:when test="${m.join_team_count eq 1}"><span class="rank-team">${m.join_team_name}</span></c:when>
                                                <c:otherwise><span class="rank-team">${m.join_team_name} 외 ${m.join_team_count - 1}팀</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="rank-stat">${m.hitstats.homeRun}</td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                            <div id="getScoreArea" style="display:none;">
                                <table class="ranker-table">
                                    <tr class="ranker-title"><td colspan="3">타점 TOP 5</td></tr>
                                    <c:forEach var="m" items="${rankerList.getScoreRanker}" varStatus="vs">
                                    <tr class="rank-row">
                                        <td class="rank-num">${vs.index + 1}</td>
                                        <td class="rank-info">
                                            <span class="rank-name"><a href="/Member/Stats?member_idx=${m.member_idx}">${m.member_name}</a></span>
                                            <c:choose>
                                                <c:when test="${m.join_team_count eq 0}"><span class="rank-team">무소속</span></c:when>
                                                <c:when test="${m.join_team_count eq 1}"><span class="rank-team">${m.join_team_name}</span></c:when>
                                                <c:otherwise><span class="rank-team">${m.join_team_name} 외 ${m.join_team_count - 1}팀</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="rank-stat">${m.hitstats.getScore}</td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                            <div id="hitArea" style="display:none;">
                                <table class="ranker-table">
                                    <tr class="ranker-title"><td colspan="3">안타 TOP 5</td></tr>
                                    <c:forEach var="m" items="${rankerList.hitRanker}" varStatus="vs">
                                    <tr class="rank-row">
                                        <td class="rank-num">${vs.index + 1}</td>
                                        <td class="rank-info">
                                            <span class="rank-name"><a href="/Member/Stats?member_idx=${m.member_idx}">${m.member_name}</a></span>
                                            <c:choose>
                                                <c:when test="${m.join_team_count eq 0}"><span class="rank-team">무소속</span></c:when>
                                                <c:when test="${m.join_team_count eq 1}"><span class="rank-team">${m.join_team_name}</span></c:when>
                                                <c:otherwise><span class="rank-team">${m.join_team_name} 외 ${m.join_team_count - 1}팀</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="rank-stat">${m.hitstats.totalHit}</td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div><%-- 타자 랭킹 End --%>

                        <%-- 투수 랭킹 --%>
                        <div id="pitchRankerArea" style="display:none;">
                            <div class="item-btn-group">
                                <button type="button" class="item-btn active" data-target="eraArea">방어율</button>
                                <button type="button" class="item-btn"        data-target="winArea">승</button>
                                <button type="button" class="item-btn"        data-target="strikeOutArea">탈삼진</button>
                                <button type="button" class="item-btn"        data-target="inningArea">이닝</button>
                            </div>
                            <div id="eraArea">
                                <table class="ranker-table">
                                    <tr class="ranker-title"><td colspan="3">방어율 TOP 5</td></tr>
                                    <c:forEach var="m" items="${rankerList.eraRanker}" varStatus="vs">
                                    <tr class="rank-row">
                                        <td class="rank-num">${vs.index + 1}</td>
                                        <td class="rank-info">
                                            <span class="rank-name"><a href="/Member/Stats?member_idx=${m.member_idx}">${m.member_name}</a></span>
                                            <c:choose>
                                                <c:when test="${m.join_team_count eq 0}"><span class="rank-team">무소속</span></c:when>
                                                <c:when test="${m.join_team_count eq 1}"><span class="rank-team">${m.join_team_name}</span></c:when>
                                                <c:otherwise><span class="rank-team">${m.join_team_name} 외 ${m.join_team_count - 1}팀</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="rank-stat">${m.pitchstats.era}</td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                            <div id="winArea" style="display:none;">
                                <table class="ranker-table">
                                    <tr class="ranker-title"><td colspan="3">승리 TOP 5</td></tr>
                                    <c:forEach var="m" items="${rankerList.winRanker}" varStatus="vs">
                                    <tr class="rank-row">
                                        <td class="rank-num">${vs.index + 1}</td>
                                        <td class="rank-info">
                                            <span class="rank-name"><a href="/Member/Stats?member_idx=${m.member_idx}">${m.member_name}</a></span>
                                            <c:choose>
                                                <c:when test="${m.join_team_count eq 0}"><span class="rank-team">무소속</span></c:when>
                                                <c:when test="${m.join_team_count eq 1}"><span class="rank-team">${m.join_team_name}</span></c:when>
                                                <c:otherwise><span class="rank-team">${m.join_team_name} 외 ${m.join_team_count - 1}팀</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="rank-stat">${m.pitchstats.win}</td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                            <div id="strikeOutArea" style="display:none;">
                                <table class="ranker-table">
                                    <tr class="ranker-title"><td colspan="3">탈삼진 TOP 5</td></tr>
                                    <c:forEach var="m" items="${rankerList.strikeOutRanker}" varStatus="vs">
                                    <tr class="rank-row">
                                        <td class="rank-num">${vs.index + 1}</td>
                                        <td class="rank-info">
                                            <span class="rank-name"><a href="/Member/Stats?member_idx=${m.member_idx}">${m.member_name}</a></span>
                                            <c:choose>
                                                <c:when test="${m.join_team_count eq 0}"><span class="rank-team">무소속</span></c:when>
                                                <c:when test="${m.join_team_count eq 1}"><span class="rank-team">${m.join_team_name}</span></c:when>
                                                <c:otherwise><span class="rank-team">${m.join_team_name} 외 ${m.join_team_count - 1}팀</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="rank-stat">${m.pitchstats.strikeOut}</td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                            <div id="inningArea" style="display:none;">
                                <table class="ranker-table">
                                    <tr class="ranker-title"><td colspan="3">이닝 TOP 5</td></tr>
                                    <c:forEach var="m" items="${rankerList.inningRanker}" varStatus="vs">
                                    <tr class="rank-row">
                                        <td class="rank-num">${vs.index + 1}</td>
                                        <td class="rank-info">
                                            <span class="rank-name"><a href="/Member/Stats?member_idx=${m.member_idx}">${m.member_name}</a></span>
                                            <c:choose>
                                                <c:when test="${m.join_team_count eq 0}"><span class="rank-team">무소속</span></c:when>
                                                <c:when test="${m.join_team_count eq 1}"><span class="rank-team">${m.join_team_name}</span></c:when>
                                                <c:otherwise><span class="rank-team">${m.join_team_name} 외 ${m.join_team_count - 1}팀</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="rank-stat">${m.pitchstats.inning}</td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div><%-- 투수 랭킹 End --%>

                    </section>

                </div>
            </div>

        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

    <%-- 타자/투수 전환 및 항목 전환 스크립트 --%>
    <script>

        // 타자/투수 전환
        const hitRankerBtnEl    = document.querySelector('#hitRankerBtn');
        const pitchRankerBtnEl  = document.querySelector('#pitchRankerBtn');
        const hitRankerAreaEl   = document.querySelector('#hitRankerArea');
        const pitchRankerAreaEl = document.querySelector('#pitchRankerArea');

        hitRankerBtnEl.addEventListener('click', function () {
            hitRankerAreaEl.style.display   = 'block';
            pitchRankerAreaEl.style.display = 'none';
            hitRankerBtnEl.classList.add('active');
            pitchRankerBtnEl.classList.remove('active');
        });

        pitchRankerBtnEl.addEventListener('click', function () {
            hitRankerAreaEl.style.display   = 'none';
            pitchRankerAreaEl.style.display = 'block';
            pitchRankerBtnEl.classList.add('active');
            hitRankerBtnEl.classList.remove('active');
        });

        // 타자 항목 전환
        document.querySelectorAll('#hitRankerArea .item-btn').forEach(btn => {
            btn.addEventListener('click', function () {
                document.querySelectorAll('#hitRankerArea > div[id]').forEach(area => area.style.display = 'none');
                document.querySelector('#' + this.getAttribute('data-target')).style.display = 'block';
                document.querySelectorAll('#hitRankerArea .item-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
            });
        });

        // 투수 항목 전환
        document.querySelectorAll('#pitchRankerArea .item-btn').forEach(btn => {
            btn.addEventListener('click', function () {
                document.querySelectorAll('#pitchRankerArea > div[id]').forEach(area => area.style.display = 'none');
                document.querySelector('#' + this.getAttribute('data-target')).style.display = 'block';
                document.querySelectorAll('#pitchRankerArea .item-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
            });
        });

    </script>

</body>
</html>
