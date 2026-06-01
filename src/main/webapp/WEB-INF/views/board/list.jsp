<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board List</title>

<link rel="shortcut icon" href="/img/favicon.png" type="image/x-icon" />
<link href="/css/common.css" rel="stylesheet" />

<style>

  /* 상단 메뉴 및 검색창 영역 (같은 높이 배치) */
  .top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }

  /* 왼쪽 중상단 카테고리 버튼 스타일 */
  .category-buttons .btn {
    background-color: #ffffff;
    border: 2px solid #005a00; /* 이미지의 초록색 톤 반영 */
    border-radius: 20px;
    padding: 8px 20px;
    margin-right: 10px;
    font-weight: bold;
    cursor: pointer;
  }
  
  .category-buttons .btn:hover {
    background-color: #FFD700;
  }
  
  /* 오른쪽 검색 영역 스타일 */
  #search {
    display: flex;
    align-items: center;
  }
  #search select, #search input[type="text"] {
    padding: 6px;
    border: 1px solid #ccc;
    border-radius: 4px;
    margin-right: 5px;
  }
  #search input[type="submit"] {
    padding: 6px 12px;
    background-color: #ffffff;
    border: 1px solid #005a00;
    border-radius: 4px;
    cursor: pointer;
  }

  /* 중앙 표부분 테이블 스타일 */
  .board-table {
    width: 100%;
    border-collapse: collapse;
    margin: 30px auto;
    text-align: center; /* 텍스트 중앙 정렬 */
  }
  .board-table td {
    padding: 12px;
  }
  .board-table tr:hover {
    background-color: #f9f9f9;
  }
  #tr1 {
    background-color: #F5F5DC;
  }
</style>

</head>
<body>
  <%@include file="/WEB-INF/include/headermenu.jsp" %>
  
  <div class="main-wrapper">
    
    <div class="top-bar">
      <div class="category-buttons">
        <a href="/Board/List?nowpage=1&keyword=&board_type=BOARD_FREE">
          <button type="button" class="btn">
            자유
          </button>
        </a>
        <a href="/Board/List?nowpage=1&keyword=&board_type=BOARD_TEAM">
          <button type="button" class="btn">
            팀 모집
          </button>
        </a>
        <a href="/Board/List?nowpage=1&keyword=&board_type=BOARD_PLAYER">
          <button type="button" class="btn">
            선수 모집
          </button>
        </a>
        <a href="/Board/WriteForm?nowpage=1&keyword=&board_type=${map.board_type}">
          <button type="button" class="btn">
            새 글 쓰기
          </button>
        </a>
      </div>

      <form action="/Board/List" method="get">
        <input type="hidden" name="nowpage" value="1" />
        
        <div id="search">
          <select name="searchType">
            <option value="title" ${map.searchType == 'title' ? 'selected' : '' }>제목</option>
            <option value="writer" ${map.searchType == 'writer' ? 'selected' : '' }>작성자</option>
          </select>
       
          <input type="text" name="keyword" value="${map.keyword}" />
          <input type="submit" value="검색" />
        <input type="hidden" name="board_type" value="${map.board_type}" />
        </div>
      </form>
    </div>
    
    <table class="board-table">
    
        <tr id="tr1">
          <td>번호</td>
          <td>작성자</td>
          <td>제목</td>
          <td>작성일</td>
          <td>조회수</td>
        </tr>
        
        <c:forEach var="board" items="${boardList}">
        <tr>
          <td>${board.board_idx}</td>
          <td>${board.writer}</td>
          <td>
            <a href="/Board/View?nowpage=${map.nowpage}&keyword=${map.keyword}&board_type=${map.board_type}&board_idx=${board.board_idx}">
              ${board.title}
            </a>
          </td>
          <td>${board.regdate}</td>
          <td>${board.hit}</td>
        </tr>
        </c:forEach>
    </table>
    
    <%@include file="/WEB-INF/include/boardpaging.jsp" %>
    
  </div>
  
  <%@include file="/WEB-INF/include/footer.jsp" %> 
</body>
</html>























