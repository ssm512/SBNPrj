<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 경기 정보</title>
<link rel="shortcut icon" href="/img/favicon2.png" type="image/png" />
<link href="/css/common.css" rel="stylesheet" />
<link href="https://webfontworld.github.io/sunn/SCDream.css" rel="stylesheet" />
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
        font-family: 'S-Core Dream', sans-serif;
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
    .info-card {
        background: rgba(249, 249, 234, 0.93);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 24px 28px;
        margin-bottom: 16px;
    }

    /* ===== 테이블 ===== */
    table {
        width: 100%;
        border-collapse: collapse;
        border: none !important;
        margin-bottom: 0;
    }

    td {
        border: none !important;
        border-bottom: 1px solid #e0dcc8 !important;
        padding: 12px 14px !important;
        text-align: center;
        font-size: 14px;
        font-weight: 500;
        color: #111;
    }

    /* 헤더 행 */
    tr:first-of-type td {
        font-family: 'S-Core Dream', sans-serif;
        font-size: 14px !important;
        font-weight: 600 !important;
        color: #1a3d1a !important;
        letter-spacing: 1px;
        background: rgba(26, 61, 26, 0.08) !important;
        border-bottom: 2px solid #1a3d1a !important;
        padding: 10px 14px 12px !important;
    }

    tr:not(:first-of-type):hover td {
        background: #ece8d0 !important;
        cursor: pointer;
    }

    /* ===== 팀 로고 ===== */
    .team-logo {
        width: 60px;
        height: 60px;
        object-fit: contain;
    }

    /* ===== 컨트롤 바 (Away/Home + 관리 버튼) ===== */
    .game-control-bar {
        background: rgba(249, 249, 234, 0.93);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 16px 28px;
        margin-bottom: 16px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .awayhomechoose {
        display: flex;
        gap: 8px;
    }

    /* ===== 버튼 ===== */
    input[type="button"], button {
        min-width: 100px;
        height: 34px;
        padding: 0 16px;
        background-color: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 3px;
        font-family: 'S-Core Dream', sans-serif;
        font-size: 13px;
        font-weight: 700;
        letter-spacing: 0.5px;
        cursor: pointer;
        transition: background 0.15s;
    }

    input[type="button"]:hover, button:hover {
        background-color: #e6c200;
    }

    /* Away/Home 선택 버튼 활성 상태 */
    .selected {
        background-color: #1a3d1a !important;
        color: #FFD700 !important;
    }

    /* 하단 버튼 영역 */
    .btn-area {
        text-align: center;
    }

    #updatebtn {
        display: flex;
        gap: 8px;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">

        <div class="section-header">경기 정보</div>

        <div class="main-wrapper">

            <%-- 경기 기본 정보 --%>
            <div class="info-card">
                <table id="gameenv">
                    <tr>
                        <td>경기번호</td>
                        <td>리그</td>
                        <td>날짜</td>
                        <td>시간</td>
                        <td>장소</td>
                    </tr>
                    <tr>
                        <td>${gameinfo.game_idx}</td>
                        <td>${league_name}</td>
                        <td>${gameinfo.game_date}</td>
                        <td>${gameinfo.game_time}</td>
                        <td>${gameinfo.game_field}</td>
                    </tr>
                </table>
            </div>

            <%-- 팀 대전 현황 --%>
            <div class="info-card">
                <table id="gamestat">
                    <tr>
                        <td>로고</td>
                        <td>Away팀</td>
                        <td>Away점수</td>
                        <td>경기상황</td>
                        <td>Home점수</td>
                        <td>Home팀</td>
                        <td>로고</td>
                    </tr>
                    <tr>
                        <td>
                            <c:if test="${not empty teamNames.away_logo}">
                                <img src="/sbndata/${teamNames.away_logo}" class="team-logo">
                            </c:if>
                        </td>
                        <td>${teamNames.away_name}</td>
                        <td>${topScoreBoard.r}</td>
                        <td>
                            <c:choose>
                                <c:when test="${gameinfo.game_status == 0}">경기미진행</c:when>
                                <c:when test="${gameinfo.game_status == 1}">경기종료</c:when>
                                <c:when test="${gameinfo.game_status == 2}">경기중</c:when>
                                <c:when test="${gameinfo.game_status == 3}">우천취소</c:when>
                            </c:choose>
                        </td>
                        <td>${bottomScoreBoard.r}</td>
                        <td>${teamNames.home_name}</td>
                        <td>
                            <c:if test="${not empty teamNames.home_logo}">
                                <img src="/sbndata/${teamNames.home_logo}" class="team-logo">
                            </c:if>
                        </td>
                    </tr>
                </table>
            </div>

            <%-- 스코어보드 --%>
            <div class="info-card">
                <table id="scoreboard">
                    <tr>
                        <td>팀명</td>
                        <td>1</td><td>2</td><td>3</td><td>4</td><td>5</td>
                        <td>6</td><td>7</td><td>8</td><td>9</td>
                        <td>R</td><td>H</td><td>B</td>
                    </tr>
                    <tr>
                        <td>${teamNames.away_name}</td>
                        <td>${topScoreBoard.i1}</td><td>${topScoreBoard.i2}</td>
                        <td>${topScoreBoard.i3}</td><td>${topScoreBoard.i4}</td>
                        <td>${topScoreBoard.i5}</td><td>${topScoreBoard.i6}</td>
                        <td>${topScoreBoard.i7}</td><td>${topScoreBoard.i8}</td>
                        <td>${topScoreBoard.i9}</td>
                        <td>${topScoreBoard.r}</td><td>${topScoreBoard.h}</td><td>${topScoreBoard.b}</td>
                    </tr>
                    <tr>
                        <td>${teamNames.home_name}</td>
                        <td>${bottomScoreBoard.i1}</td><td>${bottomScoreBoard.i2}</td>
                        <td>${bottomScoreBoard.i3}</td><td>${bottomScoreBoard.i4}</td>
                        <td>${bottomScoreBoard.i5}</td><td>${bottomScoreBoard.i6}</td>
                        <td>${bottomScoreBoard.i7}</td><td>${bottomScoreBoard.i8}</td>
                        <td>${bottomScoreBoard.i9}</td>
                        <td>${bottomScoreBoard.r}</td><td>${bottomScoreBoard.h}</td><td>${bottomScoreBoard.b}</td>
                    </tr>
                </table>
            </div>

            <%-- Away/Home 전환 + 관리 버튼 --%>
            <div class="game-control-bar">
                <div class="awayhomechoose">
                    <input type="button" id="awayBtn" value="AWAY" />
                    <input type="button" id="homeBtn" value="HOME" />
                </div>
                <c:if test="${sessionScope.login.is_admin == 'Y'}">
                    <div id="updatebtn">
                        <input type="button" value="경기결과 입력"
                               onclick="location.href='/Game/AddResultForm?league_idx=${league_idx}&game_idx=${game_idx}'" />
                        <input type="button" value="경기결과 수정"
                               onclick="location.href='/Game/UpdateResultForm?league_idx=${league_idx}&game_idx=${game_idx}'" />
                    </div>
                </c:if>
            </div>

            <%-- 타자 / 투수 기록 --%>
            <div class="info-card">
                <table id="awayhitterrecords" class="away">
                    <tr>
                        <td>타순</td><td>이름</td><td>타석</td><td>타수</td><td>타점</td>
                        <td>안타</td><td>홈런</td><td>희생타</td><td>사사구</td><td>삼진</td><td>타율</td>
                    </tr>
                    <c:forEach var="recorda" items="${awayHRecord}">
                        <tr>
                            <td>${recorda.hitter_num}</td><td>${recorda.hitter_name}</td>
                            <td>${recorda.pa}</td><td>${recorda.at_bat}</td><td>${recorda.score}</td>
                            <td>${recorda.hit}</td><td>${recorda.hr}</td><td>${recorda.sac}</td>
                            <td>${recorda.bb}</td><td>${recorda.k}</td><td>${recorda.avg}</td>
                        </tr>
                    </c:forEach>
                </table>

                <table id="homehitterrecords" class="home">
                    <tr>
                        <td>타순</td><td>이름</td><td>타석</td><td>타수</td><td>타점</td>
                        <td>안타</td><td>홈런</td><td>희생타</td><td>사사구</td><td>삼진</td><td>타율</td>
                    </tr>
                    <c:forEach var="recordb" items="${homeHRecord}">
                        <tr>
                            <td>${recordb.hitter_num}</td><td>${recordb.hitter_name}</td>
                            <td>${recordb.pa}</td><td>${recordb.at_bat}</td><td>${recordb.score}</td>
                            <td>${recordb.hit}</td><td>${recordb.hr}</td><td>${recordb.sac}</td>
                            <td>${recordb.bb}</td><td>${recordb.k}</td><td>${recordb.avg}</td>
                        </tr>
                    </c:forEach>
                </table>

                <table id="awaypitcherrecords" class="away" style="margin-top:16px;">
                    <tr>
                        <td>이름</td><td>이닝</td><td>피안타</td><td>실점</td><td>자책점</td>
                        <td>사사구</td><td>탈삼진</td><td>피홈런</td><td>타자</td><td>타수</td>
                    </tr>
                    <c:forEach var="awayP" items="${awayPRecord}">
                        <tr>
                            <td>${awayP.PITCHER_NAME}</td><td>${awayP.INNINGS}</td>
                            <td>${awayP.HIT_CNT}</td><td>${awayP.RUN_CNT}</td><td>${awayP.ERA_CNT}</td>
                            <td>${awayP.BB_CNT}</td><td>${awayP.K_CNT}</td><td>${awayP.HR_CNT}</td>
                            <td>${awayP.BATTER_CNT}</td><td>${awayP.AT_BAT_CNT}</td>
                        </tr>
                    </c:forEach>
                </table>

                <table id="homepitcherrecords" class="home" style="margin-top:16px;">
                    <tr>
                        <td>이름</td><td>이닝</td><td>피안타</td><td>실점</td><td>자책점</td>
                        <td>사사구</td><td>탈삼진</td><td>피홈런</td><td>타자</td><td>타수</td>
                    </tr>
                    <c:forEach var="homeP" items="${homePRecord}">
                        <tr>
                            <td>${homeP.PITCHER_NAME}</td><td>${homeP.INNINGS}</td>
                            <td>${homeP.HIT_CNT}</td><td>${homeP.RUN_CNT}</td><td>${homeP.ERA_CNT}</td>
                            <td>${homeP.BB_CNT}</td><td>${homeP.K_CNT}</td><td>${homeP.HR_CNT}</td>
                            <td>${homeP.BATTER_CNT}</td><td>${homeP.AT_BAT_CNT}</td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

            <%-- 하단 버튼 --%>
            <div class="info-card btn-area">
                <input type="button" value="경기목록"
                       onclick="location.href='/League/Info?league_idx=${league_idx}'" />
            </div>

        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

    <script>
        const homeEls   = document.querySelectorAll('.home');
        const awayEls   = document.querySelectorAll('.away');
        const awayBtnEl = document.querySelector('#awayBtn');
        const homeBtnEl = document.querySelector('#homeBtn');

        homeEls.forEach(el => { el.style.display = 'none'; });
        awayBtnEl.classList.add('selected');

        awayBtnEl.addEventListener('click', () => {
            awayEls.forEach(el => { el.style.display = ''; });
            homeEls.forEach(el => { el.style.display = 'none'; });
            awayBtnEl.classList.add('selected');
            homeBtnEl.classList.remove('selected');
        });

        homeBtnEl.addEventListener('click', () => {
            homeEls.forEach(el => { el.style.display = ''; });
            awayEls.forEach(el => { el.style.display = 'none'; });
            homeBtnEl.classList.add('selected');
            awayBtnEl.classList.remove('selected');
        });
    </script>

</body>
</html>
