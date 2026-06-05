<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 게시판</title>
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
    .list-card {
        background: rgba(249, 249, 234, 0.93);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 28px 32px;
    }

    /* ===== 툴바 (카테고리 탭 + 검색) ===== */
    .list-toolbar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        padding-bottom: 16px;
        border-bottom: 1px solid #c8c4aa;
    }

    /* ===== 카테고리 탭 ===== */
    .category-tabs { display: flex; gap: 6px; align-items: center; }

    .tab-btn {
        padding: 7px 16px;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 600;
        letter-spacing: 0.5px;
        color: #1a3d1a;
        background: rgba(255, 255, 255, 0.6);
        text-decoration: none;
        transition: background 0.15s, color 0.15s;
        cursor: pointer;
    }

    .tab-btn:hover {
        background: #1a3d1a;
        color: #FFD700;
        border-color: #1a3d1a;
    }

    .tab-btn.active {
        background: #FFD700;
        color: #1a3d1a;
        border-color: #FFD700;
        font-weight: 700;
    }

    .tab-btn.write {
        background: #1a3d1a;
        color: #FFD700;
        border-color: #1a3d1a;
    }

    .tab-btn.write:hover { background: #2a5a2a; border-color: #2a5a2a; }

    /* ===== 검색 ===== */
    .search-form { display: flex; gap: 6px; }

    .search-select,
    .search-input {
        padding: 7px 10px;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-size: 13px;
        color: #333;
        background: #fff;
        outline: none;
        transition: border-color 0.15s;
    }

    .search-select { width: 90px; }
    .search-input  { width: 180px; }

    .search-select:focus,
    .search-input:focus { border-color: #1a3d1a; }

    .btn-search {
        padding: 7px 18px;
        background: #1a3d1a;
        color: #fff;
        border: none;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 600;
        cursor: pointer;
        transition: background 0.15s;
    }

    .btn-search:hover { background: #2a5a2a; }

    /* ===== 게시판 테이블 ===== */
    #board-table {
        width: 100%;
        border-collapse: collapse;
        border: none !important;
    }

    #board-table tr { border: none !important; }

    /* 헤더 행 */
    #board-table tr:first-of-type td {
        font-family: 'Oswald', sans-serif;
        font-size: 14px !important;
        font-weight: 600 !important;
        color: #1a3d1a !important;
        letter-spacing: 1.5px;
        text-transform: uppercase;
        padding: 8px 16px 10px !important;
        background: rgba(26, 61, 26, 0.08) !important;
        border: none !important;
        border-bottom: 2px solid #1a3d1a !important;
        border-radius: 0 !important;
        text-align: center !important;
    }

    /* 데이터 행 */
    #board-table tr:not(:first-of-type) td {
        border: none !important;
        border-bottom: 1px solid #e0dcc8 !important;
        padding: 13px 16px !important;
        font-size: 14px !important;
        font-weight: 500 !important;
        color: #222 !important;
        background: rgba(255, 255, 255, 0.4) !important;
        text-align: center !important;
    }

    #board-table tr:not(:first-of-type):hover td {
        background: #ece8d0 !important;
        cursor: pointer;
    }

    #board-table a {
        text-decoration: none;
        color: #222;
    }

    #board-table a:hover { color: #1a3d1a; }

    /* ===== 페이징 ===== */
    #paging {
        margin-top: 24px;
        text-align: center;
    }

    #paging table {
        border: none !important;
        margin: 0 auto;
        box-shadow: none;
    }

    #paging td {
        border: none !important;
        padding: 0 2px !important;
        background: none !important;
    }

    #paging a {
        display: inline-block;
        padding: 6px 13px;
        color: #1a3d1a;
        text-decoration: none;
        border-radius: 3px;
        font-size: 13px;
        font-family: 'Oswald', sans-serif;
        border: 1px solid #c8c4aa;
        background: rgba(255, 255, 255, 0.7);
        transition: all 0.15s;
    }

    #paging a:hover {
        background: #1a3d1a;
        color: #fff;
        border-color: #1a3d1a;
    }

    #paging a.active {
        background: #FFD700;
        color: #1a3d1a;
        font-weight: 700;
        border-color: #FFD700;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">

        <div class="section-header">
            <c:choose>
                <c:when test="${map.board_type == 'BOARD_FREE'}">자유 게시판</c:when>
                <c:when test="${map.board_type == 'BOARD_TEAM'}">팀 모집 게시판</c:when>
                <c:when test="${map.board_type == 'BOARD_PLAYER'}">선수 모집 게시판</c:when>
                <c:otherwise>게시판</c:otherwise>
            </c:choose>
        </div>

        <div class="main-wrapper">
            <div class="list-card">

                <%-- 툴바: 카테고리 탭 + 검색 --%>
                <div class="list-toolbar">

                    <div class="category-tabs">
                        <a href="/Board/List?nowpage=1&keyword=&board_type=BOARD_FREE"
                           class="tab-btn ${map.board_type == 'BOARD_FREE' ? 'active' : ''}">자유</a>
                        <a href="/Board/List?nowpage=1&keyword=&board_type=BOARD_TEAM"
                           class="tab-btn ${map.board_type == 'BOARD_TEAM' ? 'active' : ''}">팀 모집</a>
                        <a href="/Board/List?nowpage=1&keyword=&board_type=BOARD_PLAYER"
                           class="tab-btn ${map.board_type == 'BOARD_PLAYER' ? 'active' : ''}">선수 모집</a>
                        <a href="/Board/WriteForm?nowpage=1&keyword=&board_type=${map.board_type}"
                           class="tab-btn write">새 글 쓰기</a>
                    </div>

                    <form class="search-form" action="/Board/List" method="get">
                        <input type="hidden" name="nowpage"    value="1" />
                        <input type="hidden" name="board_type" value="${map.board_type}" />
                        <select class="search-select" name="searchType">
                            <option value="title"  ${map.searchType == 'title'  ? 'selected' : ''}>제목</option>
                            <option value="writer" ${map.searchType == 'writer' ? 'selected' : ''}>작성자</option>
                        </select>
                        <input class="search-input" type="text" name="keyword" value="${map.keyword}" />
                        <button class="btn-search" type="submit">검색</button>
                    </form>

                </div>

                <%-- 게시글 목록 테이블 --%>
                <table id="board-table">
                    <tr>
                        <td style="width:8%">번호</td>
                        <td style="width:12%">작성자</td>
                        <td>제목</td>
                        <td style="width:18%">작성일</td>
                        <td style="width:8%">조회수</td>
                    </tr>
                    <c:forEach var="board" items="${boardList}">
                    <tr onclick="location.href='/Board/View?nowpage=${map.nowpage}&keyword=${map.keyword}&board_type=${map.board_type}&board_idx=${board.board_idx}'">
                        <td>${board.board_idx}</td>
                        <td>${board.writer}</td>
                        <td style="text-align:left"><c:out value="${board.title}" /></td>
                        <td>${board.regdate}</td>
                        <td>${board.hit}</td>
                    </tr>
                    </c:forEach>
                </table>

                <%-- 페이징 --%>
                <div id="paging">
                    <%@ include file="/WEB-INF/include/boardpaging.jsp" %>
                </div>

            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>
    
    <c:if test="${ param.error == 'true'}" >
    	<script>
    		alert('권한이 없습니다.')
    	</script>
    </c:if>
</body>
</html>
