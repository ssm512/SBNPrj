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
  #writer-text{
    text-align:left;
    padding:0 10px;
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
          <button type="button" class="btn active">
            새 글 쓰기
          </button>
        </a>
      </div>
      
    </div>
  
    <form action="/Board/Write" method="post" enctype="multipart/form-data">
    <input type="hidden" name="board_type" value="${map.board_type}" />
    <input type="hidden" name="nowpage"    value="${map.nowpage}" />
    <input type="hidden" name="writer"     value="${sessionScope.login.member_id}" />
    <table>
      <tr>
        <td id="title">제목</td>
        <td id="title-text" colspan="3">
          <input type="text" name="title" placeholder="제목을 입력하세요" />
        </td>
      </tr>
      <tr>
        <td id="title">작성자</td>
        <td id="writer-text" colspan="3">${sessionScope.login.member_id}</td>
      </tr>
      <tr>
        <td id="content">내용</td>
        <td colspan="3">
          <textarea name="content" placeholder="내용을 입력하세요"></textarea>
        </td>
      </tr>
      
      <tr>
        <td class="list" colspan="2">
          <input type="button" value="목록" id="goList" />
        </td>
        <td class="list" colspan="2">
          <input type="submit" value="확인" />
        </td>
      </tr>
    </table>
    </form>
    
    <%@include file="/WEB-INF/include/boardpaging.jsp" %>
    
  </div>
  
  <%@include file="/WEB-INF/include/footer.jsp" %>
  
  <script>
  
  const formEl      = document.querySelector('form');
  const goListEl    = document.querySelector('#goList');
  const titleEl     = document.querySelector('[name="title"]');
  const contentEl   = document.querySelector('[name="content"]');
  
  
  
  // 목록으로 이동하기
  goListEl.onclick  = function() {
	  location.href = '/Board/List?nowpage=1&board_type=${map.board_type}'
  }
  
  // 작성한 내용의 양이 DB 설정값을 초과했을때 500 에러 방지
  function getByteSize(str) {
	  let byte = 0;
	  for (let i = 0; i < str.length; i++) {
		byte += str.charCodeAt(i) > 127 ? 3 : 1;
	}
	  return byte;
  }
  
  formEl.addEventListener('submit', function( e ) {
	  
	  // 제목을 입력하지 않았을 때
	  if(titleEl.value.trim() == '') {
		  alert('제목을 입력하세요')
		  titleEl.focus();
		  e.preventDefault()  // 이벤트 취소
		  e.stopPropagation() // 이벤트 버블링 방지
		  return;
	  }
	  
	  /*
	  // 내용 부분은 null 허용
	  // 내용을 입력하지 않았을 때
	  if(contentEl.value.trim() == '') {
		  alert('내용을 입력하세요')
		  contentEl.focus();
		  e.preventDefault()  // 이벤트 취소
		  e.stopPropagation() // 이벤트 버블링 방지
		  return;
	  }
	  */
	  
	  // 제목이 값을 초과했을 때
	  if( getByteSize(titleEl.value) > 100 ) {
		  alert('제목이 너무 깁니다. (현재' + getByteSize(titleEl.value) + 'byte / 최대 100byte)');
		  titleEl.focus();
		  e.preventDefault()  // 이벤트 취소
		  e.stopPropagation() // 이벤트 버블링 방지
		  return;
	  }
	  
	  // 내용이 값을 초과했을 때
	  if( getByteSize(contentEl.value) > 4000 ) {
		  alert('내용이 너무 깁니다. (현재' + getByteSize(contentEl.value) + 'byte / 최대 4000byte)');
		  contentEl.focus();
		  e.preventDefault()  // 이벤트 취소
		  e.stopPropagation() // 이벤트 버블링 방지
		  return;
	  }
	  
  })
  
  </script>
  
</body>
</html>























