<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 이용약관</title>
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
        max-width: 860px;
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
        max-width: 860px;
        margin: 0 auto;
    }

    /* ===== 약관 카드 ===== */
    .terms-card {
        background: rgba(249, 249, 234, 0.93);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 36px 44px;
        margin-bottom: 12px;
    }

    /* ===== 시행일 안내 ===== */
    .terms-meta {
        font-family: 'S-Core Dream', sans-serif;
        font-size: 13px;
        color: #666;
        margin-bottom: 28px;
        padding-bottom: 16px;
        border-bottom: 1px solid #c8c4aa;
    }

    /* ===== 조항 ===== */
    .terms-article {
        margin-bottom: 28px;
    }

    .terms-article:last-child {
        margin-bottom: 0;
    }

    .terms-title {
        font-family: 'S-Core Dream', sans-serif;
        font-size: 15px;
        font-weight: 700;
        color: #1a3d1a;
        margin-bottom: 10px;
        padding-left: 10px;
        border-left: 3px solid #FFD700;
    }

    .terms-body {
        font-family: 'S-Core Dream', sans-serif;
        font-size: 13px;
        color: #333;
        line-height: 2;
        padding-left: 13px;
    }

    .terms-body ol {
        padding-left: 18px;
        list-style: decimal;
        margin: 4px 0;
    }

    .terms-body ul {
        padding-left: 18px;
        list-style: disc;
        margin: 4px 0;
    }

    .terms-body li {
        margin-bottom: 4px;
    }

    /* ===== 구분선 ===== */
    .terms-divider {
        border: none;
        border-top: 1px solid #c8c4aa;
        margin: 24px 0;
    }

    /* ===== 부칙 ===== */
    .terms-addendum {
        font-family: 'S-Core Dream', sans-serif;
        font-size: 13px;
        color: #555;
        background: rgba(26, 61, 26, 0.05);
        border-radius: 3px;
        padding: 14px 18px;
        margin-top: 8px;
    }

    /* ===== 하단 버튼 ===== */
    .btn-area {
        text-align: center;
    }

    .btn-back {
        display: inline-block;
        padding: 9px 32px;
        background: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 3px;
        font-family: 'S-Core Dream', sans-serif;
        font-size: 14px;
        font-weight: 700;
        letter-spacing: 1px;
        cursor: pointer;
        text-decoration: none;
        transition: background 0.15s;
    }

    .btn-back:hover {
        background: #e6c200;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">

        <div class="section-header">이용약관</div>

        <div class="main-wrapper">

            <div class="terms-card">

                <div class="terms-meta">
                    본 약관은 SBN(Social Baseball Network) 서비스 이용에 관한 기본적인 사항을 규정합니다.<br>
                    시행일: 2026년 1월 1일
                </div>

                <!-- 제1조 -->
                <div class="terms-article">
                    <div class="terms-title">제1조 (목적)</div>
                    <div class="terms-body">
                        본 약관은 Social Baseball Net(이하 "SBN")이 제공하는 사회인 야구 네트워크 서비스의 이용과 관련하여
                        서비스와 이용자 간의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제2조 -->
                <div class="terms-article">
                    <div class="terms-title">제2조 (정의)</div>
                    <div class="terms-body">
                        본 약관에서 사용하는 용어의 정의는 다음과 같습니다.
                        <ol>
                            <li><strong>"서비스"</strong>란 SBN이 제공하는 선수 관리, 팀 관리, 리그 관리, 경기 기록, 커뮤니티(게시판) 등 일체의 기능을 의미합니다.</li>
                            <li><strong>"이용자"</strong>란 본 약관에 동의하고 서비스에 가입하여 이용하는 회원을 말합니다.</li>
                            <li><strong>"관리자"</strong>란 서비스 운영 전반을 관리하며 리그·경기 정보를 등록·수정하는 권한을 가진 이용자를 말합니다.</li>
                            <li><strong>"게시물"</strong>이란 이용자가 서비스 내 게시판에 등록한 텍스트, 이미지 등 일체의 콘텐츠를 말합니다.</li>
                        </ol>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제3조 -->
                <div class="terms-article">
                    <div class="terms-title">제3조 (약관의 효력 및 변경)</div>
                    <div class="terms-body">
                        <ol>
                            <li>본 약관은 서비스 화면에 게시함으로써 효력이 발생합니다.</li>
                            <li>서비스는 필요한 경우 약관을 변경할 수 있으며, 변경 시 적용일 7일 전에 공지합니다.</li>
                            <li>이용자가 변경된 약관에 동의하지 않을 경우 서비스 이용을 중단하고 탈퇴할 수 있습니다.</li>
                            <li>약관 변경 공지 후 계속하여 서비스를 이용하는 경우 변경된 약관에 동의한 것으로 간주합니다.</li>
                        </ol>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제4조 -->
                <div class="terms-article">
                    <div class="terms-title">제4조 (서비스 이용)</div>
                    <div class="terms-body">
                        <ol>
                            <li>서비스는 원칙적으로 연중무휴 24시간 제공됩니다.</li>
                            <li>시스템 점검, 서버 유지보수 등의 사유로 서비스가 일시 중단될 수 있습니다.</li>
                            <li>회원 가입은 본 약관에 동의하고 소정의 가입 절차를 완료함으로써 이루어집니다.</li>
                            <li>미성년자의 경우 보호자의 동의가 필요할 수 있습니다.</li>
                        </ol>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제5조 -->
                <div class="terms-article">
                    <div class="terms-title">제5조 (이용자 의무)</div>
                    <div class="terms-body">
                        이용자는 다음 각 호의 행위를 하여서는 안 됩니다.
                        <ol>
                            <li>타인의 아이디, 비밀번호 등 개인정보를 도용하는 행위</li>
                            <li>허위 정보를 등록하거나 타인의 명예를 훼손하는 행위</li>
                            <li>서비스 운영을 방해하거나 시스템에 부하를 주는 행위</li>
                            <li>음란물, 혐오 표현, 불법 콘텐츠를 게시하는 행위</li>
                            <li>경기 기록 등 공식 데이터를 고의로 조작하는 행위</li>
                            <li>관련 법령 및 본 약관에 위반하는 기타 행위</li>
                        </ol>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제6조 -->
                <div class="terms-article">
                    <div class="terms-title">제6조 (게시물 및 콘텐츠)</div>
                    <div class="terms-body">
                        <ol>
                            <li>이용자가 서비스 내에 등록한 게시물에 대한 책임은 해당 이용자에게 있습니다.</li>
                            <li>서비스는 법령 위반, 타인의 권리 침해 등에 해당하는 게시물을 사전 통보 없이 삭제할 수 있습니다.</li>
                            <li>이용자가 등록한 게시물은 서비스 운영 및 개선 목적으로 활용될 수 있습니다.</li>
                        </ol>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제7조 -->
                <div class="terms-article">
                    <div class="terms-title">제7조 (경기 기록 및 데이터)</div>
                    <div class="terms-body">
                        <ol>
                            <li>리그 및 경기 데이터는 관리자 또는 팀 담당자가 직접 입력하며, 입력 정확성에 대한 책임은 입력 주체에게 있습니다.</li>
                            <li>서비스 내 선수 통계, 경기 기록 등은 입력된 데이터를 기반으로 자동 산출되며, 실제 기록과 차이가 있을 수 있습니다.</li>
                            <li>등록된 경기 기록은 해당 리그 참여자들에게 공개될 수 있습니다.</li>
                        </ol>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제8조 -->
                <div class="terms-article">
                    <div class="terms-title">제8조 (서비스 이용 제한)</div>
                    <div class="terms-body">
                        서비스는 다음에 해당하는 경우 이용자의 서비스 이용을 제한하거나 계정을 정지·삭제할 수 있습니다.
                        <ol>
                            <li>본 약관의 의무사항을 위반한 경우</li>
                            <li>서비스의 정상적인 운영을 방해한 경우</li>
                            <li>허위 또는 타인의 정보로 가입한 경우</li>
                            <li>기타 관련 법령에 위반되는 행위를 한 경우</li>
                        </ol>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제9조 -->
                <div class="terms-article">
                    <div class="terms-title">제9조 (개인정보 보호)</div>
                    <div class="terms-body">
                        <ol>
                            <li>서비스는 이용자의 개인정보를 중요시하며, 관련 법령에 따라 이를 보호합니다.</li>
                            <li>개인정보의 수집·이용·보관·파기에 관한 사항은 별도의 개인정보처리방침에서 정합니다.</li>
                            <li>이용자는 언제든지 자신의 개인정보를 조회하고 수정을 요청할 수 있습니다.</li>
                        </ol>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제10조 -->
                <div class="terms-article">
                    <div class="terms-title">제10조 (면책사항)</div>
                    <div class="terms-body">
                        서비스는 다음의 경우 책임을 지지 않습니다.
                        <ol>
                            <li>천재지변, 서버 장애 등 불가항력적 사유로 인한 서비스 중단</li>
                            <li>이용자의 귀책사유로 인한 서비스 이용 장애</li>
                            <li>이용자가 직접 입력한 경기 기록 데이터의 오류</li>
                            <li>이용자 간의 분쟁으로 인해 발생한 손해</li>
                            <li>서비스를 통해 연결된 외부 링크의 콘텐츠</li>
                        </ol>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제11조 -->
                <div class="terms-article">
                    <div class="terms-title">제11조 (분쟁 해결)</div>
                    <div class="terms-body">
                        <ol>
                            <li>서비스와 이용자 간 분쟁이 발생한 경우, 양 당사자는 원만한 해결을 위해 성실히 협의합니다.</li>
                            <li>협의가 이루어지지 않을 경우 관련 법령에 따라 처리합니다.</li>
                        </ol>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 부칙 -->
                <div class="terms-addendum">
                    <strong>부칙</strong><br>
                    본 약관은 2026년 1월 1일부터 시행됩니다.
                </div>

            </div>

            <!-- 하단 버튼 -->
            <div class="terms-card btn-area">
                <a href="/" class="btn-back">홈으로</a>
            </div>

        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

</body>
</html>
