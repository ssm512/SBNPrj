<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 마이페이지</title>

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

    .card-sub-header + .card-sub-header {
        margin-top: 24px;
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

    /* ===== 회원 정보 테이블 ===== */
    .info-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 8px;
    }

    .info-table th {
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

    .info-table td {
        background: rgba(255, 255, 255, 0.55);
        padding: 10px 14px;
        font-size: 14px;
        color: #222;
        border-bottom: 1px solid rgba(200, 196, 170, 0.4);
    }

    /* ===== 추가 정보 행 ===== */
    .extra-row {
        display: flex;
        align-items: center;
        gap: 16px;
        padding: 10px 0;
        border-bottom: 1px solid rgba(200, 196, 170, 0.35);
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

    .extra-value {
        font-size: 14px;
        color: #222;
    }

    /* ===== 정보 수정 버튼 ===== */
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

        <div class="section-header">마이페이지</div>

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
                         onclick='location.href="/Team/Info?team_idx=${ team.team_idx }&keyword="'>
                        <span>${ team.team_name }</span>
                        <c:if test="${ sessionScope.login.member_idx eq team.team_manager }">
                            <span class="manager-badge">감독</span>
                        </c:if>
                    </div>
                </c:forEach>

            </div>

            <%-- ========== 우측 정보 영역 ========== --%>
            <div class="right-card">

                <div class="card-sub-header">회원 정보</div>

                <table class="info-table">
                    <tr>
                        <th>아이디</th>
                        <td>${ sessionScope.login.member_id }</td>
                        <th>주소</th>
                        <td>${ sessionScope.login.address }</td>
                    </tr>
                    <tr>
                        <th>생년</th>
                        <td>${ sessionScope.login.birth }</td>
                        <th>이름</th>
                        <td>${ sessionScope.login.member_name }</td>
                    </tr>
                    <tr>
                        <th>연락처</th>
                        <td>${ sessionScope.login.phone_num }</td>
                        <th>이메일</th>
                        <td>${ sessionScope.login.email }</td>
                    </tr>
                </table>

                <div class="card-sub-header" style="margin-top:24px;">추가 정보</div>

                <div class="extra-row">
                    <span class="extra-label">투타 구분</span>
                    <span class="extra-value">${ sessionScope.login.use_hand }</span>
                </div>
                <div class="extra-row">
                    <span class="extra-label">선출 여부</span>
                    <span class="extra-value">${ sessionScope.login.elite }</span>
                </div>
                <div class="extra-row">
                    <span class="extra-label">선호 포지션</span>
                    <span class="extra-value">${ sessionScope.login.hope_position }</span>
                </div>

                <button type="button" class="btn-submit" id="updatebtn">정보 수정</button>

            </div>

        </div>

    </div>

    <%@include file="/WEB-INF/include/footer.jsp" %>

    <script>

    // 수정 완료 후 alert
    if ('${ param.updated }' == 'true') {
        alert('수정이 완료되었습니다.')
    }

    const updatebtnEl  = document.querySelector('#updatebtn')
    const mystatsbtnEl = document.querySelector('#mystatsbtn')

    updatebtnEl.addEventListener('click', function () {
        location.href = "/Member/UpdateForm"
    })

    mystatsbtnEl.addEventListener('click', function () {
        location.href = "/Member/Stats?member_idx=" + ${ sessionScope.login.member_idx }
    })

    </script>
</body>
</html>
