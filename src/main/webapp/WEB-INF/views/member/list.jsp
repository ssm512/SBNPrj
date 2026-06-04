<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 선수 목록</title>
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
        font-size: 20px;
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
        background: rgba(245, 245, 220, 0.88);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 28px 32px;
    }

    /* ===== 좌우 2분할 ===== */
    .content-body {
        display: flex;
        gap: 28px;
        align-items: flex-start;
    }

    #left-side  { flex: 3; }
    #right-side { flex: 1; min-width: 220px; padding-top: 52px; }

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
        width: 180px;
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

    /* ===== 선수 목록 테이블 ===== */
    .members {
        width: 100%;
        border-collapse: collapse;
        border: none !important;
        margin: 0;
    }

    .members tr { border: none !important; }

    .members tr:first-of-type td {
        font-family: 'Oswald', sans-serif;
        font-size: 11px !important;
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

    .members tr:not(:first-of-type) td {
        border: none !important;
        border-bottom: 1px solid #e0dcc8 !important;
        padding: 10px 12px !important;
        font-size: 14px !important;
        color: #222 !important;
        background: rgba(255, 255, 255, 0.4) !important;
        text-align: center !important;
    }

    .members tr:not(:first-of-type):hover td {
        background: #ece8d0 !important;
        cursor: pointer;
    }

    .members a {
        text-decoration: none;
        color: #1a3d1a;
        font-weight: 600;
    }

    .members a:hover { text-decoration: underline; }

    /* ===== 페이징 ===== */
    #paging {
        margin-top: 20px;
        text-align: center;
    }

    #paging table { border: none !important; margin: 0 auto; box-shadow: none; }

    #paging td {
        border: none !important;
        padding: 0 2px !important;
        background: none !important;
    }

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

    #paging a.active {
        background: #FFD700;
        color: #1a3d1a;
        font-weight: 700;
        border-color: #FFD700;
    }

    /* ===== 우측: 명예의 전당 ===== */
    .hall-of-fame-title {
        background: #1a3d1a;
        color: #FFD700;
        font-family: 'Oswald', sans-serif;
        font-size: 14px;
        font-weight: 700;
        letter-spacing: 2px;
        padding: 10px 16px;
        margin-bottom: 14px;
        border-radius: 3px;
        text-align: center;
    }

    /* 타자/투수 토글 */
    .toggle-group {
        display: flex;
        border: 1.5px solid #1a3d1a;
        border-radius: 3px;
        overflow: hidden;
        margin-bottom: 14px;
    }

    #hitRankerBtn, #pitchRankerBtn {
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
        width: auto;
        height: auto;
        border-radius: 0;
    }

    #pitchRankerBtn { border-left: 1.5px solid #1a3d1a; }

    #hitRankerBtn.active, #pitchRankerBtn.active {
        background: #1a3d1a;
        color: #FFD700;
    }

    /* 항목 탭 */
    .item-tab-group {
        display: flex;
        flex-wrap: wrap;
        gap: 6px;
        margin-bottom: 14px;
    }

    .hit-item-btn, .pitch-item-btn {
        padding: 5px 13px;
        border: 1.5px solid #c8c4aa;
        border-radius: 3px;
        background: rgba(255, 255, 255, 0.6);
        color: #888;
        font-family: 'Oswald', sans-serif;
        font-size: 12px;
        font-weight: 600;
        letter-spacing: 0.8px;
        cursor: pointer;
        transition: all 0.18s ease;
        width: auto;
        height: auto;
        margin: 0;
        position: relative;
    }

    .hit-item-btn:hover, .pitch-item-btn:hover {
        border-color: #1a3d1a;
        color: #1a3d1a;
        background: rgba(26, 61, 26, 0.06);
    }

    .hit-item-btn.active, .pitch-item-btn.active {
        background: #1a3d1a;
        border-color: #1a3d1a;
        color: #FFD700;
        font-weight: 700;
        box-shadow: 0 2px 6px rgba(26, 61, 26, 0.25);
    }

    .hit-item-btn.active::after, .pitch-item-btn.active::after {
        display: none;
    }

    /* ===== 랭커 테이블 ===== */
    .ranker-tbl {
        width: 100%;
        border-collapse: collapse;
        border: none !important;
        margin: 0;
    }

    .ranker-tbl td {
        border: none !important;
        border-bottom: 1px solid #e0dcc8 !important;
        padding: 7px 6px !important;
        font-size: 13px;
        background: rgba(255, 255, 255, 0.3) !important;
        vertical-align: middle;
    }

    /* 타이틀 행 */
    .ranker-tbl tr:first-child td {
        background: #1a3d1a !important;
        color: #FFD700 !important;
        font-family: 'Oswald', sans-serif;
        font-size: 13px !important;
        font-weight: 700 !important;
        letter-spacing: 1px;
        text-align: center !important;
        border-bottom: 2px solid #FFD700 !important;
        padding: 9px 8px !important;
    }

    /* 팀명 행 (하단 구분선 제거 → 선수행과 붙어 보임) */
    .ranker-tbl .team-row td {
        font-size: 11px !important;
        color: #888 !important;
        padding: 5px 6px 2px !important;
        border-bottom: none !important;
        background: rgba(255, 255, 255, 0.3) !important;
    }

    .ranker-tbl a {
        text-decoration: none;
        color: #1a3d1a;
        font-weight: 600;
    }

    .ranker-tbl a:hover { text-decoration: underline; }

    /* 순위 셀 */
    .rank-no {
        width: 44px;
        text-align: center !important;
        vertical-align: middle !important;
    }

    /* 메달 배지 (기본: 4~5위 회색) */
    .medal {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 34px;
        height: 34px;
        border-radius: 50%;
        font-family: 'Oswald', sans-serif;
        font-size: 14px;
        font-weight: 700;
        background: #e4e0d8;
        color: #aaa;
        border: 2px solid #ccc9c0;
    }

    /* 금 */
    .ranker-tbl tr:nth-child(2) .medal {
        background: #FFD700;
        border: 2px solid #C8960A;
        color: #6b4200;
        box-shadow: 0 2px 6px rgba(184, 134, 11, 0.35);
    }

    /* 은 */
    .ranker-tbl tr:nth-child(4) .medal {
        background: #C8C8C8;
        border: 2px solid #969696;
        color: #333;
        box-shadow: 0 2px 6px rgba(100, 100, 100, 0.3);
    }

    /* 동 */
    .ranker-tbl tr:nth-child(6) .medal {
        background: #CD7F32;
        border: 2px solid #9A5A14;
        color: #fff;
        box-shadow: 0 2px 6px rgba(139, 69, 19, 0.35);
    }

    /* 스탯 값 */
    .rank-val {
        font-family: 'Oswald', sans-serif;
        font-size: 14px;
        font-weight: 700;
        color: #1a3d1a;
        text-align: right !important;
        white-space: nowrap;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">

        <div class="section-header">선수 목록</div>

        <div class="main-wrapper">
            <div class="list-card">
                <div class="content-body">

                    <%-- 좌측: 선수 목록 --%>
                    <div id="left-side">

                        <form class="search-form" action="/Member/List" method="get">
                            <input type="hidden" name="nowpage" value="1" />
                            <select class="search-select" name="searchType">
                                <option value="member_name" ${map.searchType == 'member_name' ? 'selected' : ''}>선수명</option>
                                <option value="team_name"   ${map.searchType == 'team_name'   ? 'selected' : ''}>소속 팀</option>
                            </select>
                            <input class="search-input" type="text" name="keyword" value="${map.keyword}" placeholder="검색어를 입력하세요" />
                            <button class="btn-search" type="submit">검색</button>
                        </form>

                        <table class="members">
                            <tr>
                                <td>이미지</td>
                                <td>선수 이름</td>
                                <td>소속 팀</td>
                                <td>선출 여부</td>
                                <td>조회</td>
                            </tr>
                            <c:forEach var="member" items="${memberList}">
                            <tr onclick="location.href='/Member/Stats?member_idx=${member.member_idx}'" style="cursor:pointer;">
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty member.sfile_name}">
                                            <img src="/sbndata/${member.sfile_name}"
                                                 style="width:36px; height:36px; border-radius:50%; object-fit:cover;"
                                                 onerror="this.src='/img/sbndefaultimg.png'" />
                                        </c:when>
                                        <c:otherwise>
                                            <img src="/img/sbndefaultimg.png"
                                                 style="width:36px; height:36px; border-radius:50%;" />
                                        </c:otherwise>
                                    </c:choose>
                                </td>
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

                        <%@ include file="/WEB-INF/include/memberpaging.jsp" %>

                    </div><%-- #left-side --%>

                    <%-- 우측: 명예의 전당 --%>
                    <div id="right-side">

                        <div class="hall-of-fame-title">SBN 명예의 전당</div>

                        <div class="toggle-group">
                            <input type="button" id="hitRankerBtn"   value="타자" class="active" />
                            <input type="button" id="pitchRankerBtn" value="투수" />
                        </div>

                        <%-- 타자 랭킹 --%>
                        <div id="hitRankerArea">
                            <div class="item-tab-group">
                                <input type="button" class="hit-item-btn active" data-target="avgArea"      value="타율" />
                                <input type="button" class="hit-item-btn"        data-target="homeRunArea"  value="홈런" />
                                <input type="button" class="hit-item-btn"        data-target="getScoreArea" value="타점" />
                                <input type="button" class="hit-item-btn"        data-target="hitArea"      value="안타" />
                            </div>
                            <div id="avgArea">
                                <table class="ranker-tbl">
                                    <tr><td colspan="3">타율 TOP 5</td></tr>
                                    <c:forEach var="m" items="${rankerList.avgRanker}" varStatus="vs">
                                    <tr class="team-row">
                                        <td class="rank-no" rowspan="2"><span class="medal">${vs.index + 1}</span></td>
                                        <c:choose>
                                            <c:when  test="${m.join_team_count eq 0}"><td colspan="2" style="color:#aaa;">무소속</td></c:when>
                                            <c:when  test="${m.join_team_count eq 1}"><td colspan="2">${m.join_team_name}</td></c:when>
                                            <c:otherwise><td colspan="2">${m.join_team_name} 외 ${m.join_team_count - 1}팀</td></c:otherwise>
                                        </c:choose>
                                    </tr>
                                    <tr>
                                        <td><a href="/Member/Stats?member_idx=${m.member_idx}">
                                            <img src="/sbndata/${m.sfile_name}" style="width:24px; height:24px; border-radius:50%; object-fit:cover; vertical-align:middle; margin-right:4px;" onerror="this.src='/img/sbndefaultimg.png'" />
                                            ${m.member_name}</a>
                                        </td>
                                        <td class="rank-val">${m.hitstats.avg}</td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                            <div id="homeRunArea" style="display:none;">
                                <table class="ranker-tbl">
                                    <tr><td colspan="3">홈런 TOP 5</td></tr>
                                    <c:forEach var="m" items="${rankerList.homeRunRanker}" varStatus="vs">
                                    <tr class="team-row">
                                        <td class="rank-no" rowspan="2"><span class="medal">${vs.index + 1}</span></td>
                                        <c:choose>
                                            <c:when  test="${m.join_team_count eq 0}"><td colspan="2" style="color:#aaa;">무소속</td></c:when>
                                            <c:when  test="${m.join_team_count eq 1}"><td colspan="2">${m.join_team_name}</td></c:when>
                                            <c:otherwise><td colspan="2">${m.join_team_name} 외 ${m.join_team_count - 1}팀</td></c:otherwise>
                                        </c:choose>
                                    </tr>
                                    <tr>
                                        <td><a href="/Member/Stats?member_idx=${m.member_idx}">
                                            <img src="/sbndata/${m.sfile_name}" style="width:24px; height:24px; border-radius:50%; object-fit:cover; vertical-align:middle; margin-right:4px;" onerror="this.src='/img/sbndefaultimg.png'" />
                                            ${m.member_name}</a>
                                        </td>
                                        <td class="rank-val">${m.hitstats.homeRun}</td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                            <div id="getScoreArea" style="display:none;">
                                <table class="ranker-tbl">
                                    <tr><td colspan="3">타점 TOP 5</td></tr>
                                    <c:forEach var="m" items="${rankerList.getScoreRanker}" varStatus="vs">
                                    <tr class="team-row">
                                        <td class="rank-no" rowspan="2"><span class="medal">${vs.index + 1}</span></td>
                                        <c:choose>
                                            <c:when  test="${m.join_team_count eq 0}"><td colspan="2" style="color:#aaa;">무소속</td></c:when>
                                            <c:when  test="${m.join_team_count eq 1}"><td colspan="2">${m.join_team_name}</td></c:when>
                                            <c:otherwise><td colspan="2">${m.join_team_name} 외 ${m.join_team_count - 1}팀</td></c:otherwise>
                                        </c:choose>
                                    </tr>
                                    <tr>
                                        <td><a href="/Member/Stats?member_idx=${m.member_idx}">
                                            <img src="/sbndata/${m.sfile_name}" style="width:24px; height:24px; border-radius:50%; object-fit:cover; vertical-align:middle; margin-right:4px;" onerror="this.src='/img/sbndefaultimg.png'" />
                                            ${m.member_name}</a>
                                        </td>
                                        <td class="rank-val">${m.hitstats.getScore}</td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                            <div id="hitArea" style="display:none;">
                                <table class="ranker-tbl">
                                    <tr><td colspan="3">안타 TOP 5</td></tr>
                                    <c:forEach var="m" items="${rankerList.hitRanker}" varStatus="vs">
                                    <tr class="team-row">
                                        <td class="rank-no" rowspan="2"><span class="medal">${vs.index + 1}</span></td>
                                        <c:choose>
                                            <c:when  test="${m.join_team_count eq 0}"><td colspan="2" style="color:#aaa;">무소속</td></c:when>
                                            <c:when  test="${m.join_team_count eq 1}"><td colspan="2">${m.join_team_name}</td></c:when>
                                            <c:otherwise><td colspan="2">${m.join_team_name} 외 ${m.join_team_count - 1}팀</td></c:otherwise>
                                        </c:choose>
                                    </tr>
                                    <tr>
                                        <td><a href="/Member/Stats?member_idx=${m.member_idx}">
                                            <img src="/sbndata/${m.sfile_name}" style="width:24px; height:24px; border-radius:50%; object-fit:cover; vertical-align:middle; margin-right:4px;" onerror="this.src='/img/sbndefaultimg.png'" />
                                            ${m.member_name}</a>
                                        </td>
                                        <td class="rank-val">${m.hitstats.totalHit}</td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div><%-- 타자 랭킹 End --%>

                        <%-- 투수 랭킹 --%>
                        <div id="pitchRankerArea" style="display:none;">
                            <div class="item-tab-group">
                                <input type="button" class="pitch-item-btn active" data-target="eraArea"      value="방어율" />
                                <input type="button" class="pitch-item-btn"        data-target="winArea"       value="승" />
                                <input type="button" class="pitch-item-btn"        data-target="strikeOutArea" value="탈삼진" />
                                <input type="button" class="pitch-item-btn"        data-target="inningArea"    value="이닝" />
                            </div>
                            <div id="eraArea">
                                <table class="ranker-tbl">
                                    <tr><td colspan="3">방어율 TOP 5</td></tr>
                                    <c:forEach var="m" items="${rankerList.eraRanker}" varStatus="vs">
                                    <tr class="team-row">
                                        <td class="rank-no" rowspan="2"><span class="medal">${vs.index + 1}</span></td>
                                        <c:choose>
                                            <c:when  test="${m.join_team_count eq 0}"><td colspan="2" style="color:#aaa;">무소속</td></c:when>
                                            <c:when  test="${m.join_team_count eq 1}"><td colspan="2">${m.join_team_name}</td></c:when>
                                            <c:otherwise><td colspan="2">${m.join_team_name} 외 ${m.join_team_count - 1}팀</td></c:otherwise>
                                        </c:choose>
                                    </tr>
                                    <tr>
                                        <td><a href="/Member/Stats?member_idx=${m.member_idx}">
                                            <img src="/sbndata/${m.sfile_name}" style="width:24px; height:24px; border-radius:50%; object-fit:cover; vertical-align:middle; margin-right:4px;" onerror="this.src='/img/sbndefaultimg.png'" />
                                            ${m.member_name}</a>
                                        </td>
                                        <td class="rank-val">${m.pitchstats.era}</td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                            <div id="winArea" style="display:none;">
                                <table class="ranker-tbl">
                                    <tr><td colspan="3">승리 TOP 5</td></tr>
                                    <c:forEach var="m" items="${rankerList.winRanker}" varStatus="vs">
                                    <tr class="team-row">
                                        <td class="rank-no" rowspan="2"><span class="medal">${vs.index + 1}</span></td>
                                        <c:choose>
                                            <c:when  test="${m.join_team_count eq 0}"><td colspan="2" style="color:#aaa;">무소속</td></c:when>
                                            <c:when  test="${m.join_team_count eq 1}"><td colspan="2">${m.join_team_name}</td></c:when>
                                            <c:otherwise><td colspan="2">${m.join_team_name} 외 ${m.join_team_count - 1}팀</td></c:otherwise>
                                        </c:choose>
                                    </tr>
                                    <tr>
                                        <td><a href="/Member/Stats?member_idx=${m.member_idx}">
                                            <img src="/sbndata/${m.sfile_name}" style="width:24px; height:24px; border-radius:50%; object-fit:cover; vertical-align:middle; margin-right:4px;" onerror="this.src='/img/sbndefaultimg.png'" />
                                            ${m.member_name}</a>
                                        </td>
                                        <td class="rank-val">${m.pitchstats.win}</td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                            <div id="strikeOutArea" style="display:none;">
                                <table class="ranker-tbl">
                                    <tr><td colspan="3">탈삼진 TOP 5</td></tr>
                                    <c:forEach var="m" items="${rankerList.strikeOutRanker}" varStatus="vs">
                                    <tr class="team-row">
                                        <td class="rank-no" rowspan="2"><span class="medal">${vs.index + 1}</span></td>
                                        <c:choose>
                                            <c:when  test="${m.join_team_count eq 0}"><td colspan="2" style="color:#aaa;">무소속</td></c:when>
                                            <c:when  test="${m.join_team_count eq 1}"><td colspan="2">${m.join_team_name}</td></c:when>
                                            <c:otherwise><td colspan="2">${m.join_team_name} 외 ${m.join_team_count - 1}팀</td></c:otherwise>
                                        </c:choose>
                                    </tr>
                                    <tr>
                                        <td><a href="/Member/Stats?member_idx=${m.member_idx}">
                                            <img src="/sbndata/${m.sfile_name}" style="width:24px; height:24px; border-radius:50%; object-fit:cover; vertical-align:middle; margin-right:4px;" onerror="this.src='/img/sbndefaultimg.png'" />
                                            ${m.member_name}</a>
                                        </td>
                                        <td class="rank-val">${m.pitchstats.strikeOut}</td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                            <div id="inningArea" style="display:none;">
                                <table class="ranker-tbl">
                                    <tr><td colspan="3">이닝 TOP 5</td></tr>
                                    <c:forEach var="m" items="${rankerList.inningRanker}" varStatus="vs">
                                    <tr class="team-row">
                                        <td class="rank-no" rowspan="2"><span class="medal">${vs.index + 1}</span></td>
                                        <c:choose>
                                            <c:when  test="${m.join_team_count eq 0}"><td colspan="2" style="color:#aaa;">무소속</td></c:when>
                                            <c:when  test="${m.join_team_count eq 1}"><td colspan="2">${m.join_team_name}</td></c:when>
                                            <c:otherwise><td colspan="2">${m.join_team_name} 외 ${m.join_team_count - 1}팀</td></c:otherwise>
                                        </c:choose>
                                    </tr>
                                    <tr>
                                        <td><a href="/Member/Stats?member_idx=${m.member_idx}">
                                            <img src="/sbndata/${m.sfile_name}" style="width:24px; height:24px; border-radius:50%; object-fit:cover; vertical-align:middle; margin-right:4px;" onerror="this.src='/img/sbndefaultimg.png'" />
                                            ${m.member_name}</a>
                                        </td>
                                        <td class="rank-val">${m.pitchstats.inning}</td>
                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </div><%-- 투수 랭킹 End --%>

                    </div><%-- #right-side --%>

                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

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
        document.querySelectorAll('#hitRankerArea .hit-item-btn').forEach(btn => {
            btn.addEventListener('click', function () {
                document.querySelectorAll('#hitRankerArea > div[id]').forEach(area => area.style.display = 'none');
                document.querySelector('#' + this.getAttribute('data-target')).style.display = 'block';
                document.querySelectorAll('#hitRankerArea .hit-item-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
            });
        });

        // 투수 항목 전환
        document.querySelectorAll('#pitchRankerArea .pitch-item-btn').forEach(btn => {
            btn.addEventListener('click', function () {
                document.querySelectorAll('#pitchRankerArea > div[id]').forEach(area => area.style.display = 'none');
                document.querySelector('#' + this.getAttribute('data-target')).style.display = 'block';
                document.querySelectorAll('#pitchRankerArea .pitch-item-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
            });
        });

    </script>

</body>
</html>
