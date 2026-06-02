<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 구단 관리</title>
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

    /* 콘텐츠 영역이 남은 공간을 모두 차지해 푸터를 하단으로 밀어냄 */
    .page-wrapper {
        flex: 1;
        padding: 104px 0 32px;
    }

    /* common.css의 margin-top: 50px 오버라이드 */
    .footer { margin-top: 0 !important; }

    /* ===== 섹션 헤더 (그린 라벨 + 대각선 줄무늬 + 하단 구분선) ===== */
    .section-header {
        display: flex;
        align-items: stretch;
        margin-bottom: 16px;
        border-bottom: 2px solid #1a3d1a;
    }

    .section-title {
        background-color: #1a3d1a;
        color: #FFD700;
        font-family: 'Oswald', sans-serif;
        font-size: 15px;
        font-weight: 700;
        padding: 9px 22px;
        letter-spacing: 2px;
        position: relative;
    }

    /* 라벨 우측 대각선 줄무늬 장식 */
    .section-title::after {
        content: '';
        position: absolute;
        right: -18px;
        top: 0;
        width: 18px;
        height: 100%;
        background: repeating-linear-gradient(
            -55deg,
            #1a3d1a 0px, #1a3d1a 4px,
            transparent 4px, transparent 9px
        );
    }

    /* ===== 관리 카드 (베이지 배경 + 둥근 모서리) ===== */
    .managing-card {
        background: #F5F5DC;
        border-radius: 10px;
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
    .manage-table tr:first-of-type td:first-child { border-radius: 6px 0 0 0; }
    .manage-table tr:first-of-type td:last-child  { border-radius: 0 6px 0 0; }

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
        border-radius: 4px;
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
        border-radius: 4px;
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
        border-radius: 4px;
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
        border-radius: 6px;
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
        <div class="main-wrapper">

            <%-- 섹션 헤더 --%>
            <div class="section-header">
                <span class="section-title">구단 관리</span>
            </div>

            <div class="managing-card">

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