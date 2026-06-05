<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 선수 기록</title>
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
    .stats-card {
        background: rgba(249, 249, 234, 0.93);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 28px 32px;
    }

    /* ===== 2분할 레이아웃 ===== */
    .stats-body {
        display: grid;
        grid-template-columns: 200px 1fr;
        gap: 32px;
        align-items: start;
    }

    /* ===== 좌측 패널 ===== */

    /* 타자/투수 토글 */
    .hit-pitch-toggle {
        display: flex;
        border: 1.5px solid #1a3d1a;
        border-radius: 3px;
        overflow: hidden;
        margin-bottom: 14px;
    }

    #hitBtn, #pitchBtn {
        flex: 1;
        padding: 8px 0;
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
        margin: 0;
    }

    #pitchBtn { border-left: 1.5px solid #1a3d1a; }

    #hitBtn.active, #pitchBtn.active {
        background: #1a3d1a;
        color: #FFD700;
    }

    /* 프로필 사진 박스 */
    .profile-box {
        background: #1a3d1a;
        border-radius: 3px;
        padding: 14px;
        text-align: center;
        margin-bottom: 12px;
    }

    .profile-photo {
        width: 160px;
        height: 160px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid rgba(255, 215, 0, 0.5);
        display: block;
        margin: 0 auto;
    }

    /* 선수명 + 선출 배지 */
    .profile-badge {
        background: rgba(26, 61, 26, 0.06);
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        padding: 8px 12px;
        text-align: center;
        font-size: 14px;
        font-weight: 600;
        color: #1a3d1a;
        margin-bottom: 12px;
    }

    /* 소속팀 섹션 타이틀 */
    .team-section-title {
        font-family: 'Oswald', sans-serif;
        font-size: 11px;
        font-weight: 700;
        color: #1a3d1a;
        letter-spacing: 1.5px;
        text-transform: uppercase;
        padding-bottom: 8px;
        border-bottom: 1px solid #c8c4aa;
        margin-bottom: 6px;
    }

    /* 소속팀 목록 */
    .myteamlist {
        width: 100%;
        border-collapse: collapse;
        border: none !important;
        margin: 0;
    }

    .myteamlist tr { border: none !important; }

    .myteamlist tr:first-of-type td {
        display: none;
    }

    .myteamlist tr:not(:first-of-type) td {
        border: none !important;
        border-bottom: 1px solid #ece8d0 !important;
        padding: 9px 6px !important;
        font-size: 14px !important;
        color: #222 !important;
        background: transparent !important;
    }

    .myteamlist tr:not(:first-of-type):hover td {
        background: #ece8d0 !important;
        cursor: pointer;
    }

    /* ===== 우측: 팀 필터 버튼 ===== */
    .team-btn-wrap {
        display: flex;
        flex-wrap: wrap;
        gap: 6px;
        margin-bottom: 20px;
        padding-bottom: 16px;
        border-bottom: 1px solid #c8c4aa;
    }

    .team-stats-btn {
        padding: 6px 16px;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        background: rgba(255, 255, 255, 0.6);
        color: #1a3d1a;
        font-family: 'Oswald', sans-serif;
        font-size: 12px;
        font-weight: 600;
        letter-spacing: 0.5px;
        cursor: pointer;
        transition: background 0.15s, color 0.15s;
        height: auto;
        width: auto;
        margin: 0;
        border-radius: 3px;
    }

    .team-stats-btn:hover {
        background: #1a3d1a;
        color: #FFD700;
        border-color: #1a3d1a;
    }

    .team-stats-btn.active {
        background: #FFD700;
        color: #1a3d1a;
        border-color: #FFD700;
        font-weight: 700;
    }

    /* ===== 주요 스탯 요약 ===== */
    .stats-summary {
        width: 100%;
        border-collapse: collapse;
        border: none !important;
        margin-bottom: 16px;
    }

    .stats-summary td {
        border: none !important;
        padding: 16px 12px !important;
        text-align: center;
        background: rgba(26, 61, 26, 0.05) !important;
        border-right: 1px solid #d8d4bc !important;
        border-bottom: 1px solid #d8d4bc !important;
    }

    .stats-summary td:last-child { border-right: none !important; }
    .stats-summary tr:last-child td { border-bottom: none !important; }

    /* 스탯 항목명 */
    .stats-summary .stat-label {
        font-family: 'Oswald', sans-serif;
        font-size: 11px;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 1px;
        text-transform: uppercase;
        display: block;
        margin-bottom: 4px;
    }

    /* 스탯 값 */
    .stats-summary .stat-val {
        font-family: 'Oswald', sans-serif;
        font-size: 22px;
        font-weight: 700;
        color: #1a3d1a;
        display: block;
    }

    /* ===== 상세 스탯 테이블 ===== */
    .stats-detail {
        width: 100%;
        border-collapse: collapse;
        border: none !important;
        margin-bottom: 12px;
    }

    .stats-detail tr { border: none !important; }

    /* 헤더 행 */
    .stats-detail tr:first-of-type td {
        font-family: 'Oswald', sans-serif;
        font-size: 14px !important;
        font-weight: 600 !important;
        color: #1a3d1a !important;
        letter-spacing: 1px;
        text-transform: uppercase;
        padding: 8px 10px !important;
        background: rgba(26, 61, 26, 0.08) !important;
        border: none !important;
        border-bottom: 2px solid #1a3d1a !important;
        text-align: center !important;
    }

    /* 데이터 행 */
    .stats-detail tr:not(:first-of-type) td {
        border: none !important;
        border-bottom: 1px solid #e0dcc8 !important;
        padding: 11px 10px !important;
        font-size: 14px !important;
        color: #222 !important;
        background: rgba(255, 255, 255, 0.4) !important;
        text-align: center !important;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">

        <div class="section-header">선수 기록</div>

        <div class="main-wrapper">
            <div class="stats-card">
                <div class="stats-body">

                    <%-- 좌측: 프로필 + 소속팀 --%>
                    <div class="left-panel">

                        <div class="hit-pitch-toggle">
                            <input type="button" id="hitBtn"   value="타자" />
                            <input type="button" id="pitchBtn" value="투수" />
                        </div>

                        <div class="profile-box">
                            <c:choose>
                                <c:when test="${not empty fileInfo}">
                                    <img class="profile-photo" src="/sbndata/${fileInfo.sfile_name}"
                                         onerror="this.src='/img/sbndefaultimg.png'" />
                                </c:when>
                                <c:otherwise>
                                    <img class="profile-photo" src="/img/sbndefaultimg.png" />
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="profile-badge">${member.member_name} [${member.elite}]</div>

                        <div class="team-section-title">소속 팀</div>
                        <table class="myteamlist">
                            <tr><td>소속팀목록</td></tr>
                            <c:forEach var="team" items="${teamList}">
                            <tr onclick='location.href="/Team/Info?team_idx=${team.team_idx}&keyword="' style="cursor:pointer;">
                                <td>${team.team_name}
                                    <b>${member.member_idx eq team.team_manager ? ' [감독]' : ''}</b>
                                </td>
                            </tr>
                            </c:forEach>
                        </table>

                    </div>

                    <%-- 우측: 기록 --%>
                    <div class="right-panel">

                        <%-- 팀 필터 버튼 --%>
                        <div class="team-btn-wrap">
                            <input type="button" class="team-stats-btn ${empty map.team_idx ? 'active' : ''}" value="통산" data-team-idx="" />
                            <c:forEach var="team" items="${teamList}">
                            <input type="button" class="team-stats-btn ${map.team_idx eq team.team_idx ? 'active' : ''}"
                                   value="${team.team_name}" data-team-idx="${team.team_idx}" />
                            </c:forEach>
                        </div>

                        <%-- 타자 기록 --%>
                        <div id="hitArea">

                            <table class="stats-summary">
                                <tr>
                                    <td><span class="stat-label">타율</span><span class="stat-val">${hitstats.avg}</span></td>
                                    <td><span class="stat-label">경기 수</span><span class="stat-val">${hitstats.gameCount}</span></td>
                                    <td><span class="stat-label">총 안타</span><span class="stat-val">${hitstats.totalHit}</span></td>
                                    <td><span class="stat-label">타점</span><span class="stat-val">${hitstats.getScore}</span></td>
                                </tr>
                                <tr>
                                    <td><span class="stat-label">사사구</span><span class="stat-val">${hitstats.bbCnt}</span></td>
                                    <td><span class="stat-label">장타율</span><span class="stat-val">${hitstats.slg}</span></td>
                                    <td><span class="stat-label">출루율</span><span class="stat-val">${hitstats.obp}</span></td>
                                    <td><span class="stat-label">OPS</span><span class="stat-val">${hitstats.ops}</span></td>
                                </tr>
                            </table>

                            <table class="stats-detail">
                                <tr>
                                    <td>시즌</td><td>경기 수</td><td>타율</td><td>타석</td><td>타수</td>
                                    <td>총 안타</td><td>1루타</td><td>2루타</td><td>3루타</td><td>홈런</td>
                                </tr>
                                <tr>
                                    <td>통산</td>
                                    <td>${hitstats.gameCount}</td><td>${hitstats.avg}</td>
                                    <td>${hitstats.pa}</td><td>${hitstats.atBat}</td>
                                    <td>${hitstats.totalHit}</td><td>${hitstats.singleHit}</td>
                                    <td>${hitstats.doubleHit}</td><td>${hitstats.tripleHit}</td>
                                    <td>${hitstats.homeRun}</td>
                                </tr>
                            </table>

                            <table class="stats-detail">
                                <tr>
                                    <td>시즌</td><td>루타</td><td>타점</td><td>사사구</td><td>삼진</td>
                                    <td>장타율</td><td>출루율</td><td>OPS</td><td>희타/희비</td><td>임시</td>
                                </tr>
                                <tr>
                                    <td>통산</td>
                                    <td>${hitstats.totalBase}</td><td>${hitstats.getScore}</td>
                                    <td>${hitstats.bbCnt}</td><td>${hitstats.strikeOut}</td>
                                    <td>${hitstats.slg}</td><td>${hitstats.obp}</td>
                                    <td>${hitstats.ops}</td><td>${hitstats.sac}</td>
                                    <td>-</td>
                                </tr>
                            </table>

                        </div><%-- hitArea End --%>

                        <%-- 투수 기록 --%>
                        <div id="pitchArea" style="display:none;">

                            <table class="stats-summary">
                                <tr>
                                    <td><span class="stat-label">방어율</span><span class="stat-val">${pitchstats.era}</span></td>
                                    <td><span class="stat-label">승</span><span class="stat-val">${pitchstats.win}</span></td>
                                    <td><span class="stat-label">패</span><span class="stat-val">${pitchstats.lose}</span></td>
                                    <td><span class="stat-label">탈삼진</span><span class="stat-val">${pitchstats.strikeOut}</span></td>
                                </tr>
                                <tr>
                                    <td><span class="stat-label">이닝</span><span class="stat-val">${pitchstats.inning}</span></td>
                                    <td><span class="stat-label">사사구</span><span class="stat-val">${pitchstats.bbCnt}</span></td>
                                    <td><span class="stat-label">피안타</span><span class="stat-val">${pitchstats.hitAllowed}</span></td>
                                    <td><span class="stat-label">WHIP</span><span class="stat-val">${pitchstats.whip}</span></td>
                                </tr>
                            </table>

                            <table class="stats-detail">
                                <tr>
                                    <td>시즌</td><td>경기 수</td><td>방어율</td><td>승</td><td>패</td>
                                    <td>세이브</td><td>홀드</td><td>타자</td><td>타수</td><td>이닝</td>
                                </tr>
                                <tr>
                                    <td>통산</td>
                                    <td>${pitchstats.gameCount}</td><td>${pitchstats.era}</td>
                                    <td>${pitchstats.win}</td><td>${pitchstats.lose}</td>
                                    <td>${pitchstats.save}</td><td>${pitchstats.hold}</td>
                                    <td>${pitchstats.hitter}</td><td>${pitchstats.hitterAtBat}</td>
                                    <td>${pitchstats.inning}</td>
                                </tr>
                            </table>

                            <table class="stats-detail">
                                <tr>
                                    <td>시즌</td><td>피안타</td><td>피홈런</td><td>사사구</td><td>희타/희비</td>
                                    <td>탈삼진</td><td>실점</td><td>자책점</td><td>WHIP</td><td>임시</td>
                                </tr>
                                <tr>
                                    <td>통산</td>
                                    <td>${pitchstats.hitAllowed}</td><td>${pitchstats.homeRunAllowed}</td>
                                    <td>${pitchstats.bbCnt}</td><td>${pitchstats.sac}</td>
                                    <td>${pitchstats.strikeOut}</td><td>${pitchstats.totalScore}</td>
                                    <td>${pitchstats.earnedRun}</td><td>${pitchstats.whip}</td>
                                    <td>-</td>
                                </tr>
                            </table>

                        </div><%-- pitchArea End --%>

                    </div>

                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

    <script>

        const hitBtnEl    = document.querySelector('#hitBtn');
        const pitchBtnEl  = document.querySelector('#pitchBtn');
        const hitAreaEl   = document.querySelector('#hitArea');
        const pitchAreaEl = document.querySelector('#pitchArea');

        // 초기 active 설정
        hitBtnEl.classList.add('active');

        hitBtnEl.addEventListener('click', function () {
            hitAreaEl.style.display   = 'block';
            pitchAreaEl.style.display = 'none';
            hitBtnEl.classList.add('active');
            pitchBtnEl.classList.remove('active');
        });

        pitchBtnEl.addEventListener('click', function () {
            hitAreaEl.style.display   = 'none';
            pitchAreaEl.style.display = 'block';
            pitchBtnEl.classList.add('active');
            hitBtnEl.classList.remove('active');
        });

        document.querySelectorAll('.team-stats-btn').forEach(btn => {
            btn.addEventListener('click', function () {
                const teamIdx   = this.getAttribute('data-team-idx');
                const memberIdx = '${member.member_idx}';
                location.href = '/Member/Stats?member_idx=' + memberIdx + '&team_idx=' + teamIdx;
            });
        });

    </script>
</body>
</html>
