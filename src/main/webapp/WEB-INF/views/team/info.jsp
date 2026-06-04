<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 구단 정보</title>
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
    .team-card {
        background: rgba(245, 245, 220, 0.88);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 28px 32px;
    }

    /* ===== 검색 헤더 ===== */
    .team-header {
        display: flex;
        justify-content: flex-end;
        padding-bottom: 20px;
        border-bottom: 1px solid #c8c4aa;
        margin-bottom: 28px;
    }

    .search-form { display: flex; gap: 6px; }

    .search-input {
        padding: 8px 14px;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-size: 13px;
        width: 220px;
        outline: none;
        color: #333;
        background: #fff;
        transition: border-color 0.15s;
    }

    .search-input:focus { border-color: #1a3d1a; }

    .btn-search {
        padding: 8px 20px;
        background: #1a3d1a;
        color: #ffffff;
        border: none;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 600;
        letter-spacing: 0.5px;
        cursor: pointer;
        transition: background 0.15s;
    }

    .btn-search:hover { background: #2a5a2a; }

    /* ===== 본문 레이아웃 ===== */
    .team-body {
        display: grid;
        grid-template-columns: 200px 1fr;
        gap: 32px;
        align-items: start;
    }

    /* ===== 좌측 패널 (stats.jsp 스타일) ===== */

    /* 구단명 프로필 카드 */
    .profile-card {
        background: #1a3d1a;
        border-radius: 3px;
        padding: 14px 16px;
        text-align: center;
        margin-bottom: 16px;
    }

    .profile-name {
        font-family: 'Oswald', sans-serif;
        font-size: 16px;
        font-weight: 700;
        color: #FFD700;
        letter-spacing: 1px;
        word-break: keep-all;
    }

    .profile-sub {
        font-size: 11px;
        color: rgba(255, 215, 0, 0.65);
        margin-top: 4px;
        font-family: 'Oswald', sans-serif;
        letter-spacing: 1px;
    }

    /* 섹션 구분 타이틀 */
    .info-section-title {
        font-family: 'Oswald', sans-serif;
        font-size: 11px;
        font-weight: 700;
        color: #1a3d1a;
        letter-spacing: 1.5px;
        text-transform: uppercase;
        padding-bottom: 8px;
        border-bottom: 1px solid #c8c4aa;
        margin-bottom: 8px;
    }

    .info-section-title + .info-section-title {
        margin-top: 14px;
    }

    /* 정보 아이템 */
    .info-item {
        padding: 8px 4px;
        font-size: 13px;
        color: #111;
        border-bottom: 1px solid #ece8d0;
        display: flex;
        align-items: baseline;
        gap: 10px;
    }

    .info-item:last-child { border-bottom: none; }

    .info-label {
        font-family: 'Oswald', sans-serif;
        font-size: 11px;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 1px;
        text-transform: uppercase;
        min-width: 44px;
        flex-shrink: 0;
    }

    /* 리그 아이템 */
    .league-item {
        padding: 7px 4px;
        font-size: 13px;
        color: #222;
        border-bottom: 1px solid #ece8d0;
    }

    .league-item:last-child { border-bottom: none; }

    .league-none {
        padding: 7px 4px;
        font-size: 13px;
        color: #999;
    }

    /* ===== 우측: 선수 목록 테이블 ===== */
    .player-table {
        width: 100%;
        border-collapse: collapse;
        border: none !important;
    }

    .player-table tr { border: none !important; }

    /* 헤더 행 */
    .player-table tr:first-of-type td {
        font-family: 'Oswald', sans-serif;
        font-size: 11px !important;
        font-weight: 600 !important;
        color: #1a3d1a !important;
        letter-spacing: 1.5px;
        text-transform: uppercase;
        padding: 8px 16px 10px !important;
        background: rgba(26, 61, 26, 0.08) !important;
        border: none !important;
        border-bottom: 2px solid #1a3d1a !important;
        border-radius: 0 !important;
        text-align: center !important;
    }

    /* 데이터 행 */
    .player-table tr:not(:first-of-type) td {
        padding: 13px 16px !important;
        border: none !important;
        border-bottom: 1px solid #e0dcc8 !important;
        font-size: 14px !important;
        color: #222 !important;
        font-weight: 500 !important;
        text-align: center !important;
        background: rgba(255, 255, 255, 0.4) !important;
    }

    .player-table tr:not(:first-of-type):hover td {
        background: #ece8d0 !important;
        cursor: pointer;
    }

    /* ===== 하단 버튼 바 ===== */
    .bottom-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 24px;
        padding-top: 20px;
        border-top: 1px solid #e0dcc8;
    }

    .btn-join {
        padding: 9px 22px;
        background: #1a3d1a;
        color: #FFD700;
        border: none;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 600;
        letter-spacing: 1px;
        cursor: pointer;
        transition: background 0.15s;
    }

    .btn-join:hover { background: #2a5a2a; }

    .btn-manage {
        padding: 9px 22px;
        background: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 600;
        letter-spacing: 1px;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
        transition: background 0.15s;
    }

    .btn-manage:hover { background: #e6c200; }

    .btn-leave {
        padding: 9px 22px;
        background: transparent;
        color: #b03030;
        border: 1.5px solid #b03030;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 600;
        letter-spacing: 1px;
        cursor: pointer;
        transition: background 0.15s, color 0.15s;
    }

    .btn-leave:hover {
        background: #b03030;
        color: #ffffff;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">

        <div class="section-header">구단 정보</div>

        <div class="main-wrapper">
            <div class="team-card">

                <%-- 검색 --%>
                <div class="team-header">
                    <form class="search-form" action="/Team/Info" method="get">
                        <input type="hidden" name="team_idx" value="${map.team_idx}">
                        <input class="search-input" type="text" name="keyword"
                               value="${map.keyword}" placeholder="선수 이름 또는 포지션 검색" />
                        <button class="btn-search" type="submit">검색</button>
                    </form>
                </div>

                <%-- 좌측 패널 + 선수 목록 --%>
                <div class="team-body">

                    <%-- 좌측: 구단 정보 패널 (stats.jsp 스타일) --%>
                    <div class="left-panel">

                        <%-- 구단명 프로필 카드 --%>
                        <div class="profile-card">
                            <div class="profile-name">${team.team_name}</div>
                            <div class="profile-sub">${team.team_location}</div>
                        </div>

                        <%-- 구단 기본 정보 --%>
                        <div class="info-section-title">구단 정보</div>

                        <div class="info-item">
                            <span class="info-label">감독</span>
                            <span>${team.member_name}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">창단일</span>
                            <span><fmt:formatDate value="${team.team_regdate}" pattern="yyyy.MM.dd"/></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">선수단</span>
                            <span>${team.member_count}명</span>
                        </div>

                        <%-- 리그 --%>
                        <div class="info-section-title" style="margin-top:14px;">리그</div>
                        <c:choose>
                            <c:when test="${not empty league_list}">
                                <c:forEach var="league" items="${league_list}">
                                    <div class="league-item">${league}</div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="league-none">없음</div>
                            </c:otherwise>
                        </c:choose>

                    </div>

                    <%-- 우측: 선수 목록 --%>
                    <table class="player-table">
                        <tr>
                            <td>선수 이름</td>
                            <td>포지션</td>
                            <td>배번</td>
                            <td>선출</td>
                        </tr>
                        <c:forEach var="mt" items="${mt_list}">
                            <tr onclick='location.href="/Member/Stats?member_idx=${mt.member_idx}"'>
                                <td>${mt.member_name}</td>
                                <td>${mt.position}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${mt.back_num != null}">${mt.back_num}</c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${mt.elite}</td>
                            </tr>
                        </c:forEach>
                    </table>

                </div>

                <%-- 하단 버튼 바 --%>
                <div class="bottom-bar">
                    <div>
                        <c:if test="${myJoinStatus != 1}">
                            <button class="btn-join" type="button" onclick="requestJoin(${map.team_idx})">팀 가입 신청</button>
                        </c:if>
                        <c:if test="${myJoinStatus == 1 and sessionScope.login.member_idx != team.team_manager}">
                            <form action="/Team/LeaveTeam" method="post"
                                  onsubmit="return confirm('정말 탈퇴하시겠습니까?')">
                                <input type="hidden" name="member_idx" value="${sessionScope.login.member_idx}" />
                                <input type="hidden" name="team_idx"   value="${team.team_idx}" />
                                <button type="submit" class="btn-leave">팀 탈퇴</button>
                            </form>
                        </c:if>
                    </div>
                    <div><%@ include file="/WEB-INF/include/teampaging.jsp" %></div>
                    <div>
                        <c:if test="${sessionScope.login.member_idx == team.team_manager}">
                            <a href="/Team/Managing?team_idx=${map.team_idx}" class="btn-manage">팀 관리</a>
                        </c:if>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

    <script>
        <c:if test="${map.alert == 'join_ok'}">alert('가입 신청이 완료되었습니다.');</c:if>
        <c:if test="${map.alert == 'already_applied'}">alert('이미 가입 신청한 팀입니다.');</c:if>
        <c:if test="${map.alert == 'already_member'}">alert('이미 소속된 팀입니다.');</c:if>
        <c:if test="${map.alert == 'no_permission'}">alert('팀관리 권한이 없습니다.');</c:if>
        <c:if test="${map.alert == 'leave_ok'}">alert('탈퇴되었습니다.');</c:if>

        function requestJoin(teamIdx) {
            if (confirm('가입 신청을 하시겠습니까?')) {
                location.href = '/Team/Join?team_idx=' + teamIdx;
            }
        }
    </script>

</body>
</html>
