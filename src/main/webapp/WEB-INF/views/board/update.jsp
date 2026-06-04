<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 글 수정</title>
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
        font-size: 20px;
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
        background: rgba(245, 245, 220, 0.88);
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

        <div class="section-header">글 수정</div>

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

                <form action="/Board/Update" method="post">
                    <input type="hidden" name="board_idx"  value="${board.board_idx}" />
                    <input type="hidden" name="board_type" value="${board.board_type}" />
                    <input type="hidden" name="nowpage"    value="${map.nowpage}" />

                    <div class="form-group">
                        <label class="form-label">제목</label>
                        <input class="form-input" type="text" name="title" value="${board.title}" />
                    </div>

                    <div class="form-group">
                        <label class="form-label">내용</label>
                        <textarea class="form-textarea" name="content">${board.content}</textarea>
                    </div>

                    <div class="bottom-bar">
                        <button type="button" class="btn-cancel" id="goView">취소</button>
                        <button type="submit" class="btn-submit">수정 완료</button>
                    </div>
                </form>

            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>


  <script>
    document.querySelector('#goView').onclick = function() {
      location.href = '/Board/View?board_idx=${board.board_idx}&board_type=${board.board_type}&nowpage=${map.nowpage}';
    }
    
    const formEl  = document.querySelector('form')
    const titleEl = document.querySelector('[name="title"]');
    
    formEl.addEventListener('submit', function( e ) {
    	
    	// 수정할 때 제목을 입력하지 않으면
    	if(titleEl.value.trim() == '') {
    		alert('제목을 입력하세요')
    		titleEl.focus();
    		e.preventDefault()  // 이벤트 취소
    		e.stopPropagation() // 이벤트 버블링 방지
    		return;
    	}
    })
  </script>
</body>
</html>



