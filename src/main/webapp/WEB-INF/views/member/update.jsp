<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 정보수정</title>

<link rel="shortcut icon" href="/img/favicon.png" type="image/x-icon" />
<link href="/css/common.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;500;600;700&display=swap" rel="stylesheet" />

<style>

    /* ===== 전체 레이아웃 ===== */
    html, body { height: 100%; }

    body {
        background-color: #f5f7fa;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    /* 블러 배경 */
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
        border-radius: 8px;
        max-width: 1100px;
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

    /* ===== 메인 그리드 ===== */
    .main-wrapper {
        display: grid;
        grid-template-columns: 220px 1fr;
        gap: 20px;
        max-width: 1100px;
        margin: 0 auto;
        align-items: start;
    }

    /* ===== 카드 공통 ===== */
    .left-card, .right-card {
        background: rgba(245, 245, 220, 0.88);
        border-radius: 10px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 20px;
    }

    /* ===== 프로필 카드 ===== */
    .profile-card {
        background: #1a3d1a;
        border-radius: 8px;
        padding: 18px 16px 14px;
        text-align: center;
        margin-bottom: 12px;
    }

    .profile-avatar {
        width: 56px;
        height: 56px;
        border-radius: 50%;
        background: rgba(255, 215, 0, 0.18);
        border: 2px solid rgba(255, 215, 0, 0.5);
        margin: 0 auto 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 22px;
        color: #FFD700;
    }

    .profile-name {
        font-family: 'Oswald', sans-serif;
        font-size: 18px;
        font-weight: 700;
        color: #FFD700;
        letter-spacing: 1px;
    }

    /* ===== 내 전적 조회 버튼 ===== */
    .btn-stats {
        display: block;
        width: 100%;
        padding: 9px;
        background: white;
        border: 1.5px solid #1a3d1a;
        border-radius: 6px;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 600;
        color: #1a3d1a;
        cursor: pointer;
        letter-spacing: 0.5px;
        margin-bottom: 16px;
        transition: background-color 0.2s;
    }

    .btn-stats:hover {
        background-color: #f0edd0;
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
        border-radius: 6px;
        cursor: pointer;
        transition: background-color 0.2s;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .team-list-item:hover {
        background-color: #e8e8d8;
    }

    .manager-badge {
        font-size: 10px;
        background: #FFD700;
        color: #1a3d1a;
        padding: 1px 7px;
        border-radius: 10px;
        font-weight: 700;
        font-family: 'Oswald', sans-serif;
        letter-spacing: 0.5px;
        white-space: nowrap;
    }

    /* ===== 카드 내 서브 헤더 ===== */
    .card-sub-header {
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 700;
        color: #FFD700;
        letter-spacing: 2px;
        background-color: #1a3d1a;
        padding: 7px 14px;
        border-radius: 6px;
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

    /* ===== 회원 정보 입력 테이블 ===== */
    .form-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 8px;
    }

    .form-table th {
        background-color: rgba(26, 61, 26, 0.08);
        color: #1a3d1a;
        font-family: 'Oswald', sans-serif;
        font-size: 12px;
        font-weight: 600;
        letter-spacing: 0.5px;
        padding: 10px 14px;
        text-align: left;
        width: 80px;
        white-space: nowrap;
        border-bottom: 1px solid rgba(200, 196, 170, 0.4);
    }

    .form-table td {
        background: rgba(255, 255, 255, 0.55);
        padding: 7px 10px;
        border-bottom: 1px solid rgba(200, 196, 170, 0.4);
        vertical-align: middle;
    }

    /* ===== 입력창 ===== */
    .form-input {
        width: 100%;
        padding: 8px 12px;
        border: 1px solid #c8c4aa;
        border-radius: 6px;
        font-size: 14px;
        color: #111;
        background-color: #ffffff;
        outline: none;
        box-sizing: border-box;
        transition: border-color 0.2s;
    }

    .form-input:focus {
        border-color: #1a3d1a;
    }

    .form-input[readonly], .form-input:disabled {
        background-color: #f0edd0;
        color: #666;
        cursor: default;
    }

    /* 중복확인 버튼이 있는 셀 */
    .td-with-btn {
        display: flex;
        flex-direction: column;
        gap: 5px;
    }

    /* ===== 중복확인 버튼 ===== */
    .btn-dup {
        align-self: flex-end;
        padding: 5px 12px;
        background: white;
        border: 1.5px solid #1a3d1a;
        border-radius: 4px;
        font-family: 'Oswald', sans-serif;
        font-size: 12px;
        font-weight: 600;
        color: #1a3d1a;
        cursor: pointer;
        letter-spacing: 0.5px;
        transition: background-color 0.2s;
        white-space: nowrap;
    }

    .btn-dup:hover {
        background-color: #f0edd0;
    }

    /* ===== 추가 정보 행 ===== */
    .extra-row {
        display: flex;
        align-items: center;
        gap: 16px;
        padding: 10px 0;
        border-bottom: 1px solid rgba(200, 196, 170, 0.35);
        flex-wrap: wrap;
    }

    .extra-row:last-of-type {
        border-bottom: none;
    }

    .extra-label {
        font-family: 'Oswald', sans-serif;
        font-size: 12px;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 0.5px;
        width: 78px;
        flex-shrink: 0;
    }

    /* ===== 라디오 그룹 ===== */
    .radio-group {
        display: flex;
        flex-wrap: wrap;
        gap: 14px;
        align-items: center;
    }

    .radio-group label {
        font-size: 13px;
        color: #333;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 4px;
    }

    .radio-group input[type="radio"] {
        accent-color: #1a3d1a;
        width: 14px;
        height: 14px;
        cursor: pointer;
    }

    /* 선호 포지션 입력 */
    .input-position {
        width: 180px;
        padding: 7px 12px;
        border: 1px solid #c8c4aa;
        border-radius: 6px;
        font-size: 14px;
        color: #111;
        background-color: #ffffff;
        outline: none;
        transition: border-color 0.2s;
    }

    .input-position:focus {
        border-color: #1a3d1a;
    }

    /* ===== 수정 완료 버튼 ===== */
    .btn-submit {
        display: block;
        width: 100%;
        max-width: 280px;
        margin: 28px auto 0;
        padding: 12px;
        background-color: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 6px;
        font-size: 15px;
        font-family: 'Oswald', sans-serif;
        font-weight: 700;
        letter-spacing: 1px;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .btn-submit:hover {
        background-color: #e6c200;
    }

</style>

</head>
<body>
    <%@include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">

        <div class="section-header">정보 수정</div>

        <div class="main-wrapper">

            <%-- ========== 좌측 사이드 ========== --%>
            <div class="left-card">

                <%-- 프로필 카드 --%>
                <div class="profile-card">
                    <div class="profile-avatar">⚾</div>
                    <div class="profile-name">${ sessionScope.login.member_name }</div>
                </div>

                <%-- 내 전적 조회 --%>
                <button type="button" class="btn-stats" id="mystatsbtn">내 전적 조회</button>

                <%-- 소속팀 목록 --%>
                <div class="team-list-title">소속팀 목록</div>
                <c:forEach var="team" items="${ teamList }">
                    <div class="team-list-item"
                         onclick='location.href="/Team/Info?team_idx=${ team.team_idx }"'>
                        <span>${ team.team_name }</span>
                        <c:if test="${ sessionScope.login.member_idx eq team.team_manager }">
                            <span class="manager-badge">감독</span>
                        </c:if>
                    </div>
                </c:forEach>

            </div>

            <%-- ========== 우측 수정 폼 영역 ========== --%>
            <div class="right-card">

                <form action="/Member/Update" method="post">
                    <input type="hidden" name="member_idx" value="${ sessionScope.login.member_idx }" />
                    <input type="hidden" name="member_id"  value="${ sessionScope.login.member_id }" />

                    <div class="card-sub-header">회원 정보</div>

                    <table class="form-table">
                        <tr>
                            <th>아이디</th>
                            <td>
                                <input class="form-input" type="text"
                                       value="${ sessionScope.login.member_id }" readonly />
                            </td>
                            <th>주소</th>
                            <td>
                                <input class="form-input" type="text"
                                       name="address" value="${ sessionScope.login.address }" />
                            </td>
                        </tr>
                        <tr>
                            <th>생년</th>
                            <td>
                                <input class="form-input" type="date"
                                       name="birth" value="${ sessionScope.login.birth }" />
                            </td>
                            <th>이름</th>
                            <td>
                                <input class="form-input" type="text"
                                       name="member_name" value="${ sessionScope.login.member_name }" required />
                            </td>
                        </tr>
                        <tr>
                            <th>연락처</th>
                            <td>
                                <div class="td-with-btn">
                                    <input class="form-input" type="text"
                                           name="phone_num" value="${ sessionScope.login.phone_num }" />
                                    <button type="button" class="btn-dup" id="phoneDupCheck">중복확인</button>
                                </div>
                            </td>
                            <th>이메일</th>
                            <td>
                                <div class="td-with-btn">
                                    <input class="form-input" type="email"
                                           name="email" value="${ sessionScope.login.email }" />
                                    <button type="button" class="btn-dup" id="emailDupCheck">중복확인</button>
                                </div>
                            </td>
                        </tr>
                    </table>

                    <div class="card-sub-header" style="margin-top:24px;">추가 정보</div>

                    <%-- 투타 구분 --%>
                    <div class="extra-row">
                        <span class="extra-label">투타 구분</span>
                        <div class="radio-group">
                            <label>
                                <input type="radio" name="use_hand" value="우투우타"
                                       ${ sessionScope.login.use_hand == '우투우타' ? 'checked' : '' } />
                                우투우타
                            </label>
                            <label>
                                <input type="radio" name="use_hand" value="우투좌타"
                                       ${ sessionScope.login.use_hand == '우투좌타' ? 'checked' : '' } />
                                우투좌타
                            </label>
                            <label>
                                <input type="radio" name="use_hand" value="좌투좌타"
                                       ${ sessionScope.login.use_hand == '좌투좌타' ? 'checked' : '' } />
                                좌투좌타
                            </label>
                            <label>
                                <input type="radio" name="use_hand" value="좌투우타"
                                       ${ sessionScope.login.use_hand == '좌투우타' ? 'checked' : '' } />
                                좌투우타
                            </label>
                            <label>
                                <input type="radio" name="use_hand" value="스위치"
                                       ${ sessionScope.login.use_hand == '스위치' ? 'checked' : '' } />
                                스위치
                            </label>
                        </div>
                    </div>

                    <%-- 선출 여부 --%>
                    <div class="extra-row">
                        <span class="extra-label">선출 여부</span>
                        <div class="radio-group">
                            <label>
                                <input type="radio" name="elite" value="비선출"
                                       ${ sessionScope.login.elite == '비선출' ? 'checked' : '' } />
                                비선출
                            </label>
                            <label>
                                <input type="radio" name="elite" value="중출"
                                       ${ sessionScope.login.elite == '중출' ? 'checked' : '' } />
                                중출
                            </label>
                            <label>
                                <input type="radio" name="elite" value="고출"
                                       ${ sessionScope.login.elite == '고출' ? 'checked' : '' } />
                                고출
                            </label>
                            <label>
                                <input type="radio" name="elite" value="프로"
                                       ${ sessionScope.login.elite == '프로' ? 'checked' : '' } />
                                프로
                            </label>
                        </div>
                    </div>

                    <%-- 선호 포지션 --%>
                    <div class="extra-row">
                        <span class="extra-label">선호 포지션</span>
                        <input class="input-position" type="text"
                               name="hope_position" value="${ sessionScope.login.hope_position }" />
                    </div>

                    <button type="submit" class="btn-submit" id="updatebtn">수정 완료</button>

                </form>

            </div>

        </div>

    </div>

    <%@include file="/WEB-INF/include/footer.jsp" %>

    <script>

    var phoneDupChecked = true;
    var emailDupChecked = true;

    const formEl        = document.querySelector('form')
    const memberNameEl  = document.querySelector('[name="member_name"]')
    const memberIdEl    = document.querySelector('[name="member_id"]')
    const phoneEl       = document.querySelector('[name="phone_num"]')
    const emailEl       = document.querySelector('[name="email"]')
    const phoneDupBtnEl = document.querySelector('#phoneDupCheck')
    const emailDupBtnEl = document.querySelector('#emailDupCheck')
    const mystatsbtnEl  = document.querySelector('#mystatsbtn')

    mystatsbtnEl.addEventListener('click', function () {
        location.href = "/Member/Stats?member_idx=" + ${ sessionScope.login.member_idx }
    })

    // 입력항목 체크
    formEl.addEventListener('submit', function (e) {

        if (memberNameEl.value.trim() == '') {
            alert('이름을 입력하세요')
            e.preventDefault()
            e.stopPropagation()
            memberNameEl.focus()
            return;
        }

        if (phoneEl.value.trim() == '') {
            alert('연락처를 입력하세요.')
            e.preventDefault()
            phoneEl.focus()
            return;
        }

        if (emailEl.value.trim() == '') {
            alert('이메일을 입력하세요.')
            e.preventDefault()
            emailEl.focus()
            return;
        }

        const phoneRegex = /^01[016789]\d{7,8}$/;
        if (!phoneRegex.test(phoneEl.value.trim())) {
            alert('전화번호 형식이 올바르지 않습니다. (예: 01012345678)');
            e.preventDefault();
            phoneEl.focus();
            return;
        }

        if (!phoneDupChecked) {
            alert('연락처 중복확인이 필요합니다.')
            e.preventDefault()
            e.stopPropagation()
            return;
        }

        if (!emailDupChecked) {
            alert('이메일 중복확인이 필요합니다.')
            e.preventDefault()
            e.stopPropagation()
            return;
        }

    }) // formEl.submit


    // 중복확인(Ajax) - 연락처
    phoneDupBtnEl.addEventListener('click', function () {
        if (phoneEl.value.trim() == '') {
            alert('연락처를 입력하세요')
            phoneEl.focus()
            return;
        }
        const phoneRegex = /^01[016789]\d{7,8}$/;
        if (!phoneRegex.test(phoneEl.value.trim())) {
            alert('전화번호 형식이 올바르지 않습니다. (예: 01012345678)');
            phoneEl.focus();
            return;
        }
        let url = '/Member/PhoneDupCheck/' + phoneEl.value;
        fetch(url)
            .then((response) => response.json())
            .then((json) => {
                if (json.member.member_id == memberIdEl.value) {
                    alert('본인이 사용중인 번호입니다.')
                    phoneDupChecked = true
                } else if (json.member && json.member.phone_num != null) {
                    alert('사용불가능')
                    phoneEl.focus()
                    phoneDupChecked = false
                } else {
                    alert('사용가능')
                    phoneDupChecked = true
                }
            })
            .catch((error) => { console.dir(error) })
    }) // phoneDupBtnEl


    // 중복확인(Ajax) - 이메일
    emailDupBtnEl.addEventListener('click', function () {
        if (emailEl.value.trim() == '') {
            alert('이메일을 입력하세요')
            emailEl.focus()
            return;
        }
        let url = '/Member/EmailDupCheck/' + emailEl.value;
        fetch(url)
            .then((response) => response.json())
            .then((json) => {
                if (json.member.member_id == memberIdEl.value) {
                    alert('본인이 사용중인 이메일입니다.')
                    emailDupChecked = true
                } else if (json.member && json.member.email != null) {
                    alert('사용불가능')
                    emailEl.focus()
                    emailDupChecked = false
                } else {
                    alert('사용가능')
                    emailDupChecked = true
                }
            })
            .catch((error) => { console.dir(error) })
    }) // emailDupBtnEl


    // 값 변경 시 중복 재확인 필요
    phoneEl.addEventListener('change', function () { phoneDupChecked = false; })
    emailEl.addEventListener('change', function () { emailDupChecked = false; })

    </script>
</body>
</html>
