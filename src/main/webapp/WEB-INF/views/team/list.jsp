<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 구단 목록</title>
<link href="/css/common.css" rel="stylesheet" />
<style>

    /* ===== 푸터 flex 레이아웃을 위한 전체 높이 설정 ===== */
    html, body {
        height: 100%;
    }

    /* body를 flex column으로 설정해 footer를 항상 하단에 고정 */
    body {
        background-color: #f5f7fa;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    /* 콘텐츠 영역 - ::before 로 index.png 블러 배경 적용 */
    /* overflow: hidden 으로 scale(1.05) 삐져나옴 + 푸터 가림 방지 */
    .content-area {
        flex: 1;
        padding: 104px 0 32px;
        position: relative;
        overflow: hidden;
    }

    .content-area::before {
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


    /* 팀 목록 컬럼 너비 */
    #list {
        td:nth-of-type(1) { width: 230px; }  /* 팀 이름 */
        td:nth-of-type(2) { width: 110px; }  /* 감독    */
        td:nth-of-type(3) { width: 270px; }  /* 리그    */
        td:nth-of-type(4) { width: 160px; }  /* 선수단  */
        td:nth-of-type(5) { width: 130px; }  /* 연고지  */
    }
 
    /* main-wrapper가 블러 배경 위에 뜨도록 */
    .main-wrapper {
        position: relative;
        z-index: 1;
    }

    /* common.css의 margin-top: 50px 오버라이드 */
    .footer {
        margin-top: 0 !important;
    }

    /* ===== 섹션 헤더 (그린 라벨 + 대각선 줄무늬 + 하단 구분선) ===== */
    /* margin-bottom: 0 으로 아래 카드와 여백 없이 붙임 */
    .section-header {
        display: flex;
        align-items: stretch;
        margin-bottom: 0;
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
            #1a3d1a 0px,
            #1a3d1a 4px,
            transparent 4px,
            transparent 9px
        );
    }

    /* ===== 컨텐츠 카드 (반투명 베이지 + 둥근 모서리) ===== */
    /* 블러 배경 위 반투명 베이지 - 상단 모서리는 섹션 헤더와 붙어 있어 제거 */
    .list-card {
        background: rgba(245, 245, 220, 0.88);
        border-radius: 0 0 10px 10px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 28px 32px;
        margin-bottom: 32px;
    }

    /* ===== 검색 + 구단 만들기 버튼 행 ===== */
    .list-toolbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    .search-form {
        display: flex;
        gap: 8px;
    }

    /* 검색 입력창 - 베이지 카드 위에서 흰 배경으로 구분 */
    .search-input {
        padding: 8px 14px;
        border: 1px solid #dde2ea;
        border-radius: 6px;
        font-size: 14px;
        width: 240px;
        outline: none;
        color: #333;
        background-color: #ffffff;
        transition: border-color 0.2s;
    }

    .search-input:focus {
        border-color: #1a3d1a;
    }

    /* 검색 버튼 */
    .btn-search {
        padding: 8px 20px;
        background-color: #1a3d1a;
        color: #ffffff;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        font-family: 'Oswald', sans-serif;
        letter-spacing: 0.5px;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .btn-search:hover {
        background-color: #2a5a2a;
    }

    /* 구단 만들기 버튼 (a 태그로 단독 사용 - button 중첩 금지) */
    .btn-create {
        padding: 8px 22px;
        background-color: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 6px;
        font-size: 14px;
        font-family: 'Oswald', sans-serif;
        font-weight: 600;
        letter-spacing: 0.5px;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
        transition: background-color 0.2s;
    }

    .btn-create:hover {
        background-color: #e6c200;
        color: #1a3d1a;
    }

    /* ===== 구단 목록 테이블 ===== */
    /* common.css의 전역 border: 1px solid black 오버라이드 */
    #list {
        width: 100%;
        border-collapse: collapse;
        border: none;
    }

    #list td {
        border: none;
        border-bottom: 1px solid #e0dcc8;
        padding: 14px 16px;
        text-align: center;
        font-size: 14px;
        font-weight: 600;
        color: #111111;
    }

    /* 헤더 행 - 그린 배경 + 골드 하단선 */
    #list tr:first-of-type td {
        background-color: #1a3d1a;
        color: #ffffff;
        font-family: 'Oswald', sans-serif;
        font-size: 14px;
        font-weight: 500;
        letter-spacing: 1px;
        border-bottom: 2px solid #FFD700;
        padding: 13px 16px;
    }

    /* 헤더 좌우 상단 모서리 둥글게 */
    #list tr:first-of-type td:first-child { border-radius: 6px 0 0 0; }
    #list tr:first-of-type td:last-child  { border-radius: 0 6px 0 0; }

    /* 데이터 행 hover */
    #list tr:not(:first-of-type):hover td {
        background-color: #ece8d0;
        cursor: pointer;
    }

    /* 컬럼별 너비 및 색상 */
    #list td:nth-of-type(1) { width: 180px; color: #1a3d1a; }      /* 구단명 - 그린 */
    #list td:nth-of-type(2) { width: 120px; color: #111111; }      /* 감독 */
    #list td:nth-of-type(3) { width: 160px; color: #111111; }      /* 리그 */
    #list td:nth-of-type(4) { text-align: left; color: #111111; }  /* 구단 소개 */

    /* ===== 페이징 ===== */
    #paging {
        margin-top: 24px;
        text-align: center;
    }

    /* common.css 전역 테이블 스타일 오버라이드 */
    #paging table {
        border: none;
        margin: 0 auto;
        box-shadow: none;
    }

    #paging td {
        border: none;
        padding: 0 2px;
    }

    #paging a {
        display: inline-block;
        padding: 6px 13px;
        color: #1a3d1a;
        text-decoration: none;
        border-radius: 5px;
        font-size: 14px;
        font-family: 'Oswald', sans-serif;
        border: 1px solid #c8c4aa;
        background: #faf9f0;
        transition: all 0.2s;
    }

    #paging a:hover {
        background-color: #1a3d1a;
        color: #ffffff;
        border-color: #1a3d1a;
    }

    /* 현재 페이지 강조 */
    #paging a.active {
        background-color: #FFD700;
        color: #1a3d1a;
        font-weight: 700;
        border-color: #FFD700;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="content-area">
        <div class="main-wrapper">

            <%-- 섹션 헤더 --%>
            <div class="section-header">
                <span class="section-title">구단 목록</span>
            </div>

            <div class="list-card">

                <%-- 검색 + 구단 만들기 버튼 --%>
                <div class="list-toolbar">
                    <form class="search-form" action="/Team/List" method="get">
                        <input type="hidden" name="nowpage" value="1"/>
                        <input class="search-input" type="text" name="keyword"
                               value="${map.keyword}" placeholder="구단 이름 또는 지역 검색"/>
                        <button class="btn-search" type="submit">검색</button>
                    </form>
                    <%-- a 태그 단독 사용 (button 중첩 금지) --%>
                    <a href="/Team/MakeTeamForm" class="btn-create">구단 만들기</a>
                </div>

                <%-- 구단 목록 테이블 --%>
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

            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>
