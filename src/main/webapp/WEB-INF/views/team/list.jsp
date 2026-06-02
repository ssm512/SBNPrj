<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 팀 목록</title>
<link href="/css/common.css" rel="stylesheet" />
<style>

    h2 {
        text-align: center;
    }

    table {
        width: 90%;
        margin: 0 auto;
    }

    td {
        padding: 5px;
        text-align: center;
    }

    /* 헤더 행 */
    tr:first-of-type {
        background-color: #F5F5DC;
        color: black;
        td {
            border: 1px solid white;
        }
    }

    /* 팀 목록 컬럼 너비 */
    #list {
        td:nth-of-type(1) { width: 230px; }  /* 팀 이름 */
        td:nth-of-type(2) { width: 110px; }  /* 감독    */
        td:nth-of-type(3) { width: 270px; }  /* 리그    */
        td:nth-of-type(4) { width: 160px; }  /* 선수단  */
        td:nth-of-type(5) { width: 130px; }  /* 연고지  */
    }

    #list tr:not(:first-of-type):hover {
        background-color: #D9D9D9;
        cursor: pointer;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="main-wrapper">
        <h2>S B N</h2>

        <%-- 검색창: 검색 시 1페이지로 초기화 --%>
        <div style="width:70%; margin:10px auto; text-align:right;">
            <form action="/Team/List" method="get" style="display:inline;">
                <input type="hidden" name="nowpage" value="1"/>
                <input type="text" name="keyword" value="${map.keyword}" placeholder="검색(팀 이름 또는 지역)"/>
                <button type="submit">검색</button>
            </form>
        </div>

        <%-- 팀 목록 테이블 --%>
        <table id="list">
            <tr>
                <td>팀 이름</td>
                <td>감독</td>
                <td>리그</td>
                <td>선수단</td>
                <td>연고지</td>
            </tr>

            <%-- 팀 목록 출력: 클릭 시 팀 상세 페이지로 이동 --%>
            <c:forEach var="team" items="${team_list}">
                <tr onclick="location.href='/Team/Info?team_idx=${team.team_idx}&keyword='" style="cursor:pointer;">
                    <td>${team.team_name   }</td>
                    <td>${team.member_name }</td>
                    <td>${team.league_name }
                    	<c:if test="${ team.join_league_count eq 0 }" >
                    		<span style="color: gray;">없음</span>
                    	</c:if>
                    	<c:if test="${ team.join_league_count gt 1 }" >
                    		<br><b>외 ${ team.join_league_count - 1}개 리그</b>
                    	</c:if>
                    </td>
                    <td>${team.member_count} 명</td>
                    <td>${team.team_location}</td>
                </tr>
            </c:forEach>
        </table>

        <%-- 페이징 --%>
        <div style="width:70%; margin:5px auto; text-align:center;">
            <%@ include file="/WEB-INF/include/teampaging.jsp" %>
        </div>

        <%-- 팀 생성 버튼 --%>
        <div style="width:70%; margin:5px auto; text-align:right;">
            <a href="/Team/MakeTeamForm"><button type="button">팀 생성</button></a>
        </div>

    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>