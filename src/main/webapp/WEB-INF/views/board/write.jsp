<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 글 쓰기</title>
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
    .form-card {
        background: rgba(249, 249, 234, 0.93);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 28px 32px;
    }

    /* ===== 카테고리 탭 ===== */
    .category-tabs {
        display: flex;
        gap: 6px;
        align-items: center;
        margin-bottom: 24px;
        padding-bottom: 16px;
        border-bottom: 1px solid #c8c4aa;
    }

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

    /* ===== 폼 필드 ===== */
    .form-group {
        display: flex;
        flex-direction: column;
        gap: 6px;
        margin-bottom: 16px;
    }

    .form-label {
        font-family: 'Oswald', sans-serif;
        font-size: 12px;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 1px;
        text-transform: uppercase;
    }

    .form-input,
    .form-textarea {
        width: 100%;
        padding: 10px 14px;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-size: 14px;
        color: #111;
        background: #fff;
        outline: none;
        box-sizing: border-box;
        transition: border-color 0.2s;
    }

    .form-input:focus,
    .form-textarea:focus { border-color: #1a3d1a; }

    .form-textarea {
        height: 360px;
        resize: vertical;
    }

    .writer-value {
        font-size: 14px;
        color: #555;
        padding: 4px 0;
    }

    /* ===== 하단 버튼 바 ===== */
    .bottom-bar {
        display: flex;
        justify-content: flex-end;
        gap: 8px;
        margin-top: 20px;
        padding-top: 16px;
        border-top: 1px solid #e0dcc8;
    }

    .btn-cancel {
        padding: 9px 24px;
        background: rgba(255, 255, 255, 0.6);
        color: #1a3d1a;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 600;
        cursor: pointer;
        transition: background 0.15s;
    }

    .btn-cancel:hover {
        background: #1a3d1a;
        color: #FFD700;
        border-color: #1a3d1a;
    }

    .btn-submit {
        padding: 9px 24px;
        background: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 700;
        cursor: pointer;
        transition: background 0.15s;
    }

    .btn-submit:hover { background: #e6c200; }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">

        <div class="section-header">글 쓰기</div>

        <div class="main-wrapper">
            <div class="form-card">

                <%-- 카테고리 탭 --%>
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

                <form action="/Board/Write" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="board_type" value="${map.board_type}" />
                    <input type="hidden" name="nowpage"    value="${map.nowpage}" />
                    <input type="hidden" name="writer"     value="${sessionScope.login.member_id}" />

                    <div class="form-group">
                        <label class="form-label">작성자</label>
                        <div class="writer-value">${sessionScope.login.member_id}</div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">제목</label>
                        <input class="form-input" type="text" name="title" placeholder="제목을 입력하세요" />
                    </div>

                    <div class="form-group">
                        <label class="form-label">내용</label>
                        <textarea class="form-textarea" name="content" placeholder="내용을 입력하세요"></textarea>
                    </div>

                    <div class="bottom-bar">
                        <button type="button" class="btn-cancel" id="goList">목록</button>
                        <button type="submit" class="btn-submit">등록</button>
                    </div>
                </form>

            </div>
        </div>
    </div>

    <%@include file="/WEB-INF/include/boardpaging.jsp" %>
    
  
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
