<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Write</title>

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
  table {
    width: 100%;
    border-collapse: collapse;
    margin: 30px auto;
    text-align: center; /* 텍스트 중앙 정렬 */
  }
  .td1 {
    height:50px;
    background-color: #F5F5DC;
  }
  .td2 {
    height:50px;
    background-color: #F5F5DC;
  }
  .td3 {
    height:50px;
    background-color: #F5F5DC;
  }
  .td4 {
    height:400px;
    background-color: #F5F5DC;
  }
  .td5 {
    height:50px;
    background-color: #F5F5DC;
  }
  a {
    text-decoration: none;
    color:black;
  }
  #title {
    text-align:left;
    padding:10px;
  }
  #content {
    text-align: left;
    vertical-align: top;
    padding:10px;
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
      
    </div>
    
    <table>
      <tr>
        <td class="td1" style="width:25%;">글 번호</td>
        <td style="width:25%;">${board.board_idx}</td>
        <td class="td1" style="width:25%;">조회수</td>
        <td style="width:25%;">${board.hit}</td>
      </tr>
      <tr>
        <td class="td2">작성자</td>
        <td>${board.writer}</td>
        <td class="td2">작성일</td>
        <td>${board.regdate }</td>
      </tr>
      <tr>
        <td class="td3">제목</td>
        <td id="title" colspan="3">${board.title}</td>
      </tr>
      <tr>
        <td class="td4">내용</td>
        <td id="content" colspan="3">${board.content}</td>
      </tr>
      <tr>
        <td class="td5">
          <a href="">
            새 글 쓰기
          </a>
        </td>
        <td class="td5">
          <a href="">
            수정
          </a>
        </td>
        <td class="td5">
          <a href="">
            삭제
          </a>
        </td>
        <td class="td5">
          <a href="">
            목록
          </a>
        </td>
      </tr>
    </table>
    
  </div>
  
  <%@include file="/WEB-INF/include/footer.jsp" %> 
</body>
</html>























