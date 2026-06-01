<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 팀 관리</title>
<link href="/css/common.css" rel="stylesheet" />
<style>

    h2 { text-align: center; }

    .managing-area {
        display: flex;
        gap: 40px;
        width: 90%;
        margin: 20px auto;
    }

    .member-section, .join-section {
        flex: 1;
    }

    .section-title {
        display: inline-block;
        border: 2px solid #006400;
        border-radius: 20px;
        padding: 6px 20px;
        font-weight: bold;
        font-size: 14px;
        margin-bottom: 15px;
    }

    .manage-table {
        width: 100%;
        border-collapse: collapse;
    }

    .manage-table td {
        padding: 8px;
        text-align: center;
        border: 1px solid #ccc;
    }

    .manage-table tr:first-of-type {
        background-color: #F5F5DC;
    }

    .manage-table tr:not(:first-of-type):hover {
        background-color: #D9D9D9;
    }

    .manage-table input[type="text"],
    .manage-table input[type="number"] {
        width: 70px;
        padding: 4px;
        text-align: center;
        border: 1px solid #aaa;
        border-radius: 4px;
    }

    .btn-remove  { color: #ff4d4d; font-weight: bold; cursor: pointer; border: none; background: none; font-size: 16px; }
    .btn-approve { color: #006400; font-weight: bold; cursor: pointer; border: none; background: none; font-size: 18px; }
    .btn-reject  { color: #ff4d4d; font-weight: bold; cursor: pointer; border: none; background: none; font-size: 16px; }

    .bottom-bar {
        width: 90%;
        margin: 10px auto;
        text-align: right;
    }

    .btn-submit {
        border: 2px solid #006400;
        background-color: #fff;
        padding: 8px 30px;
        font-weight: bold;
        font-size: 14px;
        border-radius: 20px;
        cursor: pointer;
    }

    .btn-submit:hover {
        background-color: #006400;
        color: #fff;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="main-wrapper">
        <h2>S B N</h2>

        <div class="managing-area">

            <!-- 좌측: 소속 선수 리스트 -->
            <section class="member-section">
                <div class="section-title">소속 선수 리스트</div>
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
                            	<c:if test="${team.team_manager ne mt.member_idx }" >
                                <button type="button" class="btn-remove"
                                    onclick="removeMember(${mt.member_idx}, ${map.team_idx})">✕</button>
                                </c:if>
                            </td>
                        </tr>
                        </c:forEach>
                    </table>
                </form>
            </section>

            <!-- 우측: 가입 신청 현황 -->
            <section class="join-section">
                <div class="section-title">가입 신청 현황</div>
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
                                onclick="approveJoin(${jt.member_idx}, ${map.team_idx})">O</button>
                        </td>
                        <td>
                            <button type="button" class="btn-reject"
                                onclick="rejectJoin(${jt.member_idx}, ${map.team_idx})">✕</button>
                        </td>
                    </tr>
                    </c:forEach>
                </table>
            </section>

        </div>

        <!-- 수정 완료 버튼 -->
        <div class="bottom-bar">
            <button type="button" class="btn-submit" onclick="submitUpdate()">수정 완료</button>
        </div>

    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

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
</script>

	<%-- 수정 완료 알림 --%>
	<c:if test="${map.alert == 'update_ok'}">
	<script>alert('수정이 완료되었습니다.');</script>
	</c:if>

</body>
</html>