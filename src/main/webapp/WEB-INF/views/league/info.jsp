<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 리그 정보</title>
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
    .info-card {
        background: rgba(245, 245, 220, 0.88);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 28px 32px;
    }

    /* ===== 3단 레이아웃 ===== */
    .info-body {
        display: grid;
        grid-template-columns: 210px 210px 1fr;
        gap: 28px;
        align-items: start;
    }

    /* ===== 공통: 섹션 타이틀 ===== */
    .panel-title {
        font-family: 'Oswald', sans-serif;
        font-size: 11px;
        font-weight: 700;
        color: #1a3d1a;
        letter-spacing: 1.5px;
        text-transform: uppercase;
        padding-bottom: 8px;
        border-bottom: 1px solid #c8c4aa;
        margin-bottom: 10px;
    }

    /* ===== 좌측 패널: 리그 정보 ===== */

    .profile-card {
        background: #1a3d1a;
        border-radius: 3px;
        padding: 14px 16px;
        text-align: center;
        margin-bottom: 14px;
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

    .info-item {
        padding: 8px 4px;
        font-size: 13px;
        color: #111;
        border-bottom: 1px solid #ece8d0;
        display: flex;
        align-items: baseline;
        gap: 10px;
    }

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

    /* 리그 소개 */
    .content-box {
        font-size: 13px;
        color: #333;
        line-height: 1.65;
        padding: 9px 4px 10px;
        border-bottom: 1px solid #ece8d0;
        white-space: pre-line;
        word-break: keep-all;
    }

    .content-none {
        padding: 7px 4px;
        font-size: 13px;
        color: #bbb;
        font-style: italic;
        border-bottom: 1px solid #ece8d0;
    }

    /* 액션 버튼 영역 */
    .btn-group {
        display: flex;
        flex-direction: column;
        gap: 8px;
        margin-top: 14px;
    }

    .btn-apply {
        padding: 9px 0;
        background: #1a3d1a;
        color: #FFD700;
        border: none;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 600;
        letter-spacing: 1px;
        cursor: pointer;
        width: 100%;
        transition: background 0.15s;
    }

    .btn-apply:hover { background: #2a5a2a; }

    .btn-manage {
        display: block;
        padding: 9px 0;
        background: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 600;
        letter-spacing: 1px;
        cursor: pointer;
        width: 100%;
        text-align: center;
        text-decoration: none;
        transition: background 0.15s;
    }

    .btn-manage:hover { background: #e6c200; }

    /* ===== 중앙 패널: 팀 순위 ===== */
    .standings-tbl {
        width: 100%;
        border-collapse: collapse;
        border: none !important;
    }

    .standings-tbl tr { border: none !important; }

    .standings-tbl tr:first-of-type td {
        font-family: 'Oswald', sans-serif;
        font-size: 10px !important;
        font-weight: 600 !important;
        color: #1a3d1a !important;
        letter-spacing: 1px;
        text-transform: uppercase;
        padding: 8px 6px 10px !important;
        background: rgba(26, 61, 26, 0.08) !important;
        border: none !important;
        border-bottom: 2px solid #1a3d1a !important;
        text-align: center !important;
    }

    .standings-tbl tr:not(:first-of-type) td {
        border: none !important;
        border-bottom: 1px solid #e0dcc8 !important;
        padding: 9px 6px !important;
        font-size: 13px !important;
        color: #222 !important;
        background: rgba(255, 255, 255, 0.4) !important;
        text-align: center !important;
    }

    .standings-tbl tr:not(:first-of-type):hover td {
        background: #ece8d0 !important;
        cursor: pointer;
    }

    .standings-tbl .td-name {
        text-align: left !important;
        font-weight: 600 !important;
    }

    .standings-tbl a { text-decoration: none; color: #1a3d1a; font-weight: 600; }
    .standings-tbl a:hover { text-decoration: underline; }

    .td-win  { color: #1a6b1a !important; font-weight: 700 !important; }
    .td-draw { color: #888 !important; }
    .td-lose { color: #b03030 !important; font-weight: 700 !important; }

    .td-score {
        font-family: 'Oswald', sans-serif !important;
        font-size: 14px !important;
        font-weight: 700 !important;
        color: #1a3d1a !important;
    }

    /* ===== 우측 패널: 경기 일정 ===== */
    .schedule-tbl {
        width: 100%;
        border-collapse: collapse;
        border: none !important;
    }

    .schedule-tbl tr { border: none !important; }

    .schedule-tbl tr:first-of-type td {
        font-family: 'Oswald', sans-serif;
        font-size: 11px !important;
        font-weight: 600 !important;
        color: #1a3d1a !important;
        letter-spacing: 1.5px;
        text-transform: uppercase;
        padding: 8px 10px 10px !important;
        background: rgba(26, 61, 26, 0.08) !important;
        border: none !important;
        border-bottom: 2px solid #1a3d1a !important;
        text-align: center !important;
    }

    .schedule-tbl tr:not(:first-of-type) td {
        border: none !important;
        border-bottom: 1px solid #e0dcc8 !important;
        padding: 11px 10px !important;
        font-size: 13px !important;
        color: #222 !important;
        background: rgba(255, 255, 255, 0.4) !important;
        text-align: center !important;
    }

    .schedule-tbl tr:not(:first-of-type):hover td {
        background: #ece8d0 !important;
        cursor: pointer;
    }

    .schedule-tbl a { text-decoration: none; color: #1a3d1a; font-weight: 600; }
    .schedule-tbl a:hover { text-decoration: underline; }

    .schedule-empty td {
        color: #aaa !important;
        font-style: italic;
    }

    /* 경기 일정 추가 버튼 */
    .schedule-footer {
        display: flex;
        justify-content: flex-end;
        margin-top: 12px;
    }

    .btn-add-game {
        padding: 8px 20px;
        background: #1a3d1a;
        color: #FFD700;
        border: none;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 12px;
        font-weight: 600;
        letter-spacing: 1px;
        text-decoration: none;
        display: inline-block;
        transition: background 0.15s;
    }

    .btn-add-game:hover { background: #2a5a2a; }

    /* vs 구분자 */
    .vs-badge {
        display: inline-block;
        font-family: 'Oswald', sans-serif;
        font-size: 10px;
        font-weight: 700;
        color: #888;
        letter-spacing: 1px;
        margin: 0 4px;
    }

    /* 하단 목록 버튼 */
    .bottom-bar {
        display: flex;
        justify-content: flex-start;
        margin-top: 20px;
        padding-top: 16px;
        border-top: 1px solid #e0dcc8;
    }

    .btn-list {
        padding: 8px 22px;
        background: rgba(255, 255, 255, 0.6);
        color: #1a3d1a;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 600;
        letter-spacing: 1px;
        text-decoration: none;
        display: inline-block;
        transition: background 0.15s, color 0.15s;
    }

    .btn-list:hover {
        background: #1a3d1a;
        color: #FFD700;
        border-color: #1a3d1a;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">

        <div class="section-header">리그 정보</div>

        <div class="main-wrapper">
            <div class="info-card">
                <div class="info-body">

                    <%-- 좌측: 리그 기본 정보 --%>
                    <div class="left-panel">

                        <div class="profile-card">
                            <div class="profile-name">${league.league_name}</div>
                            <div class="profile-sub">${league.league_location}</div>
                        </div>

                        <div class="panel-title">리그 소개</div>
                        <c:choose>
                            <c:when test="${not empty league.league_content}">
                                <div class="content-box">${league.league_content}</div>
                            </c:when>
                            <c:otherwise>
                                <div class="content-none">소개글이 없습니다.</div>
                            </c:otherwise>
                        </c:choose>

                        <div class="btn-group">
                            <button type="button" class="btn-apply"
                                    id="btn-apply-league" data-league="${league.league_idx}">
                                리그 가입 신청
                            </button>
                            <c:if test="${sessionScope.login.is_admin == 'Y'}">
                                <a href="/League/ManagingForm?league_idx=${league.league_idx}" class="btn-manage">리그 관리</a>
                            </c:if>
                        </div>

                    </div>

                    <%-- 중앙: 팀 순위 --%>
                    <div class="center-panel">

                        <div class="panel-title">팀 순위</div>
                        <table class="standings-tbl">
                            <tr>
                                <td>팀명</td>
                                <td>승</td>
                                <td>무</td>
                                <td>패</td>
                                <td>점수</td>
                            </tr>
                            <c:choose>
                                <c:when test="${not empty teamList}">
                                    <c:forEach var="team" items="${teamList}">
                                    <tr onclick="location.href='/Team/Info?team_idx=${team.team_idx}&keyword='" style="cursor:pointer;">
                                        <td class="td-name">
                                            <a href="/Team/Info?team_idx=${team.team_idx}&keyword=">${team.team_name}</a>
                                        </td>
                                        <td class="td-win">${team.win}</td>
                                        <td class="td-draw">${team.draw}</td>
                                        <td class="td-lose">${team.lose}</td>
                                        <td class="td-score">${team.score}</td>
                                    </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" style="color:#aaa; font-style:italic; padding:14px !important;">소속 팀이 없습니다.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </table>

                    </div>

                    <%-- 우측: 경기 일정 --%>
                    <div class="right-panel">

                        <div class="panel-title">경기 일정</div>
                        <table class="schedule-tbl">
                            <tr>
                                <td>번호</td>
                                <td>날짜</td>
                                <td>시간</td>
                                <td>장소</td>
                                <td>원정</td>
                                <td>vs</td>
                                <td>홈</td>
                            </tr>
                            <c:choose>
                                <c:when test="${not empty gameList}">
                                    <c:forEach var="game" items="${gameList}">
                                    <tr onclick="location.href='/Game/GameInfo?league_idx=${league.league_idx}&game_idx=${game.game_idx}'" style="cursor:pointer;">
                                        <td><a href="/Game/GameInfo?league_idx=${league.league_idx}&game_idx=${game.game_idx}">${game.game_idx}</a></td>
                                        <td>${game.game_date}</td>
                                        <td>${game.game_time}</td>
                                        <td>${game.game_field}</td>
                                        <td>${game.away_team_name}</td>
                                        <td><span class="vs-badge">VS</span></td>
                                        <td>${game.home_team_name}</td>
                                    </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr class="schedule-empty">
                                        <td colspan="7" style="color:#aaa; font-style:italic; padding:16px !important;">경기 일정이 없습니다.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </table>

                        <c:if test="${sessionScope.login.is_admin == 'Y'}">
                            <div class="schedule-footer">
                                <a href="/Game/AddGameForm?league_idx=${map.league_idx}" class="btn-add-game">+ 경기 일정 추가</a>
                            </div>
                        </c:if>

                    </div>

                </div>

                <div class="bottom-bar">
                    <a href="/League/List?nowpage=1&keyword=" class="btn-list">목록</a>
                </div>

            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

    <c:if test="${map.checkalert == 'true'}">
        <script>alert('권한이 없습니다.');</script>
    </c:if>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const applyBtn = document.getElementById('btn-apply-league');
            if (applyBtn) {
                applyBtn.addEventListener('click', function() {
                    const leagueIdx = this.getAttribute('data-league');

                    fetch('/League/CheckManagerTeams', { method: 'POST' })
                    .then(response => response.json())
                    .then(teamList => {
                        if (teamList.length === 0) {
                            alert('가입 신청 가능한 팀이 없습니다. 본인이 감독인 팀이 있는지 확인해주세요.');
                            return;
                        }

                        let selectedTeamIdx = null;

                        if (teamList.length === 1) {
                            if (!confirm('[' + teamList[0].team_name + '] 팀으로 이 리그에 가입 신청을 하시겠습니까?')) return;
                            selectedTeamIdx = teamList[0].team_idx;
                            applyForLeague(leagueIdx, selectedTeamIdx);
                        } else {
                            let message = "가입 신청할 팀의 번호를 입력해주세요:\n";
                            teamList.forEach((team, index) => {
                                message += '\n[' + (index + 1) + '] ' + team.team_name;
                            });
                            const userInput = prompt(message);
                            if (!userInput) return;
                            const selectedIndex = parseInt(userInput.trim()) - 1;
                            if (isNaN(selectedIndex) || selectedIndex < 0 || selectedIndex >= teamList.length) {
                                alert('올바른 번호를 선택해주세요.');
                                return;
                            }
                            selectedTeamIdx = teamList[selectedIndex].team_idx;
                            applyForLeague(leagueIdx, selectedTeamIdx);
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('팀 정보를 가져오는 중 오류가 발생했습니다. 로그인을 확인해주세요.');
                    });
                });
            }

            function applyForLeague(leagueIdx, teamIdx) {
                if (!leagueIdx || !teamIdx) { alert('필수 정보가 누락되었습니다.'); return; }
                const formData = new URLSearchParams();
                formData.append('league_idx', leagueIdx);
                formData.append('team_idx', teamIdx);
                fetch('/League/ApplyTeam', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: formData
                })
                .then(response => response.text())
                .then(data => {
                    if (data.trim() === "success") {
                        alert('리그 가입 신청이 완료되었습니다!');
                        location.reload();
                    } else if (data.trim() === "already") {
                        alert('이미 이 리그에 가입 신청 중이거나 가입된 팀입니다.');
                    } else {
                        alert('신청 처리 중 오류가 발생했습니다.');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('서버 통신 오류가 발생했습니다.');
                });
            }
        });
    </script>

</body>
</html>
