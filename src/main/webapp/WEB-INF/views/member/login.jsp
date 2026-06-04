<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 로그인</title>
<link rel="shortcut icon" href="/img/favicon.png" type="image/x-icon" />
<link href="/css/common.css" rel="stylesheet" />
<style>

    /* ===== 푸터 flex 레이아웃을 위한 전체 높이 설정 ===== */
    html, body { height: 100%; }

    /* body를 flex column으로 설정해 footer를 항상 하단에 고정 */
    body {
        background-color: #f5f7fa;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    /* 콘텐츠 영역 - ::before 로 index.png 블러 배경 적용 */
    .page-wrapper {
        flex: 1;
        padding: 104px 0 32px;
        position: relative;
        overflow: hidden;
    }

    .page-wrapper::before {
        content: '';
        position: absolute;
        inset: 0;
        background-image: url('/img/index.png');
        background-size: cover;
        background-position: center 60%;
        filter: blur(10px) brightness(0.85);
        transform: scale(1.05);
        z-index: 0;
    }

    /* main-wrapper가 블러 배경 위에 뜨도록 */
    .main-wrapper {
        position: relative;
        z-index: 1;
    }

    /* common.css의 margin-top: 50px 오버라이드 */
    .footer { margin-top: 0 !important; }

    /* ===== 폼 카드 (반투명 베이지 + 둥근 모서리) ===== */
    .form-card {
        background: rgba(245, 245, 220, 0.88);
        border-radius: 10px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 40px 44px;
        margin: 0 auto;
        margin-bottom: 32px;
        max-width: 420px;
    }

    /* ===== 카드 타이틀 ===== */
    .form-title {
        font-family: 'Oswald', sans-serif;
        font-size: 22px;
        font-weight: 700;
        color: #1a3d1a;
        letter-spacing: 3px;
        text-align: center;
        margin-bottom: 28px;
    }

    /* ===== 폼 필드 그룹 ===== */
    .form-group {
        display: flex;
        flex-direction: column;
        gap: 6px;
        margin-bottom: 16px;
    }

    /* 라벨 - 그린 텍스트 */
    .form-label {
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 1px;
    }

    /* 입력창 - 베이지 카드 위에서 흰 배경으로 구분 */
    .form-input {
        width: 100%;
        padding: 10px 14px;
        border: 1px solid #c8c4aa;
        border-radius: 6px;
        font-size: 14px;
        color: #111111;
        background-color: #ffffff;
        outline: none;
        box-sizing: border-box;
        transition: border-color 0.2s;
    }

    .form-input:focus {
        border-color: #1a3d1a;
    }

    /* ===== 오류 메시지 ===== */
    .form-msg {
        text-align: center;
        font-size: 13px;
        color: #c0392b;
        min-height: 18px;
        margin-bottom: 4px;
    }

    /* ===== 구분선 ===== */
    .form-divider {
        border: none;
        border-top: 1px solid #a8a48a;
        margin: 4px 0 20px;
    }

    /* ===== 로그인 버튼 (골드 배경 + 그린 텍스트) ===== */
    .btn-submit {
        width: 100%;
        padding: 12px;
        background-color: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 6px;
        font-size: 15px;
        font-family: 'Oswald', sans-serif;
        font-weight: 700;
        letter-spacing: 1px;
        cursor: pointer;
        transition: background-color 0.2s;
        margin-bottom: 14px;
    }

    .btn-submit:hover {
        background-color: #e6c200;
    }

    /* ===== 회원가입 링크 ===== */
    .signin-link {
        text-align: center;
        font-size: 13px;
        color: #555;
    }

    .signin-link a {
        color: #1a3d1a;
        font-weight: 700;
        text-decoration: none;
        transition: color 0.2s;
    }

    .signin-link a:hover {
        color: #2a5a2a;
        text-decoration: underline;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">
        <div class="main-wrapper">

            <%-- 로그인 폼 카드 --%>
            <form action="/Member/Login" method="post">
                <div class="form-card">

                    <div class="form-title">LOGIN</div>

                    <div class="form-group">
                        <label class="form-label">아이디</label>
                        <input class="form-input" type="text" name="member_id" placeholder="아이디를 입력하세요" required />
                    </div>

                    <div class="form-group">
                        <label class="form-label">비밀번호</label>
                        <input class="form-input" type="password" name="password" placeholder="비밀번호를 입력하세요" required />
                    </div>

                    <%-- 오류 메시지 --%>
                    <div class="form-msg">${msg}</div>

                    <hr class="form-divider">

                    <button type="submit" class="btn-submit">로그인</button>

                    <div class="signin-link">
                        아직 회원이 아니신가요? <a href="/Member/SigninForm">회원가입</a>
                    </div>

                </div>
            </form>

        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>
