<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 리그 관리</title>
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
    .managing-card {
        background: rgba(249, 249, 234, 0.93);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 28px 32px;
    }

    /* ===== 2분할 레이아웃 ===== */
    .managing-body {
        display: flex;
        gap: 32px;
        align-items: flex-start;
    }

    .edit-section   { flex: 0 0 320px; }
    .status-section { flex: 1; }

    /* ===== 공통: 소섹션 타이틀 ===== */
    .subsection-title {
        font-family: 'Oswald', sans-serif;
        font-size: 14px;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 1.5px;
        padding: 0 0 8px 12px;
        border-left: 3px solid #FFD700;
        margin-bottom: 16px;
    }

    /* ===== 좌측: 리그 정보 수정 폼 ===== */
    .form-group {
        margin-bottom: 14px;
    }

    .form-label {
        font-family: 'Oswald', sans-serif;
        font-size: 11px;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 1px;
        text-transform: uppercase;
        display: block;
        margin-bottom: 5px;
    }

    .form-input {
        width: 100%;
        padding: 9px 12px;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-size: 13px;
        color: #333;
        background: rgba(255, 255, 255, 0.85);
        outline: none;
        box-sizing: border-box;
        transition: border-color 0.15s;
    }

    .form-input:focus { border-color: #1a3d1a; }

    .form-textarea {
        width: 100%;
        padding: 10px 12px;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-size: 13px;
        color: #333;
        background: rgba(255, 255, 255, 0.85);
        outline: none;
        box-sizing: border-box;
        resize: vertical;
        min-height: 140px;
        font-family: inherit;
        line-height: 1.6;
        transition: border-color 0.15s;
    }

    .form-textarea:focus { border-color: #1a3d1a; }

    /* ===== 우측: 가입 신청 현황 테이블 ===== */
    .status-tbl {
        width: 100%;
        border-collapse: collapse;
        border: none !important;
    }

    .status-tbl tr { border: none !important; }

    .status-tbl tr:first-of-type td {
        font-family: 'Oswald', sans-serif;
        font-size: 14px !important;
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

    .status-tbl tr:not(:first-of-type) td {
        border: none !important;
        border-bottom: 1px solid #e0dcc8 !important;
        padding: 11px 10px !important;
        font-size: 14px !important;
        color: #222 !important;
        background: rgba(255, 255, 255, 0.4) !important;
        text-align: center !important;
    }

    .status-tbl tr:not(:first-of-type):hover td {
        background: #ece8d0 !important;
    }

    /* 승인/거절 버튼 */
    .btn-approve {
        display: inline-block;
        padding: 4px 12px;
        background: transparent;
        color: #1a3d1a;
        border: 1.5px solid #1a3d1a;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 12px;
        font-weight: 600;
        letter-spacing: 0.5px;
        cursor: pointer;
        text-decoration: none;
        transition: all 0.15s;
    }

    .btn-approve:hover {
        background: #1a3d1a;
        color: #FFD700;
    }

    .btn-reject {
        display: inline-block;
        padding: 4px 12px;
        background: transparent;
        color: #b03030;
        border: 1.5px solid #b03030;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 12px;
        font-weight: 600;
        letter-spacing: 0.5px;
        cursor: pointer;
        text-decoration: none;
        transition: all 0.15s;
    }

    .btn-reject:hover {
        background: #b03030;
        color: #fff;
    }

    /* ===== 하단 버튼 바 ===== */
    .bottom-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 24px;
        padding-top: 18px;
        border-top: 1px solid #e0dcc8;
    }

    .btn-list {
        padding: 9px 22px;
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

    .btn-submit {
        padding: 10px 32px;
        background: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 14px;
        font-weight: 700;
        letter-spacing: 1px;
        cursor: pointer;
        transition: background 0.15s;
    }

    .btn-submit:hover { background: #e6c200; }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">

        <div class="section-header">리그 관리</div>

        <div class="main-wrapper">
            <div class="managing-card">

                <form action="/League/Update" method="post">
                <input type="hidden" name="league_idx" value="${league.league_idx}" />

                <div class="managing-body">

                    <%-- 좌측: 리그 정보 수정 --%>
                    <section class="edit-section">
                        <div class="subsection-title">리그 정보 수정</div>

                        <div class="form-group">
                            <label class="form-label">리그 이름</label>
                            <input class="form-input" type="text" name="league_name"
                                   value="${league.league_name}" placeholder="리그 이름" />
                        </div>
                        <div class="form-group">
                            <label class="form-label">연고지</label>
                            <input class="form-input" type="text" name="league_location"
                                   value="${league.league_location}" placeholder="연고지" />
                        </div>
                        <div class="form-group">
                            <label class="form-label">리그 소개</label>
                            <textarea class="form-textarea" name="league_content"
                                      placeholder="리그 소개글을 입력하세요.">${league.league_content}</textarea>
                        </div>
                    </section>

                    <%-- 우측: 가입 신청 현황 --%>
                    <section class="status-section">
                        <div class="subsection-title">리그 가입 신청 현황</div>

                        <table class="status-tbl">
                            <tr>
                                <td>팀 이름</td>
                                <td>감독</td>
                                <td>인원</td>
                                <td>연고지</td>
                                <td>승인</td>
                                <td>거절</td>
                            </tr>
                            <c:choose>
                                <c:when test="${not empty signTeamList}">
                                    <c:forEach var="team" items="${signTeamList}">
                                    <tr>
                                        <td>${team.team_name}</td>
                                        <td>${team.manager_name}</td>
                                        <td>${team.number_of_members}명</td>
                                        <td>${team.team_location}</td>
                                        <td>
                                            <a href="#" class="btn-approve"
                                               data-league="${param.league_idx}"
                                               data-team="${team.team_idx}">승인</a>
                                        </td>
                                        <td>
                                            <a href="#" class="btn-reject"
                                               data-league="${param.league_idx}"
                                               data-team="${team.team_idx}">거절</a>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" style="color:#aaa; font-style:italic; padding:16px !important;">리그 가입 신청 팀이 없습니다.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </table>
                    </section>

                </div>

                <div class="bottom-bar">
                    <a href="/League/List?nowpage=1&keyword=" class="btn-list">목록</a>
                    <button type="submit" class="btn-submit">수정 완료</button>
                </div>

                </form>

            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

    <script>
        document.addEventListener("DOMContentLoaded", function() {

            // 승인(O) 버튼
            document.querySelectorAll('.btn-approve').forEach(button => {
                button.addEventListener('click', function(e) {
                    e.preventDefault();
                    if (!confirm("이 팀의 가입을 승인하시겠습니까?")) return;
                    const leagueIdx = this.getAttribute('data-league');
                    const teamIdx   = this.getAttribute('data-team');
                    sendRequest('/League/ApproveTeam', leagueIdx, teamIdx, this);
                });
            });

            // 거절(X) 버튼
            document.querySelectorAll('.btn-reject').forEach(button => {
                button.addEventListener('click', function(e) {
                    e.preventDefault();
                    if (!confirm("이 팀의 가입 신청을 거절하시겠습니까?")) return;
                    const leagueIdx = this.getAttribute('data-league');
                    const teamIdx   = this.getAttribute('data-team');
                    sendRequest('/League/RejectTeam', leagueIdx, teamIdx, this);
                });
            });

            function sendRequest(url, leagueIdx, teamIdx, btnElement) {
                const formData = new URLSearchParams();
                formData.append('league_idx', leagueIdx);
                formData.append('team_idx',   teamIdx);
                fetch(url, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: formData
                })
                .then(response => response.text())
                .then(data => {
                    if (data.trim() === "success") {
                        alert("처리가 완료되었습니다.");
                        const row = btnElement.closest('tr');
                        if (row) row.remove();
                    } else {
                        alert("처리 중 오류가 발생했습니다.");
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert("서버 통신 오류가 발생했습니다.");
                });
            }

            // 폼 유효성 검사
            const formEl           = document.querySelector('form');
            const leagueNameEl     = document.querySelector('[name="league_name"]');
            const leagueLocationEl = document.querySelector('[name="league_location"]');
            const leagueContentEl  = document.querySelector('[name="league_content"]');

            function getByteSize(str) {
                let byte = 0;
                for (let i = 0; i < str.length; i++) {
                    byte += str.charCodeAt(i) > 127 ? 3 : 1;
                }
                return byte;
            }

            formEl.addEventListener('submit', function(e) {
                if (leagueNameEl.value.trim() === '') {
                    alert('리그 이름을 입력하세요.');
                    leagueNameEl.focus();
                    e.preventDefault(); e.stopPropagation(); return;
                }
                if (leagueLocationEl.value.trim() === '') {
                    alert('연고지를 입력하세요.');
                    leagueLocationEl.focus();
                    e.preventDefault(); e.stopPropagation(); return;
                }
                if (getByteSize(leagueNameEl.value) > 50) {
                    alert('리그 이름이 너무 깁니다. (현재 ' + getByteSize(leagueNameEl.value) + 'byte / 최대 50byte)');
                    leagueNameEl.focus();
                    e.preventDefault(); e.stopPropagation(); return;
                }
                if (getByteSize(leagueLocationEl.value) > 20) {
                    alert('연고지 이름이 너무 깁니다. (현재 ' + getByteSize(leagueLocationEl.value) + 'byte / 최대 20byte)');
                    leagueLocationEl.focus();
                    e.preventDefault(); e.stopPropagation(); return;
                }
                if (getByteSize(leagueContentEl.value) > 2000) {
                    alert('소개글이 너무 깁니다. (현재 ' + getByteSize(leagueContentEl.value) + 'byte / 최대 2000byte)');
                    leagueContentEl.focus();
                    e.preventDefault(); e.stopPropagation(); return;
                }
            });
        });
    </script>

</body>
</html>
