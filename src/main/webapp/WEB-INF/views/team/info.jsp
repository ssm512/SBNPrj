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
    /* overflow: hidden 으로 scale(1.05) 삐져나옴 + 푸터 가림 방지 */
    .page-wrapper {
        flex: 1;
        padding: 104px 0 32px;
        position: relative;
        overflow: hidden;
    }

    .page-wrapper::before {
        content: '';
        position: absolute;
        inset: 0;
        background-image: url('/img/index.png');
        background-size: cover;
        background-position: center 60%;
        filter: blur(10px) brightness(0.85);
        transform: scale(1.05); /* 블러 엣지 잘림 방지 */
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
    /* margin-bottom: 0 으로 아래 카드와 여백 없이 붙임 */
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

    /* ===== 팀 카드 (반투명 베이지 + 섹션 헤더와 붙어 상단 모서리 제거) ===== */
    .team-card {
        background: rgba(245, 245, 220, 0.88);
        border-radius: 0 0 10px 10px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 28px 32px;
        margin-bottom: 32px;
    }

    /* ===== 팀 이름 + 검색 상단 (하단 구분선 포함) ===== */
    .team-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 24px;
        padding-bottom: 16px;
        border-bottom: 2px solid #a8a48a;
    }

    /* 팀 이름 타이틀 */
    .team-title {
        font-family: 'Oswald', sans-serif;
        font-size: 22px;
        font-weight: 700;
        color: #1a3d1a;
        letter-spacing: 2px;
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

    /* ===== 팀 정보(좌) + 선수 목록(우) 레이아웃 ===== */
    .team-body {
        display: flex;
        gap: 28px;
        align-items: flex-start;
    }

    /* ===== 좌측: 팀 정보 테이블 ===== */
    /* border-separate + overflow: hidden 으로 border-radius 적용 */
    .team-info-table {
        width: 240px;
        flex-shrink: 0;
        border-collapse: separate;
        border-spacing: 0;
        border: none;
        border-top: 1px solid #a8a48a;
        border-radius: 8px;
        overflow: hidden;
    }

    /* 값 셀 - 우측/하단 구분선 */
    .team-info-table td {
        border: none;
        border-bottom: 1px solid #a8a48a;
        border-right: 1px solid #a8a48a;
        padding: 12px 16px;
        font-size: 14px;
        font-weight: 600;
        color: #111111;
        white-space: nowrap;
    }

    /* 라벨 셀 - 그린 배경 + 골드 텍스트 */
    .team-info-table td.label {
        background-color: #1a3d1a;
        color: #FFD700;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 500;
        letter-spacing: 1px;
        width: 80px;
        text-align: center;
        border-right: 2px solid #a8a48a;
        border-bottom: 1px solid #2a5a2a;
    }

    /* ===== 우측: 선수 목록 테이블 ===== */
    /* common.css의 전역 border 오버라이드 */
    .player-table {
        width: 100%;
        border-collapse: collapse;
        border: none;
    }

    .player-table td {
        border: none;
        border-bottom: 1px solid #a8a48a;
        padding: 13px 16px;
        text-align: center;
        font-size: 14px;
        font-weight: 600;
        color: #111111;
    }


    /* 헤더 행 - 그린 배경 + 골드 하단선 */
    .player-table tr:first-of-type td {
        background-color: #1a3d1a;
        color: #ffffff;
        font-family: 'Oswald', sans-serif;
        font-size: 14px;
        font-weight: 500;
        letter-spacing: 1px;
        border-bottom: 2px solid #FFD700;
    }

    /* 헤더 좌우 상단 모서리 둥글게 */
    .player-table tr:first-of-type td:first-child { border-radius: 6px 0 0 0; }
    .player-table tr:first-of-type td:last-child  { border-radius: 0 6px 0 0; }

    /* 데이터 행 hover */
    .player-table tr:not(:first-of-type):hover td {
        background-color: #ece8d0;
        cursor: pointer;
    }

    /* ===== 하단 버튼 바 (가입 신청 / 페이징 / 팀 관리) ===== */
    .bottom-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 20px;
    }

    /* 팀 가입 신청 버튼 - 그린 배경 + 골드 텍스트 */
    .btn-join {
        padding: 9px 24px;
        background-color: #1a3d1a;
        color: #FFD700;
        border: none;
        border-radius: 6px;
        font-family: 'Oswald', sans-serif;
        font-size: 14px;
        font-weight: 600;
        letter-spacing: 1px;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .btn-join:hover { background-color: #2a5a2a; }

    /* 팀 관리 버튼 - 골드 배경 + 그린 텍스트 (a 태그 단독 사용) */
    .btn-manage {
        padding: 9px 24px;
        background-color: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 6px;
        font-family: 'Oswald', sans-serif;
        font-size: 14px;
        font-weight: 600;
        letter-spacing: 1px;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
        transition: background-color 0.2s;
    }

    .btn-manage:hover { background-color: #e6c200; }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">
        <div class="main-wrapper">

            <%-- 섹션 헤더 --%>
            <div class="section-header">
                <span class="section-title">구단 정보</span>
            </div>

            <div class="team-card">

                <%-- 팀 이름 + 검색 --%>
                <div class="team-header">
                    <h2 class="team-title">${team.team_name}</h2>
                    <form class="search-form" action="/Team/Info" method="get">
                        <input type="hidden" name="team_idx" value="${map.team_idx}">
                        <input class="search-input" type="text" name="keyword"
                               value="${map.keyword}" placeholder="선수 이름 또는 포지션 검색"/>
                        <button class="btn-search" type="submit">검색</button>
                    </form>
                </div>

                <%-- 팀 정보 + 선수 목록 --%>
                <div class="team-body">

                    <%-- 좌측: 팀 정보 --%>
                    <table class="team-info-table">
                        <tr><td class="label">감독</td>    <td>${team.member_name}</td></tr>
                        <tr><td class="label">연고지</td>  <td>${team.team_location}</td></tr>
                        <tr><td class="label">창단일</td>  <td><fmt:formatDate value="${team.team_regdate}" pattern="yyyy.MM.dd"/></td></tr>
                        <tr><td class="label">선수단</td>  <td>${team.member_count}명</td></tr>
                        <c:choose>
                            <c:when test="${not empty league_list}">
                                <c:forEach var="league" items="${league_list}" varStatus="s">
                                    <tr>
                                        <c:if test="${s.first}">
                                            <td class="label" rowspan="${fn:length(league_list)}">소속 리그</td>
                                        </c:if>
                                        <td>${league}</td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr><td class="label">소속 리그</td><td>-</td></tr>
                            </c:otherwise>
                        </c:choose>
                    </table>

                    <%-- 우측: 선수 목록 --%>
                    <table class="player-table">
                        <tr>
                            <td>선수 이름</td>
                            <td>포지션</td>
                            <td>배번</td>
                            <td>선출 여부</td>
                        </tr>
                        <c:forEach var="mt" items="${mt_list}">
                            <tr onclick='location.href="/Member/Stats?member_idx=${mt.member_idx}"'>
                                <td>${mt.member_name}</td>
                                <td>${mt.position}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${mt.back_num != null}">${mt.back_num} 번</c:when>
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

    <%-- 알림 및 기능 스크립트 --%>
    <script>
        <c:if test="${map.alert == 'join_ok'}">alert('가입 신청이 완료되었습니다.');</c:if>
        <c:if test="${map.alert == 'already_applied'}">alert('이미 가입 신청한 팀입니다.');</c:if>
        <c:if test="${map.alert == 'already_member'}">alert('이미 소속된 팀입니다.');</c:if>
        <c:if test="${map.alert == 'no_permission'}">alert('팀관리 권한이 없습니다.');</c:if>

        function requestJoin(teamIdx) {
            if (confirm('가입 신청을 하시겠습니까?')) {
                location.href = '/Team/Join?team_idx=' + teamIdx;
            }
        }
    </script>

</body>
</html>