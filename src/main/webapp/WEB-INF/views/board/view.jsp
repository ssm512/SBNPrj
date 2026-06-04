<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board View</title>

<link rel="shortcut icon" href="/img/favicon.png" type="image/x-icon" />
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
    white-space: pre-wrap; /* 줄 바꿈 문자를 줄 바꿈으로 출력해줌 */
  }
  .category-buttons .btn.active {
    background-color: #FFD700;
  }
  .td-writer:hover {background-color: #D9D9D9;}
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
    
    <table>
      <tr>
        <td class="td1" style="width:25%;">글 번호</td>
        <td style="width:25%;">${board.board_idx}</td>
        <td class="td1" style="width:25%;">조회수</td>
        <td style="width:25%;">${board.hit}</td>
      </tr>
      <tr>
        <td class="td2">작성자</td>
        <td class="td-writer">
          <a href="/Member/Stats?member_idx=${map.member_idx}">
            ${board.writer}
          </a>
        </td>
        <td class="td2">작성일</td>
        <td>${board.regdate }</td>
      </tr>
      <tr>
        <td class="td3">제목</td>
        <td id="title" colspan="3"><c:out value="${board.title}" /></td>
      </tr>
      <tr>
        <td class="td4">내용</td>
        <td id="content" colspan="3"><c:out value="${board.content}" /></td>
      </tr>
      <tr>
        <td class="td5" colspan="2">
          <a href="/Board/WriteForm?nowpage=${map.nowpage}&board_type=${map.board_type}">
            새 글 쓰기
          </a>
        </td>
        <td class="td5" colspan="2">
          <a href="/Board/List?nowpage=${map.nowpage}&keyword=&board_type=${map.board_type}">
            목록
          </a>
        </td>
      </tr>
      <c:if test="${sessionScope.login.member_id == board.writer || sessionScope.login.is_admin == 'Y' }">
      <tr>
        <td class="td5" colspan="2">
          <a href="/Board/UpdateForm?board_idx=${board.board_idx}&board_type=${map.board_type}&nowpage=${map.nowpage}">
            수정
          </a>
        </td>
        <td class="td5" colspan="2">
          <a href="/Board/Delete?board_idx=${board.board_idx}&board_type=${map.board_type}&nowpage=${map.nowpage}"
             onclick="return confirm('정말 삭제하시겠습니까?')">
            삭제
          </a>
        </td>
      </tr>
      </c:if>
    </table>
    
  </div>
  
  <%@include file="/WEB-INF/include/footer.jsp" %> 
</body>
</html>























