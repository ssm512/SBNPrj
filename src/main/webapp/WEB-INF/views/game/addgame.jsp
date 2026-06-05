<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 경기 추가</title>
<link rel="shortcut icon" href="/img/favicon2.png" type="image/png" />
<link href="/css/common.css" rel="stylesheet" />
<link href="https://webfontworld.github.io/sunn/SCDream.css" rel="stylesheet" />
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
        font-family: 'S-Core Dream', sans-serif;
        font-size: 24px;
        font-weight: 700;
        letter-spacing: 3px;
        margin: 0 auto 16px;
        border-radius: 3px;
        max-width: 500px;
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

    /* ===== 폼 카드 ===== */
    .form-card {
        background: rgba(249, 249, 234, 0.93);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 32px 40px;
        max-width: 500px;
        margin: 0 auto;
    }

    /* ===== 폼 그룹 ===== */
    .form-group {
        display: flex;
        flex-direction: column;
        gap: 6px;
        margin-bottom: 16px;
    }

    .form-label {
        font-family: 'S-Core Dream', sans-serif;
        font-size: 13px;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 1px;
    }

    /* ===== 입력창 ===== */
    .form-input {
        width: 100%;
        height: 38px;
        padding: 0 12px;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-size: 14px;
        font-family: 'S-Core Dream', sans-serif;
        background: #fff;
        outline: none;
        box-sizing: border-box;
        transition: border-color 0.15s;
    }

    .form-input:focus { border-color: #1a3d1a; }

    .form-input::placeholder { color: #aaa; }

    /* ===== 구분선 ===== */
    .form-divider {
        border: none;
        border-top: 1px solid #c8c4aa;
        margin: 8px 0 20px;
    }

    /* ===== 버튼 ===== */
    .btn-submit {
        width: 100%;
        height: 40px;
        background-color: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 3px;
        font-family: 'S-Core Dream', sans-serif;
        font-size: 15px;
        font-weight: 700;
        letter-spacing: 1px;
        cursor: pointer;
        transition: background 0.15s;
        margin-bottom: 8px;
    }

    .btn-submit:hover { background-color: #e6c200; }

    .btn-back {
        width: 100%;
        height: 40px;
        background: transparent;
        color: #1a3d1a;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-family: 'S-Core Dream', sans-serif;
        font-size: 14px;
        font-weight: 600;
        letter-spacing: 0.5px;
        cursor: pointer;
        transition: background 0.15s, color 0.15s;
    }

    .btn-back:hover {
        background: #1a3d1a;
        color: #FFD700;
        border-color: #1a3d1a;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">

        <div class="section-header">경기 추가</div>

        <form action="/Game/AddGame" method="post">
            <input type="hidden" name="league_idx" value="${map.league_idx}">
            <div class="form-card">

                <div class="form-group">
                    <label class="form-label">홈팀명</label>
                    <input class="form-input" type="text" name="home_name" placeholder="홈팀명 입력" />
                </div>
                <div class="form-group">
                    <label class="form-label">어웨이팀명</label>
                    <input class="form-input" type="text" name="away_name" placeholder="어웨이팀명 입력" />
                </div>
                <div class="form-group">
                    <label class="form-label">경기 날짜</label>
                    <input class="form-input" type="text" name="game_date" placeholder="2026-05-26" />
                </div>
                <div class="form-group">
                    <label class="form-label">경기 시간</label>
                    <input class="form-input" type="text" name="game_time" placeholder="18:30" />
                </div>
                <div class="form-group">
                    <label class="form-label">경기 장소</label>
                    <input class="form-input" type="text" name="game_field" placeholder="경기 장소 입력" />
                </div>

                <hr class="form-divider">

                <input type="submit" class="btn-submit" value="추가" />
                <input type="button" class="btn-back" value="경기목록"
                       onclick="location.href='/League/Info?league_idx=${map.league_idx}'" />

            </div>
        </form>

    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

</body>
</html>
