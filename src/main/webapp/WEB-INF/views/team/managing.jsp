<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 구단 관리</title>
<link rel="shortcut icon" href="/img/favicon2.png" type="image/png" />
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
        padding: 84px 32px 48px;
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
        max-width: 1160px;
        margin: 0 auto;
    }

    /* common.css의 margin-top: 50px 오버라이드 */
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

    /* ===== 관리 카드 ===== */
    .managing-card {
        background: rgba(245, 245, 220, 0.88);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 28px 32px;
        margin-bottom: 32px;
    }

    /* ===== 좌우 2분할 레이아웃 ===== */
    .managing-area {
        display: flex;
        gap: 32px;
        align-items: flex-start;
    }

    .member-section,
    .join-section {
        flex: 1;
    }

    /* ===== 구단 로고 영역 ===== */
    .logo-row {
        display: flex;
        align-items: center;
        gap: 20px;
        padding-bottom: 20px;
        border-bottom: 1px solid #c8c4aa;
        margin-bottom: 24px;
    }

    .team-logo-img {
        width: 88px;
        height: 88px;
        object-fit: contain;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        background: #fff;
        padding: 5px;
        flex-shrink: 0;
    }

    .logo-placeholder {
        width: 88px;
        height: 88px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: 'Oswald', sans-serif;
        font-size: 11px;
        color: #bbb;
        letter-spacing: 1px;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        background: #fff;
        flex-shrink: 0;
    }

    .logo-info .logo-team-name {
        font-family: 'Oswald', sans-serif;
        font-size: 20px;
        font-weight: 700;
        color: #1a3d1a;
        letter-spacing: 1px;
    }

    .logo-info .logo-hint {
        font-size: 12px;
        color: #888;
        margin: 4px 0 8px;
    }

    .btn-logo-change {
        display: inline-block;
        padding: 5px 14px;
        background: rgba(26, 61, 26, 0.06);
        color: #1a3d1a;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 11px;
        font-weight: 600;
        letter-spacing: 1px;
        cursor: pointer;
        transition: background 0.15s, color 0.15s;
        text-transform: uppercase;
    }

    .btn-logo-change:hover {
        background: #1a3d1a;
        color: #FFD700;
        border-color: #1a3d1a;
    }
    /* 소섹션 타이틀 (소속 선수 리스트 / 가입 신청 현황) */
    .subsection-title {
        font-family: 'Oswald', sans-serif;
        font-size: 14px;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 1.5px;
        padding: 0 0 8px 12px;
        border-left: 3px solid #FFD700;
        margin-bottom: 12px;
    }

    /* ===== 관리 테이블 (소속 선수 / 가입 신청 공통) ===== */
    /* common.css의 전역 border 오버라이드 */
    .manage-table {
        width: 100%;
        border-collapse: collapse;
        border: none;
    }

    .manage-table td {
        border: none;
        border-bottom: 1px solid #a8a48a;
        padding: 11px 12px;
        text-align: center;
        font-size: 14px;
        font-weight: 600;
        color: #111111;
    }

    /* 헤더 행 - 그린 배경 + 골드 하단선 */
    .manage-table tr:first-of-type td {
        background-color: #1a3d1a;
        color: #ffffff;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 500;
        letter-spacing: 1px;
        border-bottom: 2px solid #FFD700;
    }

    /* 헤더 좌우 상단 모서리 둥글게 */
    .manage-table tr:first-of-type td:first-child { border-radius: 3px 0 0 0; }
    .manage-table tr:first-of-type td:last-child  { border-radius: 0 3px 0 0; }

    /* 데이터 행 hover */
    .manage-table tr:not(:first-of-type):hover td {
        background-color: #ece8d0;
    }

    /* 인라인 편집 입력창 (포지션, 배번) */
    .manage-table input[type="text"],
    .manage-table input[type="number"] {
        width: 70px;
        padding: 5px 6px;
        text-align: center;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-size: 13px;
        background-color: #ffffff;
        outline: none;
    }

    .manage-table input[type="text"]:focus,
    .manage-table input[type="number"]:focus {
        border-color: #1a3d1a;
    }

    /* ===== 액션 버튼 ===== */
    /* 선수 제거 버튼 */
    .btn-remove {
        color: #c0392b;
        font-weight: 700;
        cursor: pointer;
        border: none;
        background: none;
        font-size: 15px;
        transition: color 0.2s;
    }

    .btn-remove:hover { color: #e74c3c; }

    /* 가입 승인 버튼 */
    .btn-approve {
        color: #1a3d1a;
        font-weight: 700;
        cursor: pointer;
        border: 1px solid #1a3d1a;
        background: none;
        border-radius: 3px;
        padding: 3px 10px;
        font-size: 13px;
        font-family: 'Oswald', sans-serif;
        transition: all 0.2s;
    }

    .btn-approve:hover {
        background-color: #1a3d1a;
        color: #FFD700;
    }

    /* 가입 거절 버튼 */
    .btn-reject {
        color: #c0392b;
        font-weight: 700;
        cursor: pointer;
        border: 1px solid #c0392b;
        background: none;
        border-radius: 3px;
        padding: 3px 10px;
        font-size: 13px;
        font-family: 'Oswald', sans-serif;
        transition: all 0.2s;
    }

    .btn-reject:hover {
        background-color: #c0392b;
        color: #ffffff;
    }

    /* ===== 하단 수정 완료 버튼 바 ===== */
    .bottom-bar {
        display: flex;
        justify-content: flex-end;
        margin-top: 20px;
    }

    /* 수정 완료 버튼 - 골드 배경 + 그린 텍스트 */
    .btn-submit {
        padding: 10px 32px;
        background-color: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 14px;
        font-weight: 700;
        letter-spacing: 1px;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .btn-submit:hover { background-color: #e6c200; }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">
        <%-- 섹션 헤더 --%>
        <div class="section-header">구단 관리</div>

        <div class="main-wrapper">

            <div class="managing-card">

                <%-- 구단 로고 영역 (감독만 변경 가능) --%>
                <div class="logo-row">
                    <c:choose>
                        <c:when test="${not empty team.sfile_name}">
                            <img src="/sbndata/${team.sfile_name}" class="team-logo-img" alt="구단 로고">
                        </c:when>
                        <c:otherwise>
                            <div class="logo-placeholder">NO<br>LOGO</div>
                        </c:otherwise>
                    </c:choose>
                    <div class="logo-info">
                        <div class="logo-team-name">${team.team_name}</div>
                        <div class="logo-hint">클릭하여 로고를 변경하세요.</div>
                        <form action="/Team/UpdateLogo" method="post" enctype="multipart/form-data" style="margin:0">
                            <input type="hidden" name="team_idx" value="${team.team_idx}">
                            <input type="hidden" name="from" value="managing">
                            <label class="btn-logo-change">
                                로고 변경
                                <input type="file" name="team_logo" accept="image/*" onchange="this.form.submit()" style="display:none">
                            </label>
                        </form>
                    </div>
                </div>
                <div class="managing-area">

                    <%-- 좌측: 소속 선수 리스트 --%>
                    <section class="member-section">
                        <div class="subsection-title">소속 선수 리스트</div>
                        <form id="updateForm" action="/Team/UpdateMemberTeam" method="post">
                            <input type="hidden" name="team_idx" value="${map.team_idx}">
                            <table class="manage-table">
                                <tr>
                                    <td>선수 이름</td>
                                    <td>포지션</td>
                                    <td>배번</td>
                                    <td>선출 여부</td>
                                    <td>제거</td>
                                </tr>
                                <c:forEach var="mt" items="${mt_list}">
                                <tr>
                                    <td>
                                        <input type="hidden" name="member_idx" value="${mt.member_idx}">
                                        ${mt.member_name}
                                    </td>
                                    <td><input type="text"   name="position" value="${mt.position}"></td>
                                    <td><input type="number" name="back_num" value="${mt.back_num}" min="0" max="99"></td>
                                    <td>${mt.elite}</td>
                                    <td>
                                        <c:if test="${team.team_manager ne mt.member_idx}">
                                            <button type="button" class="btn-remove"
                                                onclick="removeMember(${mt.member_idx}, ${map.team_idx})">제거</button>
                                        </c:if>
                                    </td>
                                </tr>
                                </c:forEach>
                            </table>
                        </form>
                    </section>

                    <%-- 우측: 가입 신청 현황 --%>
                    <section class="join-section">
                        <div class="subsection-title">가입 신청 현황</div>
                        <table class="manage-table">
                            <tr>
                                <td>선수 이름</td>
                                <td>포지션</td>
                                <td>배번</td>
                                <td>선출 여부</td>
                                <td>승인</td>
                                <td>거절</td>
                            </tr>
                            <c:forEach var="jt" items="${join_list}">
                            <tr>
                                <td>${jt.member_name}</td>
                                <td>${jt.position}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${jt.back_num != null}">${jt.back_num}</c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${jt.elite}</td>
                                <td>
                                    <button type="button" class="btn-approve"
                                        onclick="approveJoin(${jt.member_idx}, ${map.team_idx})">승인</button>
                                </td>
                                <td>
                                    <button type="button" class="btn-reject"
                                        onclick="rejectJoin(${jt.member_idx}, ${map.team_idx})">거절</button>
                                </td>
                            </tr>
                            </c:forEach>
                        </table>
                    </section>

                </div>

                <%-- 수정 완료 버튼 --%>
                <div class="bottom-bar">
                    <button type="button" class="btn-submit" onclick="submitUpdate()">수정 완료</button>
                </div>

            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

    <%-- 기능 스크립트 및 알림 --%>
    <script>
        function submitUpdate() {
            if (confirm('수정하시겠습니까?')) {
                document.getElementById('updateForm').submit();
            }
        }

        function removeMember(memberIdx, teamIdx) {
            if (confirm('정말 제거하시겠습니까?')) {
                location.href = '/Team/RemoveMember?member_idx=' + memberIdx + '&team_idx=' + teamIdx;
            }
        }

        function approveJoin(memberIdx, teamIdx) {
            if (confirm('승인하시겠습니까?')) {
                location.href = '/Team/ApproveJoin?member_idx=' + memberIdx + '&team_idx=' + teamIdx;
            }
        }

        function rejectJoin(memberIdx, teamIdx) {
            if (confirm('거절하시겠습니까?')) {
                location.href = '/Team/RejectJoin?member_idx=' + memberIdx + '&team_idx=' + teamIdx;
            }
        }

        <c:if test="${map.alert == 'update_ok'}">alert('수정이 완료되었습니다.');</c:if>
        <c:if test="${map.alert == 'approve_ok'}">alert('가입이 승인되었습니다.');</c:if>
        <c:if test="${map.alert == 'reject_ok'}">alert('가입이 거절되었습니다.');</c:if>
        <c:if test="${map.alert == 'remove_ok'}">alert('선수가 방출되었습니다.');</c:if>
    </script>

</body>
</html>