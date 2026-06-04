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
    .view-card {
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
        margin-bottom: 20px;
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

    /* ===== 게시글 본문 ===== */
    .post-meta {
        display: flex;
        gap: 24px;
        padding: 12px 0;
        border-bottom: 1px solid #e0dcc8;
    }

    .post-meta-item {
        font-size: 13px;
        color: #555;
    }

    .post-meta-item span {
        font-family: 'Oswald', sans-serif;
        font-size: 11px;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 1px;
        text-transform: uppercase;
        margin-right: 6px;
    }

    .post-title {
        font-size: 18px;
        font-weight: 700;
        color: #111;
        padding: 16px 0 14px;
        border-bottom: 1px solid #e0dcc8;
        word-break: break-word;
    }

    .post-content {
        padding: 20px 0;
        font-size: 15px;
        color: #222;
        line-height: 1.7;
        min-height: 200px;
        white-space: pre-wrap;
        border-bottom: 1px solid #e0dcc8;
    }

    /* ===== 하단 버튼 바 ===== */
    .bottom-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 20px;
    }

    .btn-action {
        padding: 8px 22px;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 600;
        letter-spacing: 0.5px;
        text-decoration: none;
        display: inline-block;
        transition: background 0.15s;
        cursor: pointer;
    }

    .btn-list {
        background: rgba(255, 255, 255, 0.6);
        color: #1a3d1a;
        border: 1px solid #c8c4aa;
    }

    .btn-list:hover {
        background: #1a3d1a;
        color: #FFD700;
        border-color: #1a3d1a;
    }

    .btn-edit {
        background: #FFD700;
        color: #1a3d1a;
        border: 1px solid #FFD700;
        margin-right: 8px;
    }

    .btn-edit:hover { background: #e6c200; border-color: #e6c200; }

    .btn-delete {
        background: transparent;
        color: #b03030;
        border: 1.5px solid #b03030;
    }

    .btn-delete:hover {
        background: #b03030;
        color: #fff;
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
            <div class="view-card">

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

                <%-- 메타 정보 --%>
                <div class="post-meta">
                    <div class="post-meta-item"><span>작성자</span>${board.writer}</div>
                    <div class="post-meta-item"><span>작성일</span>${board.regdate}</div>
                    <div class="post-meta-item"><span>조회수</span>${board.hit}</div>
                </div>

                <%-- 제목 --%>
                <div class="post-title"><c:out value="${board.title}" /></div>

                <%-- 본문 --%>
                <div class="post-content"><c:out value="${board.content}" /></div>

                <%-- 하단 버튼 바 --%>
                <div class="bottom-bar">
                    <a href="/Board/List?nowpage=${map.nowpage}&keyword=&board_type=${map.board_type}"
                       class="btn-action btn-list">목록</a>
                    <c:if test="${sessionScope.login.member_id == board.writer || sessionScope.login.is_admin == 'Y'}">
                        <div>
                            <a href="/Board/UpdateForm?board_idx=${board.board_idx}&board_type=${map.board_type}&nowpage=${map.nowpage}"
                               class="btn-action btn-edit">수정</a>
                            <a href="/Board/Delete?board_idx=${board.board_idx}&board_type=${map.board_type}&nowpage=${map.nowpage}"
                               class="btn-action btn-delete"
                               onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
                        </div>
                    </c:if>
                </div>

            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>
