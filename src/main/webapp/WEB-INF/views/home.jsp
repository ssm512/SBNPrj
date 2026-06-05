<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN</title>
<link rel="shortcut icon" href="/img/favicon2.png" type="image/png" />
<link href="/css/common.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap" rel="stylesheet" />
<style>

    /* ===== 스크롤바 고정 (레이아웃 중앙 일치용) ===== */
    html {
        overflow-y: scroll;
    }

    /* ===== 상단 고정 그라디언트 (네비바 가독성) ===== */
    .top-gradient {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 130px;
        background: linear-gradient(to bottom, rgba(0, 0, 0, 0.5) 0%, transparent 100%);
        pointer-events: none;
        z-index: 99;
    }

    /* ===== 네비바 오버라이드 (투명 배경 - 히어로 이미지 위에 띄우기) ===== */
    .navbar {
        position: fixed !important;
        background-color: transparent !important;
        border-bottom-color: transparent !important;
        backdrop-filter: none;
        -webkit-backdrop-filter: none;
        box-shadow: none;
    }

    /* 스크롤 시 투톤 그린으로 전환 (JS에서 .scrolled 클래스 토글) */
    .navbar.scrolled {
        background: linear-gradient(to bottom, rgba(34, 82, 34, 0.95) 0%, rgba(23, 61, 23, 0.95) 100%) !important;
        box-shadow: 0 3px 14px rgba(0, 0, 0, 0.35);
    }

    /* navbar-inner - home에서는 padding만 유지 (position: relative는 common.css에서 상속) */
    .navbar-inner {
        width: 100%;
        padding: 0 48px;
        position: relative;
    }

    /* 로고 색상 - 투명 네비바 위에서도 골드 유지 */
    .navbar-brand {
        color: #FFD700;
        text-shadow: none;
    }

    /* 메뉴 위치 - common.css의 -63% 대신 홈 전용 -60% 적용 */
    .navbar-menu {
        position: absolute;
        left: 50%;
        transform: translateX(calc(-60% + 20px));
    }

    /* 메뉴 링크 - 배경 이미지 위 가독성을 위해 텍스트 쉐도우 추가 */
    .navbar-menu a {
        color: #ffffff;
        text-shadow: 0 1px 8px rgba(0, 0, 0, 0.9);
    }

    .navbar-menu a:hover {
        color: #FFD700;
    }

    /* 로그인 / 로그아웃 - 배경 이미지 위 가독성을 위해 텍스트 쉐도우 추가 */
    .navbar-auth a {
        color: #ffffff;
        text-shadow: 0 1px 8px rgba(0, 0, 0, 0.9);
    }

    .navbar-auth a:hover {
        color: #FFD700;
    }

    .navbar-auth span {
        color: #ffffff;
        text-shadow: 0 1px 8px rgba(0, 0, 0, 0.9);
    }

    /* 로그인 버튼 테두리 - 흰색 배경에서 더 잘 보이게 */
    .navbar-auth .btn-login {
        border-color: rgba(255, 255, 255, 0.8);
    }

    /* ===== 히어로 섹션 (100vh 꽉 채움 + 배경 줌인 애니메이션) ===== */
    .hero-section {
        width: 100%;
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        overflow: hidden;
    }

    /* 배경 이미지를 ::before로 분리 → cover로 항상 꽉 채움 + scale 줌인 */
    .hero-section::before {
        content: '';
        position: absolute;
        inset: 0;
        background-image: url('/img/index.png');
        background-size: cover;
        background-position: 39% 80%;
        animation: heroZoom 10s ease-out forwards;
        z-index: 0;
    }

    @keyframes heroZoom {
        from { transform: scale(1); }
        to   { transform: scale(1.06); }
    }

    /* ===== 메인 텍스트 (SOCIAL BASEBALL NET) - 원근감 표현 ===== */
    .hero-text {
        text-align: center;
        position: relative;
        z-index: 1;
        transform: perspective(700px) rotateX(12deg) translateX(10px);
        transform-origin: center center;
    }

    /* 각 줄 공통 스타일 + fadeInUp 애니메이션 */
    .hero-line {
        font-family: 'Bebas Neue', sans-serif;
        font-size: 100px;
        font-weight: 900;
        line-height: 1.08;
        letter-spacing: 10px;
        opacity: 0;
        animation: fadeInUp 0.7s ease forwards;
    }

    /* 각 줄 애니메이션 딜레이 */
    .line-1 { animation-delay: 0.2s; }
    .line-2 { animation-delay: 0.65s; }
    .line-3 { animation-delay: 1.1s; }

    /* S, B, N - 골드 */
    .letter-gold {
        color: #FFD700;
        text-shadow: 0 2px 18px rgba(0, 0, 0, 0.2);
    }

    /* OCIAL, ASEBALL, ET - 흰색 */
    .letter-rest {
        color: rgba(255, 255, 255, 0.92);
        text-shadow: 0 2px 18px rgba(0, 0, 0, 0.45);
    }

    /* ===== fadeInUp 애니메이션 정의 ===== */
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(18px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* ===== 푸터 여백 제거 (히어로 섹션 바로 아래 붙임) ===== */
    .footer {
        margin-top: 0 !important;
    }

</style>
</head>
<body>
    <div class="top-gradient"></div>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <%-- 히어로 섹션 --%>
    <div class="hero-section">
        <div class="hero-text">
            <div class="hero-line line-1">
                <span class="letter-gold">S</span><span class="letter-rest">OCIAL</span>
            </div>
            <div class="hero-line line-2">
                <span class="letter-gold">B</span><span class="letter-rest">ASEBALL</span>
            </div>
            <div class="hero-line line-3">
                <span class="letter-gold">N</span><span class="letter-rest">ET</span>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

    <%-- 스크롤 시 네비바 반투명 그린 전환 --%>
    <script>
        window.addEventListener('scroll', function () {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 10) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
    </script>
    <script>
			if('${param.memberDeleted}' == 'true') {
			    alert(' 탈퇴 처리가 완료되었습니다.\n SBN을 이용해 주셔서 감사합니다.\n 앞으로의 여정을 항상 응원합니다. ')
			}
</script>
</body>
</html>