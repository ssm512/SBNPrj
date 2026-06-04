<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="jakarta.tags.core" %>

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

    /* ===== 전체 그리드 ===== */
    .main-wrapper {
        display: grid;
        grid-template-columns: 210px 1fr;
        gap: 20px;
        max-width: 1160px;
        margin: 0 auto;
        align-items: start;
    }

    /* ===== 카드 공통 ===== */
    .left-card, .right-card {
        background: rgba(245, 245, 220, 0.88);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 20px;
    }

    /* ===== 세그먼트 컨트롤 (타자 / 투수) ===== */
    .toggle-btn-group {
        display: flex;
        border: 1.5px solid #1a3d1a;
        border-radius: 3px;
        overflow: hidden;
        margin-bottom: 16px;
    }

    .toggle-btn {
        flex: 1;
        padding: 9px;
        background: transparent;
        border: none;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 600;
        color: #1a3d1a;
        cursor: pointer;
        letter-spacing: 1px;
        transition: background 0.15s, color 0.15s;
    }

    .toggle-btn + .toggle-btn {
        border-left: 1.5px solid #1a3d1a;
    }

    .toggle-btn.active {
        background: #1a3d1a;
        color: #FFD700;
    }

    /* ===== 프로필 카드 ===== */
    .profile-card {
        background: #1a3d1a;
        border-radius: 3px;
        padding: 14px 16px;
        text-align: center;
        margin-bottom: 16px;
    }

    .profile-name {
        font-family: 'Oswald', sans-serif;
        font-size: 18px;
        font-weight: 700;
        color: #FFD700;
        letter-spacing: 1px;
    }

    .profile-elite {
        font-size: 11px;
        color: rgba(255, 215, 0, 0.65);
        margin-top: 4px;
        font-family: 'Oswald', sans-serif;
        letter-spacing: 1px;
    }

    /* ===== 소속팀 목록 ===== */
    .team-list-title {
        font-family: 'Oswald', sans-serif;
        font-size: 12px;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 1px;
        text-align: center;
        padding-bottom: 8px;
        border-bottom: 1px solid #c8c4aa;
        margin-bottom: 10px;
    }

    .team-list-item {
        padding: 8px 10px;
        font-size: 13px;
        color: #333;
        border-radius: 3px;
        cursor: pointer;
        transition: background-color 0.2s;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .team-list-item:hover { background-color: #e8e8d8; }

    .manager-badge {
        font-size: 10px;
        background: #FFD700;
        color: #1a3d1a;
        padding: 1px 7px;
        border-radius: 2px;
        font-weight: 700;
        font-family: 'Oswald', sans-serif;
        letter-spacing: 0.5px;
        white-space: nowrap;
    }

    /* ===== 카드 서브 헤더 ===== */
    .card-sub-header {
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 700;
        color: #FFD700;
        letter-spacing: 2px;
        background-color: #1a3d1a;
        padding: 7px 14px;
        border-radius: 3px;
        margin-bottom: 12px;
        position: relative;
        overflow: hidden;
    }

    .card-sub-header::after {
        content: '';
        position: absolute;
        top: -15px; right: -10px;
        width: 70px; height: 70px;
        background: repeating-linear-gradient(
            45deg, transparent, transparent 4px,
            rgba(255, 215, 0, 0.12) 4px, rgba(255, 215, 0, 0.12) 8px
        );
        pointer-events: none;
    }

    /* ===== 팀 필터 버튼 ===== */
    .team-filter {
        display: flex;
        gap: 6px;
        flex-wrap: wrap;
        margin-bottom: 20px;
    }

    .team-filter-btn {
        padding: 5px 16px;
        border: 1.5px solid #1a3d1a;
        border-radius: 3px;
        background: transparent;
        font-family: 'Oswald', sans-serif;
        font-size: 12px;
        font-weight: 600;
        color: #1a3d1a;
        cursor: pointer;
        letter-spacing: 0.5px;
        transition: background 0.15s, color 0.15s;
    }

    .team-filter-btn:hover,
    .team-filter-btn.active {
        background: #1a3d1a;
        color: #FFD700;
    }

    /* ===== KPI 카드 그리드 ===== */
    .kpi-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 10px;
        margin-bottom: 24px;
    }

    /* ★ KPI 박스만 각진 모서리 유지 ★ */
    .kpi-card {
        background: #1a3d1a;
        border-radius: 3px;
        padding: 14px 8px;
        text-align: center;
    }

    .kpi-label {
        font-family: 'Oswald', sans-serif;
        font-size: 10px;
        color: rgba(255, 215, 0, 0.65);
        letter-spacing: 1px;
        margin-bottom: 6px;
        text-transform: uppercase;
    }

    .kpi-value {
        font-family: 'Oswald', sans-serif;
        font-size: 22px;
        font-weight: 700;
        color: #FFD700;
    }

    /* ===== 테이블 섹션 타이틀 ===== */
    .table-section-title {
        font-family: 'Oswald', sans-serif;
        font-size: 12px;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 1px;
        margin-bottom: 10px;
        padding-bottom: 6px;
        border-bottom: 1px solid #c8c4aa;
        display: block;
    }

    /* ===== 상세 테이블 ===== */
    .table-scroll {
        overflow-x: auto;
        margin-bottom: 8px;
    }

    .stats-table {
        width: 100%;
        border-collapse: collapse;
        border: none !important;
    }

    .stats-table thead tr { border: none !important; }

    .stats-table thead th {
        font-family: 'Oswald', sans-serif;
        font-size: 11px !important;
        font-weight: 600 !important;
        color: #1a3d1a !important;
        letter-spacing: 1px;
        text-transform: uppercase;
        padding: 8px 10px 10px !important;
        background: rgba(26, 61, 26, 0.08) !important;
        border: none !important;
        border-bottom: 2px solid #1a3d1a !important;
        text-align: center !important;
        white-space: nowrap;
    }

    .stats-table tbody tr { border: none !important; }

    .stats-table tbody td {
        padding: 11px 10px !important;
        border: none !important;
        border-bottom: 1px solid #c8c4aa !important;
        font-size: 13px !important;
        color: #222 !important;
        text-align: center !important;
        white-space: nowrap;
        background: rgba(255, 255, 255, 0.4) !important;
    }

    .stats-table tbody tr:hover td {
        background: rgba(26, 61, 26, 0.06) !important;
    }

    .stats-table tbody td:first-child {
        font-family: 'Oswald', sans-serif;
        font-weight: 700 !important;
        color: #1a3d1a !important;
        letter-spacing: 0.5px;
    }

</style>

</head>
<body>
    <%@include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">

        <div class="section-header">선수 기록</div>

        <div class="main-wrapper">

            <%-- ========== 좌측 사이드 ========== --%>
            <div class="left-card">

                <div class="toggle-btn-group">
                    <button type="button" class="toggle-btn" id="hitBtn">타자</button>
                    <button type="button" class="toggle-btn" id="pitchBtn">투수</button>
                </div>

                <div class="profile-card">
                    <div class="profile-name">${ member.member_name }</div>
                    <div class="profile-elite">${ member.elite }</div>
                </div>

                <div class="team-list-title">소속팀</div>
                <c:forEach var="team" items="${ teamList }">
                    <div class="team-list-item"
                         onclick='location.href="/Team/Info?team_idx=${ team.team_idx }&keyword="'>
                        <span>${ team.team_name }</span>
                        <c:if test="${ member.member_idx eq team.team_manager }">
                            <span class="manager-badge">감독</span>
                        </c:if>
                    </div>
                </c:forEach>

            </div>

            <%-- ========== 우측 기록 영역 ========== --%>
            <div class="right-card">

                <%-- 팀 필터 버튼 --%>
                <div class="team-filter">
                    <button type="button"
                            class="team-filter-btn team-stats-btn ${ empty map.team_idx ? 'active' : '' }"
                            data-team-idx="">통산</button>
                    <c:forEach var="team" items="${ teamList }">
                        <button type="button"
                                class="team-filter-btn team-stats-btn ${ map.team_idx eq team.team_idx ? 'active' : '' }"
                                data-team-idx="${ team.team_idx }">${ team.team_name }</button>
                    </c:forEach>
                </div>

                <%-- ===== 타자 기록 ===== --%>
                <div id="hitArea">

                    <div class="card-sub-header">타자 주요 지표</div>

                    <div class="kpi-grid">
                        <div class="kpi-card">
                            <div class="kpi-label">타율</div>
                            <div class="kpi-value">${ hitstats.avg }</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-label">경기</div>
                            <div class="kpi-value">${ hitstats.gameCount }</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-label">안타</div>
                            <div class="kpi-value">${ hitstats.totalHit }</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-label">타점</div>
                            <div class="kpi-value">${ hitstats.getScore }</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-label">사사구</div>
                            <div class="kpi-value">${ hitstats.bbCnt }</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-label">장타율</div>
                            <div class="kpi-value">${ hitstats.slg }</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-label">출루율</div>
                            <div class="kpi-value">${ hitstats.obp }</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-label">OPS</div>
                            <div class="kpi-value">${ hitstats.ops }</div>
                        </div>
                    </div>

                    <span class="table-section-title">타격 상세</span>
                    <div class="table-scroll">
                        <table class="stats-table">
                            <thead>
                                <tr>
                                    <th>시즌</th><th>경기</th><th>타율</th><th>타석</th>
                                    <th>타수</th><th>안타</th><th>1루타</th><th>2루타</th>
                                    <th>3루타</th><th>홈런</th><th>루타</th><th>타점</th>
                                    <th>사사구</th><th>삼진</th><th>장타율</th><th>출루율</th>
                                    <th>OPS</th><th>희타/희비</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>통산</td>
                                    <td>${ hitstats.gameCount }</td>
                                    <td>${ hitstats.avg }</td>
                                    <td>${ hitstats.pa }</td>
                                    <td>${ hitstats.atBat }</td>
                                    <td>${ hitstats.totalHit }</td>
                                    <td>${ hitstats.singleHit }</td>
                                    <td>${ hitstats.doubleHit }</td>
                                    <td>${ hitstats.tripleHit }</td>
                                    <td>${ hitstats.homeRun }</td>
                                    <td>${ hitstats.totalBase }</td>
                                    <td>${ hitstats.getScore }</td>
                                    <td>${ hitstats.bbCnt }</td>
                                    <td>${ hitstats.strikeOut }</td>
                                    <td>${ hitstats.slg }</td>
                                    <td>${ hitstats.obp }</td>
                                    <td>${ hitstats.ops }</td>
                                    <td>${ hitstats.sac }</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>

                <%-- ===== 투수 기록 ===== --%>
                <div id="pitchArea" style="display:none;">

                    <div class="card-sub-header">투수 주요 지표</div>

                    <div class="kpi-grid">
                        <div class="kpi-card">
                            <div class="kpi-label">방어율</div>
                            <div class="kpi-value">${ pitchstats.era }</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-label">승</div>
                            <div class="kpi-value">${ pitchstats.win }</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-label">패</div>
                            <div class="kpi-value">${ pitchstats.lose }</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-label">탈삼진</div>
                            <div class="kpi-value">${ pitchstats.strikeOut }</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-label">이닝</div>
                            <div class="kpi-value">${ pitchstats.inning }</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-label">사사구</div>
                            <div class="kpi-value">${ pitchstats.bbCnt }</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-label">피안타</div>
                            <div class="kpi-value">${ pitchstats.hitAllowed }</div>
                        </div>
                        <div class="kpi-card">
                            <div class="kpi-label">WHIP</div>
                            <div class="kpi-value">${ pitchstats.whip }</div>
                        </div>
                    </div>

                    <span class="table-section-title">투구 상세</span>
                    <div class="table-scroll">
                        <table class="stats-table">
                            <thead>
                                <tr>
                                    <th>시즌</th><th>경기</th><th>방어율</th><th>승</th>
                                    <th>패</th><th>세이브</th><th>홀드</th><th>타자</th>
                                    <th>타수</th><th>이닝</th><th>피안타</th><th>피홈런</th>
                                    <th>사사구</th><th>희타/희비</th><th>탈삼진</th><th>실점</th>
                                    <th>자책점</th><th>WHIP</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>통산</td>
                                    <td>${ pitchstats.gameCount }</td>
                                    <td>${ pitchstats.era }</td>
                                    <td>${ pitchstats.win }</td>
                                    <td>${ pitchstats.lose }</td>
                                    <td>${ pitchstats.save }</td>
                                    <td>${ pitchstats.hold }</td>
                                    <td>${ pitchstats.hitter }</td>
                                    <td>${ pitchstats.hitterAtBat }</td>
                                    <td>${ pitchstats.inning }</td>
                                    <td>${ pitchstats.hitAllowed }</td>
                                    <td>${ pitchstats.homeRunAllowed }</td>
                                    <td>${ pitchstats.bbCnt }</td>
                                    <td>${ pitchstats.sac }</td>
                                    <td>${ pitchstats.strikeOut }</td>
                                    <td>${ pitchstats.totalScore }</td>
                                    <td>${ pitchstats.earnedRun }</td>
                                    <td>${ pitchstats.whip }</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>

            </div>

        </div>

    </div>

    <%@include file="/WEB-INF/include/footer.jsp" %>

    <script>

    const hitBtnEl    = document.querySelector('#hitBtn')
    const pitchBtnEl  = document.querySelector('#pitchBtn')
    const hitAreaEl   = document.querySelector('#hitArea')
    const pitchAreaEl = document.querySelector('#pitchArea')

    hitBtnEl.classList.add('active')

    hitBtnEl.addEventListener('click', function() {
        hitAreaEl.style.display   = 'block'
        pitchAreaEl.style.display = 'none'
        hitBtnEl.classList.add('active')
        pitchBtnEl.classList.remove('active')
    })

    pitchBtnEl.addEventListener('click', function() {
        hitAreaEl.style.display   = 'none'
        pitchAreaEl.style.display = 'block'
        pitchBtnEl.classList.add('active')
        hitBtnEl.classList.remove('active')
    })

    document.querySelectorAll('.team-stats-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            const teamIdx   = this.getAttribute('data-team-idx')
            const memberIdx = '${ member.member_idx }'
            location.href = "/Member/Stats?member_idx=" + memberIdx + "&team_idx=" + teamIdx
        })
    })

    </script>
</body>
</html>
