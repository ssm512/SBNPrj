<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 팀 정보</title>
<link href="/css/common.css" rel="stylesheet" />
<style>

    h2 { text-align: center; }

    /* ===== 팀 이름 / 검색 영역 ===== */
    .top-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .team-name-btn {
        padding: 8px 24px;
        border: 2px solid #006500;
        background-color: #F5F5DC;
        font-size: 16px;
        font-weight: bold;
        border-radius: 20px;
    }

    /* ===== 좌우 레이아웃 ===== */
    .content-area {
        display: flex;
        gap: 20px;
    }

    /* ===== 좌측 팀 정보 테이블 ===== */
    .team-info-table {
        width: 200px;
        flex-shrink: 0;
        border-collapse: collapse;
    }

    .team-info-table td {
        padding: 10px;
        border: 1px solid #ccc;
        text-align: center;
    }

    .team-info-table td:first-child {
        background-color: #F5F5DC;
        font-weight: bold;
        width: 70px;
    }

    /* ===== 우측 선수 목록 테이블 ===== */
    .player-table {
        width: 100%;
        border-collapse: collapse;
    }

    .player-table td {
        padding: 8px;
        text-align: center;
        border: 1px solid #ccc;
    }

    .player-table tr:first-of-type {
        background-color: #F5F5DC;
        td { border: 1px solid white; }
    }

    .player-table tr:not(:first-of-type):hover {
        background-color: #D9D9D9;
        cursor: pointer;
    }

    /* ===== 하단 바 ===== */
    .bottom-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 10px;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="main-wrapper">
    
    	  <h2>S B N</h2>

        <!-- 팀 이름 / 검색 -->
        <div class="top-bar">
            <button class="team-name-btn">${team.team_name}</button>
            <form action="/Team/Info" method="get">
                <input type="hidden" name="team_idx" value="${map.team_idx}">
                <input type="text" name="keyword" value="${map.keyword}" placeholder="검색(선수 이름 또는 포지션)">
                <button type="submit">검색</button>
            </form>
        </div>

        <!-- 팀 정보 + 선수 목록 -->
        <div class="content-area">

            <!-- 좌측: 팀 정보 -->
            <table class="team-info-table">
                <tr><td>감독</td>    <td>${team.member_name  }</td></tr>
                <tr><td>연고지</td>  <td>${team.team_location}</td></tr>
                <tr><td>창단일</td><td><fmt:formatDate value="${team.team_regdate}" pattern="yyyy년 MM월 dd일"/></td></tr>
                <tr><td>선수단</td>  <td>${team.member_count }명</td></tr>
                <tr><td>소속 리그</td>
    				<td><c:forEach var="league" items="${league_list}" varStatus="s">
            			${league}<c:if test="${!s.last}">, </c:if></c:forEach></td></tr>
            </table>

            <!-- 우측: 선수 목록 -->
            <table class="player-table">
                <tr>
                    <td>선수 이름</td>
                    <td>포지션</td>
                    <td>배번</td>
                    <td>선출 여부</td>
                </tr>
		<c:forEach var="mt" items="${mt_list}">
		    <tr onclick='location.href="/Member/Stats?member_idx=${ mt.member_idx }"'>
		        <td>${mt.member_name}</td>
		        <td>${mt.position   }</td>
		        <td>
				    <c:choose>
				        <c:when test="${mt.back_num != null}">${mt.back_num} 번</c:when>
				        <c:otherwise>-</c:otherwise>
				    </c:choose>
				</td>
		        <td>${mt.elite      }</td>
		    </tr>
		</c:forEach>
            </table>

        </div>

        <!-- 하단 바 -->
        <div class="bottom-bar">
            <a href="/Team/Join?team_idx=${map.team_idx}"><button type="button">팀 가입 신청</button></a>
            <div><%@ include file="/WEB-INF/include/teampaging.jsp" %></div>
            <a href="/Team/Managing?team_idx=${map.team_idx}"><button type="button">팀 관리(승인 및 수정)</button></a>
        </div>

    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>
    
	    <c:if test="${map.alert == 'no_permission'}">
	<script>
	    alert('팀관리 권한이 없습니다.');
	</script>
	</c:if>
</body>
</html>