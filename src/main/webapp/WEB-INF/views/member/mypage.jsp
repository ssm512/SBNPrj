<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 마이페이지</title>
<link rel="shortcut icon" href="/img/favicon2.png" type="image/png" />
<link href="/css/common.css" rel="stylesheet" />
<link href="https://webfontworld.github.io/sunn/SCDream.css" rel="stylesheet" />
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
    .mypage-card {
        background: rgba(249, 249, 234, 0.93);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 28px 32px;
    }

    /* ===== 2분할 레이아웃 ===== */
    .mypage-body {
        display: grid;
        grid-template-columns: 200px 1fr;
        gap: 32px;
        align-items: start;
    }

    /* ===== 좌측 패널 ===== */

    /* 프로필 사진 박스 */
    .profile-box {
        background: #1a3d1a;
        border-radius: 3px;
        padding: 18px 14px 14px;
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
        margin: 0 auto 10px;
    }

    .profile-name-text {
        font-family: 'S-Core Dream', sans-serif;
        font-size: 15px;
        font-weight: 700;
        color: #FFD700;
        letter-spacing: 1px;
        margin-bottom: 10px;
    }

    /* 내 전적 조회 버튼 */
    .btn-stats {
        display: inline-block;
        padding: 6px 14px;
        background: rgba(255, 215, 0, 0.12);
        color: #FFD700;
        border: 1px solid rgba(255, 215, 0, 0.5);
        border-radius: 3px;
        font-family: 'S-Core Dream', sans-serif;
        font-size: 11px;
        font-weight: 600;
        letter-spacing: 1px;
        cursor: pointer;
        transition: background 0.15s;
    }

    .btn-stats:hover {
        background: rgba(255, 215, 0, 0.25);
    }

    /* 소속팀 섹션 타이틀 */
    .team-section-title {
        font-family: 'S-Core Dream', sans-serif;
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
        font-size: 13px !important;
        color: #222 !important;
        background: transparent !important;
    }

    .myteamlist tr:not(:first-of-type):hover td {
        background: #ece8d0 !important;
        cursor: pointer;
    }

    /* ===== 우측 패널 ===== */

    /* 섹션 타이틀 */
    .info-section-label {
        font-family: 'S-Core Dream', sans-serif;
        font-size: 11px;
        font-weight: 700;
        color: #1a3d1a;
        letter-spacing: 1.5px;
        text-transform: uppercase;
        padding-bottom: 8px;
        border-bottom: 1px solid #c8c4aa;
        margin-bottom: 10px;
    }

    .info-section-label + .info-section-label {
        margin-top: 20px;
    }

    /* 회원정보 테이블 */
    .info-table {
        width: 100%;
        border-collapse: collapse;
        border: none !important;
        margin-bottom: 20px;
    }

    .info-table td {
        border: none !important;
        border-bottom: 1px solid #ece8d0 !important;
        padding: 10px 12px !important;
        font-size: 14px;
        vertical-align: middle;
    }

    /* 라벨 셀 */
    .info-table td:nth-of-type(odd) {
        font-family: 'S-Core Dream', sans-serif;
        font-size: 11px !important;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 1px;
        text-transform: uppercase;
        width: 80px;
        background: rgba(26, 61, 26, 0.04) !important;
    }

    /* 값 셀 */
    .info-table td:nth-of-type(even) {
        color: #222;
        background: rgba(255, 255, 255, 0.5) !important;
    }

    /* 추가정보 / 비밀번호 행 */
    .extra-row {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 9px 4px;
        border-bottom: 1px solid #ece8d0;
        font-size: 14px;
        color: #222;
    }

    .extra-row:last-of-type { border-bottom: none; }

    .extra-label {
        font-family: 'S-Core Dream', sans-serif;
        font-size: 11px;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 1px;
        text-transform: uppercase;
        min-width: 72px;
        flex-shrink: 0;
    }

    /* 비밀번호 입력창 */
    .pw-input {
        padding: 7px 10px;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-size: 14px;
        font-family: 'S-Core Dream', sans-serif;
        outline: none;
        background: #fff;
        transition: border-color 0.15s;
        width: 220px;
    }

    .pw-input:focus { border-color: #1a3d1a; }

    /* 비밀번호 변경 메시지 */
    .pw-msg {
        font-size: 13px;
        color: #c0392b;
        font-family: 'S-Core Dream', sans-serif;
    }

    /* 하단 버튼 영역 */
    .bottom-btn {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 24px;
    }

    /* 정보 수정 버튼 */
    .btn-update {
        display: inline-block;
        padding: 10px 32px;
        background: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 3px;
        font-family: 'S-Core Dream', sans-serif;
        font-size: 13px;
        font-weight: 700;
        letter-spacing: 1px;
        cursor: pointer;
        transition: background 0.15s;
    }

    .btn-update:hover { background: #e6c200; }
    
    /* 회원 탈퇴 버튼 */
    .btn-leave {
        display: inline-block;
        margin-top: 24px;

    /* 회원 탈퇴 버튼 */
    .btn-leave {
        display: inline-block;
        padding: 10px 32px;
        color: #b03030;
        border: 1.5px solid #b03030;
        background: transparent;
        border-radius: 3px;
        font-family: 'S-Core Dream', sans-serif;
        font-size: 13px;
        font-weight: 700;
        letter-spacing: 1px;
        cursor: pointer;
        transition: background 0.15s, color 0.15s;
    }

    .btn-leave:hover {
        background: #b03030;
        color: #ffffff;
    }

    /* 비밀번호 변경 버튼 */
    .btn-pw-change {
        padding: 6px 20px;
        background: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 3px;
        font-family: 'S-Core Dream', sans-serif;
        font-size: 13px;
        font-weight: 700;
        letter-spacing: 1px;
        cursor: pointer;
        transition: background 0.15s;
    }

    
    .btn-pw-change:hover { background: #e6c200; }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">

        <div class="section-header">마이페이지</div>

        <div class="main-wrapper">
            <div class="mypage-card">
                <div class="mypage-body">

                    <%-- 좌측: 프로필 + 소속팀 --%>
                    <div class="left-panel">

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
                            <div class="profile-name-text">${sessionScope.login.member_name}</div>
                            <button type="button" class="btn-stats" id="mystatsbtn">내 전적 조회</button>
                        </div>

                        <div class="team-section-title">소속 팀</div>
                        <table class="myteamlist">
                            <tr><td>소속팀목록</td></tr>
                            <c:forEach var="team" items="${teamList}">
                                <tr onclick='location.href="/Team/Info?team_idx=${team.team_idx}&keyword="' style="cursor:pointer;">
                                    <td>${team.team_name}
                                        <b>${sessionScope.login.member_idx eq team.team_manager ? ' [감독]' : ''}</b>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>

                    </div>

                    <%-- 우측: 회원 정보 --%>
                    <div class="right-panel">

                        <div class="info-section-label">회원 정보</div>
                        <table class="info-table">
                            <tr>
                                <td>아이디</td>
                                <td>${sessionScope.login.member_id}</td>
                                <td>주소</td>
                                <td>${sessionScope.login.address}</td>
                            </tr>
                            <tr>
                                <td>생년</td>
                                <td>${sessionScope.login.birth}</td>
                                <td>이름</td>
                                <td>${sessionScope.login.member_name}</td>
                            </tr>
                            <tr>
                                <td>연락처</td>
                                <td>${sessionScope.login.phone_num}</td>
                                <td>이메일</td>
                                <td>${sessionScope.login.email}</td>
                            </tr>
                        </table>

                        <div class="info-section-label">추가 정보</div>
                        <div class="extra-row">
                            <span class="extra-label">투타 구분</span>
                            <span>${sessionScope.login.use_hand}</span>
                        </div>
                        <div class="extra-row">
                            <span class="extra-label">선출 여부</span>
                            <span>${sessionScope.login.elite}</span>
                        </div>
                        <div class="extra-row">
                            <span class="extra-label">선호 포지션</span>
                            <span>${sessionScope.login.hope_position}</span>
                        </div>

                        <%-- 비밀번호 변경 --%>
                        <div class="info-section-label" style="margin-top:20px;">비밀번호 변경</div>
                        <div class="extra-row">
                            <span class="extra-label">현재 비번</span>
                            <input type="password" id="currentPw" class="pw-input" placeholder="현재 비밀번호" />
                        </div>
                        <div class="extra-row">
                            <span class="extra-label">새 비번</span>
                            <input type="password" id="newPw" class="pw-input" placeholder="새 비밀번호 (4자리 이상)" />
                        </div>
                        <div class="extra-row">
                            <span class="extra-label">비번 확인</span>
                            <input type="password" id="newPwCheck" class="pw-input" placeholder="새 비밀번호 확인" />
                            <button type="button" id="changePwBtn" class="btn-pw-change">변경</button>
                            <span id="changePwMsg" class="pw-msg"></span>
                        </div>

                        <div class="bottom-btn">
                            <button type="button" class="btn-update" id="updatebtn">정보 수정</button>
                            <button type="button" class="btn-leave" id="leavebtn" onclick="leaveSbn()">회원 탈퇴</button>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

    <script>

        // 수정 완료 후 alert
        if ('${param.updated}' == 'true') {
            alert('수정이 완료되었습니다.');
        }

        document.querySelector('#updatebtn').addEventListener('click', function () {
            location.href = '/Member/UpdateForm';
        });

        document.querySelector('#mystatsbtn').addEventListener('click', function () {
            location.href = '/Member/Stats?member_idx=' + ${sessionScope.login.member_idx};
        });
        
        
        function leaveSbn() {
        	if (confirm("탈퇴하시겠습니까?\n탈퇴 후엔 해당 아이디로 재가입이 불가능 합니다.")) {
        		if (${not empty teamList}) {
        			alert("소속된 팀이 있으면 탈퇴 할 수 없습니다.\n팀을 탈퇴한 후 다시 시도해주세요.")
        		} else {
        			location.href="/Member/LeaveSbn"
        		}
        	} else {
	          alert("SBN 에서의 활약을 응원합니다!")
        	}
        }
        
        
        document.querySelector('#changePwBtn').addEventListener('click', function() {
            const currentPw  = document.querySelector('#currentPw').value
            const newPw      = document.querySelector('#newPw').value
            const newPwCheck = document.querySelector('#newPwCheck').value
            const msgEl      = document.querySelector('#changePwMsg')

            if (currentPw.trim() == '') { msgEl.textContent = '현재 비밀번호를 입력하세요.'; return }
            if (newPw.length < 4)       { msgEl.textContent = '새 비밀번호는 4자리 이상이어야 합니다.'; return }
            if (newPw !== newPwCheck)   { msgEl.textContent = '새 비밀번호가 일치하지 않습니다.'; return }

            fetch('/Member/ChangePassword', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'current_pw=' + encodeURIComponent(currentPw)
                    + '&new_pw='    + encodeURIComponent(newPw)
            })
            .then(res => res.json())
            .then(json => {
                if (json.result) {
                    alert('비밀번호가 변경되었습니다.')
                    document.querySelector('#currentPw').value  = ''
                    document.querySelector('#newPw').value      = ''
                    document.querySelector('#newPwCheck').value = ''
                    msgEl.textContent = ''
                } else {
                    msgEl.textContent = '현재 비밀번호가 틀렸습니다.'
                }
            })
        })

        function leaveSbn() {
            if (confirm("탈퇴하시겠습니까?\n탈퇴 후엔 해당 아이디로 재가입이 불가능 합니다.")) {
                if (${not empty teamList}) {
                    alert("소속된 팀이 있으면 탈퇴 할 수 없습니다.\n팀을 탈퇴한 후 다시 시도해주세요.");
                } else {
                    location.href = "/Member/LeaveSbn";
                }
            } else {
                alert("SBN 에서의 활약을 응원합니다!");
            }
        }

        document.querySelector('#changePwBtn').addEventListener('click', function () {
            const currentPw  = document.querySelector('#currentPw').value;
            const newPw      = document.querySelector('#newPw').value;
            const newPwCheck = document.querySelector('#newPwCheck').value;
            const msgEl      = document.querySelector('#changePwMsg');

            if (currentPw.trim() === '') { msgEl.textContent = '현재 비밀번호를 입력하세요.'; return; }
            if (newPw.length < 4)        { msgEl.textContent = '새 비밀번호는 4자리 이상이어야 합니다.'; return; }
            if (newPw !== newPwCheck)    { msgEl.textContent = '새 비밀번호가 일치하지 않습니다.'; return; }

            fetch('/Member/ChangePassword', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'current_pw=' + encodeURIComponent(currentPw)
                    + '&new_pw='    + encodeURIComponent(newPw)
            })
            .then(res => res.json())
            .then(json => {
                if (json.result) {
                    alert('비밀번호가 변경되었습니다.');
                    document.querySelector('#currentPw').value  = '';
                    document.querySelector('#newPw').value      = '';
                    document.querySelector('#newPwCheck').value = '';
                    msgEl.textContent = '';
                } else {
                    msgEl.textContent = '현재 비밀번호가 틀렸습니다.';
                }
            });
        });

    </script>

    <c:if test="${param.deleteError == 'true'}">
        <script>alert('소속된 팀이 있어 탈퇴할 수 없습니다.');</script>
    </c:if>

</body>
</html>
