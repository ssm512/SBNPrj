<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 정보 수정</title>
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
    .update-card {
        background: rgba(249, 249, 234, 0.93);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 28px 32px;
    }

    /* ===== 2분할 레이아웃 ===== */
    .update-body {
        display: grid;
        grid-template-columns: 200px 1fr;
        gap: 32px;
        align-items: start;
    }

    /* ===== 좌측 패널 ===== */

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
        font-family: 'Oswald', sans-serif;
        font-size: 15px;
        font-weight: 700;
        color: #FFD700;
        letter-spacing: 1px;
        margin-bottom: 10px;
    }

    .btn-stats {
        display: inline-block;
        padding: 6px 14px;
        background: rgba(255, 215, 0, 0.12);
        color: #FFD700;
        border: 1px solid rgba(255, 215, 0, 0.5);
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 11px;
        font-weight: 600;
        letter-spacing: 1px;
        cursor: pointer;
        transition: background 0.15s;
    }

    .btn-stats:hover { background: rgba(255, 215, 0, 0.25); }

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

    .myteamlist {
        width: 100%;
        border-collapse: collapse;
        border: none !important;
        margin: 0;
    }

    .myteamlist tr { border: none !important; }

    .myteamlist tr:first-of-type td { display: none; }

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

    /* ===== 우측: 수정 폼 ===== */

    .info-section-label {
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
        padding: 9px 12px !important;
        font-size: 14px;
        vertical-align: middle;
    }

    /* 라벨 셀 */
    .info-table td:nth-of-type(odd) {
        font-family: 'Oswald', sans-serif;
        font-size: 14px !important;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 1px;
        text-transform: uppercase;
        width: 72px;
        background: rgba(26, 61, 26, 0.04) !important;
    }

    /* 값 셀 */
    .info-table td:nth-of-type(even) {
        background: rgba(255, 255, 255, 0.5) !important;
    }

    /* 폼 입력 필드 */
    .form-input {
        width: 100%;
        padding: 7px 10px;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-size: 13px;
        color: #333;
        background: #fff;
        outline: none;
        box-sizing: border-box;
        transition: border-color 0.2s;
    }

    .form-input:focus { border-color: #1a3d1a; }

    /* 중복확인 버튼 */
    .btn-dup-check {
        padding: 5px 12px;
        background: rgba(26, 61, 26, 0.08);
        color: #1a3d1a;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 11px;
        font-weight: 600;
        letter-spacing: 0.5px;
        cursor: pointer;
        transition: background 0.15s;
        margin-top: 4px;
    }

    .btn-dup-check:hover {
        background: #1a3d1a;
        color: #FFD700;
        border-color: #1a3d1a;
    }

    /* 추가 정보 영역 */
    .extra-section {
        margin-top: 4px;
        margin-bottom: 16px;
    }

    .extra-row {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 10px 4px;
        border-bottom: 1px solid #ece8d0;
        font-size: 14px;
        color: #222;
        flex-wrap: wrap;
    }

    .extra-row:last-of-type { border-bottom: none; }

    .extra-label {
        font-family: 'Oswald', sans-serif;
        font-size: 11px;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 1px;
        text-transform: uppercase;
        min-width: 72px;
        flex-shrink: 0;
    }

    /* 라디오 레이블 */
    .extra-row label {
        font-size: 13px;
        color: #333;
        cursor: pointer;
    }

    /* 프로필 사진 업로드 */
    .file-row {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 10px 4px;
        font-size: 14px;
    }

    input[type="file"] {
        font-size: 13px;
        color: #555;
    }

    /* 수정 완료 버튼 */
    .btn-submit {
        display: block;
        margin-top: 24px;
        padding: 10px 40px;
        background: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
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

        <div class="section-header">정보 수정</div>

        <div class="main-wrapper">
            <div class="update-card">
                <div class="update-body">

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
                            <tr onclick='location.href="/Team/Info?team_idx=${team.team_idx}"' style="cursor:pointer;">
                                <td>${team.team_name}
                                    <b>${sessionScope.login.member_idx eq team.team_manager ? ' [감독]' : ''}</b>
                                </td>
                            </tr>
                            </c:forEach>
                        </table>

                    </div>

                    <%-- 우측: 수정 폼 --%>
                    <div class="right-panel">
                        <form action="/Member/Update" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="member_idx" value="${sessionScope.login.member_idx}" />
                            <input type="hidden" name="member_id"  value="${sessionScope.login.member_id}" />

                            <div class="info-section-label">회원 정보</div>
                            <table class="info-table">
                                <tr>
                                    <td>아이디</td>
                                    <td>${sessionScope.login.member_id}</td>
                                    <td>주소</td>
                                    <td><input class="form-input" type="text" name="address" value="${sessionScope.login.address}" /></td>
                                </tr>
                                <tr>
                                    <td>생년</td>
                                    <td><input class="form-input" type="date" name="birth" value="${sessionScope.login.birth}" /></td>
                                    <td>이름</td>
                                    <td><input class="form-input" type="text" name="member_name" value="${sessionScope.login.member_name}" required /></td>
                                </tr>
                                <tr>
                                    <td>연락처</td>
                                    <td>
                                        <input class="form-input" type="text" name="phone_num" value="${sessionScope.login.phone_num}" />
                                        <button type="button" class="btn-dup-check" id="phoneDupCheck">중복확인</button>
                                    </td>
                                    <td>이메일</td>
                                    <td>
                                        <input class="form-input" type="email" name="email" value="${sessionScope.login.email}" />
                                        <button type="button" class="btn-dup-check" id="emailDupCheck">중복확인</button>
                                    </td>
                                </tr>
                            </table>

                            <div class="info-section-label">추가 정보</div>
                            <div class="extra-section">
                                <div class="extra-row">
                                    <span class="extra-label">투타 구분</span>
                                    <input type="radio" name="use_hand" id="right_right" value="우투우타" ${sessionScope.login.use_hand == '우투우타' ? 'checked' : ''} />
                                    <label for="right_right">우투우타</label>
                                    <input type="radio" name="use_hand" id="right_left"  value="우투좌타" ${sessionScope.login.use_hand == '우투좌타' ? 'checked' : ''} />
                                    <label for="right_left">우투좌타</label>
                                    <input type="radio" name="use_hand" id="left_left"   value="좌투좌타" ${sessionScope.login.use_hand == '좌투좌타' ? 'checked' : ''} />
                                    <label for="left_left">좌투좌타</label>
                                    <input type="radio" name="use_hand" id="left_right"  value="좌투우타" ${sessionScope.login.use_hand == '좌투우타' ? 'checked' : ''} />
                                    <label for="left_right">좌투우타</label>
                                    <input type="radio" name="use_hand" id="switch"      value="스위치"   ${sessionScope.login.use_hand == '스위치'   ? 'checked' : ''} />
                                    <label for="switch">스위치</label>
                                </div>
                                <div class="extra-row">
                                    <span class="extra-label">선출 여부</span>
                                    <input type="radio" name="elite" id="normal"       value="비선출" ${sessionScope.login.elite == '비선출' ? 'checked' : ''} />
                                    <label for="normal">비선출</label>
                                    <input type="radio" name="elite" id="middle_school" value="중출"  ${sessionScope.login.elite == '중출'   ? 'checked' : ''} />
                                    <label for="middle_school">중출</label>
                                    <input type="radio" name="elite" id="high_school"  value="고출"  ${sessionScope.login.elite == '고출'   ? 'checked' : ''} />
                                    <label for="high_school">고출</label>
                                    <input type="radio" name="elite" id="pro"          value="프로"  ${sessionScope.login.elite == '프로'   ? 'checked' : ''} />
                                    <label for="pro">프로</label>
                                </div>
                                <div class="extra-row">
                                    <span class="extra-label">선호 포지션</span>
                                    <input class="form-input" style="width:160px;" type="text" name="hope_position" value="${sessionScope.login.hope_position}" />
                                </div>
                                <div class="file-row">
                                    <span class="extra-label">프로필 사진</span>
                                    <input type="file" name="file" accept="image/*" />
                                </div>
                            </div>

                            <input type="submit" class="btn-submit" id="updatebtn" value="수정 완료" />
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

    <script>

        var phoneDupChecked = true;
        var emailDupChecked = true;

        const formEl        = document.querySelector('form');
        const memberNameEl  = document.querySelector('[name="member_name"]');
        const memberIdEl    = document.querySelector('[name="member_id"]');
        const phoneEl       = document.querySelector('[name="phone_num"]');
        const emailEl       = document.querySelector('[name="email"]');
        const phoneDupBtnEl = document.querySelector('#phoneDupCheck');
        const emailDupBtnEl = document.querySelector('#emailDupCheck');
        const mystatsbtnEl  = document.querySelector('#mystatsbtn');

        // 입력 항목 체크
        formEl.addEventListener('submit', function (e) {

            if (memberNameEl.value.trim() == '') {
                alert('이름을 입력하세요');
                e.preventDefault(); e.stopPropagation();
                memberNameEl.focus(); return;
            }

            if (phoneEl.value.trim() == '') {
                alert('연락처를 입력하세요.');
                e.preventDefault(); phoneEl.focus(); return;
            }

            if (emailEl.value.trim() == '') {
                alert('이메일을 입력하세요.');
                e.preventDefault(); emailEl.focus(); return;
            }

            const phoneRegex = /^01[016789]\d{7,8}$/;
            if (!phoneRegex.test(phoneEl.value.trim())) {
                alert('전화번호 형식이 올바르지 않습니다. (예: 01012345678)');
                e.preventDefault(); phoneEl.focus(); return;
            }

            if (!phoneDupChecked) {
                alert('연락처 중복확인이 필요합니다.');
                e.preventDefault(); e.stopPropagation(); return;
            }

            if (!emailDupChecked) {
                alert('이메일 중복확인이 필요합니다.');
                e.preventDefault(); e.stopPropagation(); return;
            }

        });

        // 중복확인(Ajax) - 연락처
        phoneDupBtnEl.addEventListener('click', function () {
            if (phoneEl.value.trim() == '') {
                alert('연락처를 입력하세요'); phoneEl.focus(); return;
            }
            const phoneRegex = /^01[016789]\d{7,8}$/;
            if (!phoneRegex.test(phoneEl.value.trim())) {
                alert('전화번호 형식이 올바르지 않습니다. (예: 01012345678)');
                phoneEl.focus(); return;
            }
            fetch('/Member/PhoneDupCheck/' + phoneEl.value)
                .then(response => response.json())
                .then(json => {
                    if (json.member.member_id == memberIdEl.value) {
                        alert('본인이 사용중인 번호입니다.'); phoneDupChecked = true;
                    } else if (json.member && json.member.phone_num != null) {
                        alert('사용불가능'); phoneEl.focus(); phoneDupChecked = false;
                    } else {
                        alert('사용가능'); phoneDupChecked = true;
                    }
                })
                .catch(error => console.dir(error));
        });

        // 중복확인(Ajax) - 이메일
        emailDupBtnEl.addEventListener('click', function () {
            if (emailEl.value.trim() == '') {
                alert('이메일을 입력하세요'); emailEl.focus(); return;
            }
            fetch('/Member/EmailDupCheck/' + emailEl.value)
                .then(response => response.json())
                .then(json => {
                    if (json.member.member_id == memberIdEl.value) {
                        alert('본인이 사용중인 이메일입니다.'); emailDupChecked = true;
                    } else if (json.member && json.member.email != null) {
                        alert('사용불가능'); emailEl.focus(); emailDupChecked = false;
                    } else {
                        alert('사용가능'); emailDupChecked = true;
                    }
                })
                .catch(error => console.dir(error));
        });

        // 입력값 변경 시 중복확인 초기화
        phoneEl.addEventListener('change', function () { phoneDupChecked = false; });
        emailEl.addEventListener('change', function () { emailDupChecked = false; });

        // 내 전적보기 이동
        mystatsbtnEl.addEventListener('click', function () {
            location.href = '/Member/Stats?member_idx=' + ${sessionScope.login.member_idx};
        });

    </script>
</body>
</html>
