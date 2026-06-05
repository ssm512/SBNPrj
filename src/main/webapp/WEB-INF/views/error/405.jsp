<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 405</title>
<link rel="shortcut icon" href="/img/favicon2.png" type="image/png" />
<link href="/css/common.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@400;600;700&display=swap" rel="stylesheet" />
<style>

    html, body {
        height: 100%;
        margin: 0;
    }

    body {
        background-color: #f5f7fa;
        display: flex;
        align-items: center;
        justify-content: center;
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

    .error-card {
        background: rgba(249, 249, 234, 0.93);
        border-radius: 12px;
        box-shadow: 0 4px 24px rgba(26, 61, 26, 0.12);
        padding: 52px 56px;
        text-align: center;
        max-width: 440px;
        width: calc(100% - 48px);
    }

    .error-code {
        font-family: 'Oswald', sans-serif;
        font-size: 88px;
        font-weight: 700;
        color: #FFD700;
        line-height: 1;
        letter-spacing: 4px;
        text-shadow: 0 2px 8px rgba(26, 61, 26, 0.15);
    }

    .error-divider {
        width: 48px;
        height: 3px;
        background: #1a3d1a;
        border-radius: 2px;
        margin: 16px auto;
    }

    .error-title {
        font-family: 'Oswald', sans-serif;
        font-size: 18px;
        font-weight: 700;
        color: #1a3d1a;
        letter-spacing: 1px;
        margin-bottom: 10px;
    }

    .error-msg {
        font-size: 13px;
        color: #666;
        line-height: 1.6;
        margin-bottom: 32px;
    }

    .btn-home {
        display: inline-block;
        padding: 11px 36px;
        background-color: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 6px;
        font-family: 'Oswald', sans-serif;
        font-size: 14px;
        font-weight: 700;
        letter-spacing: 1px;
        text-decoration: none;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .btn-home:hover {
        background-color: #e6c200;
    }

</style>
</head>
<body>
    <div class="error-card">
        <div class="error-code">405</div>
        <div class="error-divider"></div>
        <div class="error-title">잘못된 접근입니다.</div>
        <div class="error-msg">정상적인 경로로 접근해 주세요.</div>
        <a href="/" class="btn-home">홈으로</a>
    </div>
</body>
</html>
