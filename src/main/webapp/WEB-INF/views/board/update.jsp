<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Update</title>

<link rel="shortcut icon" href="/img/favicon2.png" type="image/png" />
<link href="/css/common.css" rel="stylesheet" />

<style>
  /* 상단 메뉴 및 검색창 영역 (같은 높이 배치) */
  .top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    margin-top:20px;
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
    
  table{
    width: 100%;
    border:1px solid black;
    text-align:center;
  }
  #title{
    width:25%;
    height:50px;
    background-color: #F5F5DC;
  }
  #title-text{
    width:75%;
  }
  #content{
    height:400px;
    background-color: #F5F5DC;
  }
  .list{
    width:50%;
    height:50px;
    background-color: #F5F5DC;
  }
  input[type="text"] {
   width:100%;
   height:45px;
   padding:0 10px;
   text-align:left;
   vertical-align:top;
   border:none;
  }
  textarea{
    width:100%;
    height:400px;
    text-align:left;
    vertical-align:top;
    border:none;
    padding:10px;
  }
  input[type="button"], input[type="submit"]{
    width:100%;
    height:100%;
    background-color: #F5F5DC;
    border:none;
  }
  input[type="button"]:hover, input[type="submit"]{
    width:100%;
    height:100%;
    background-color: #D9D9D9;
    border:none;
  }
  .category-buttons .btn.active {
    background-color: #FFD700;
  }
  
</style>
</head>
<body>
  <%@include file="/WEB-INF/include/headermenu.jsp" %>
  
  <div class="main-wrapper">
  
  <div class="top-bar">
  
      <div class="category-buttons">
        <a href="/Board/List?nowpage=1&keyword=&board_type=BOARD_FREE">
          <button type="button" class="btn ${map.board_type == 'BOARD_FREE' ? 'active' : ''}">
            자유
          </button>
        </a>
        <a href="/Board/List?nowpage=1&keyword=&board_type=BOARD_TEAM">
          <button type="button" class="btn ${map.board_type == 'BOARD_TEAM' ? 'active' : ''}">
            팀 모집
          </button>
        </a>
        <a href="/Board/List?nowpage=1&keyword=&board_type=BOARD_PLAYER">
          <button type="button" class="btn ${map.board_type == 'BOARD_PLAYER' ? 'active' : ''}">
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
  
    <form action="/Board/Update" method="post">
      <input type="hidden" name="board_idx"  value="${board.board_idx}" />
      <input type="hidden" name="board_type" value="${board.board_type}" />
      <input type="hidden" name="nowpage"    value="${map.nowpage}" />

      <table>
        <tr>
          <td id="title">제목</td>
          <td id="title-text" colspan="3">
            <input type="text" name="title" value="${board.title}" />
          </td>
        </tr>
        <tr>
          <td id="content">내용</td>
          <td colspan="3">
            <textarea name="content">${board.content}</textarea>
          </td>
        </tr>
        <tr>
          <td class="list" colspan="2">
            <input type="button" value="취소" id="goView" />
          </td>
          <td class="list" colspan="2">
            <input type="submit" value="수정 완료" />
          </td>
        </tr>
      </table>
    </form>
    
  </div>

  <%@include file="/WEB-INF/include/footer.jsp" %>

  <script>
    document.querySelector('#goView').onclick = function() {
      location.href = '/Board/View?board_idx=${board.board_idx}&board_type=${board.board_type}&nowpage=${map.nowpage}';
    }
  </script>
</body>
</html>