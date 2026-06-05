<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 개인정보처리방침</title>
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

    /* ===== 카드 ===== */
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

    .terms-body table {
        width: 100%;
        border-collapse: collapse;
        margin: 10px 0;
        font-size: 13px;
    }

    .terms-body table th,
    .terms-body table td {
        border: 1px solid #c8c4aa !important;
        padding: 8px 12px !important;
        text-align: left;
        font-size: 13px;
        font-weight: normal;
        color: #333;
    }

    .terms-body table th {
        background: rgba(26, 61, 26, 0.07) !important;
        font-weight: 600 !important;
        color: #1a3d1a !important;
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
        margin: 0 4px;
    }

    .btn-back:hover { background: #e6c200; }

    .btn-outline {
        display: inline-block;
        padding: 9px 32px;
        background: transparent;
        color: #1a3d1a;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        font-family: 'S-Core Dream', sans-serif;
        font-size: 14px;
        font-weight: 600;
        letter-spacing: 1px;
        cursor: pointer;
        text-decoration: none;
        transition: background 0.15s, color 0.15s;
        margin: 0 4px;
    }

    .btn-outline:hover {
        background: #1a3d1a;
        color: #FFD700;
        border-color: #1a3d1a;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">

        <div class="section-header">개인정보처리방침</div>

        <div class="main-wrapper">

            <div class="terms-card">

                <div class="terms-meta">
                    SBN(Social Baseball Network)은 이용자의 개인정보를 소중히 여기며, 관련 법령에 따라 아래와 같이 개인정보처리방침을 수립·공개합니다.<br>
                    시행일: 2026년 1월 1일
                </div>

                <!-- 제1조 -->
                <div class="terms-article">
                    <div class="terms-title">제1조 (개인정보의 처리 목적)</div>
                    <div class="terms-body">
                        SBN은 다음의 목적을 위하여 개인정보를 처리합니다. 처리하는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않습니다.
                        <ol>
                            <li>회원 가입 및 본인 확인</li>
                            <li>서비스 제공 (선수·팀·리그 관리, 경기 기록 및 통계 제공)</li>
                            <li>커뮤니티(게시판) 서비스 운영</li>
                            <li>고객 문의 및 민원 처리</li>
                            <li>서비스 개선 및 신규 기능 개발</li>
                            <li>서비스 내 데이터 분석 및 통계 산출</li>
                        </ol>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제2조 -->
                <div class="terms-article">
                    <div class="terms-title">제2조 (처리하는 개인정보 항목)</div>
                    <div class="terms-body">
                        <table>
                            <tr>
                                <th>구분</th>
                                <th>필수 항목</th>
                                <th>선택 항목</th>
                            </tr>
                            <tr>
                                <td>회원 가입</td>
                                <td>아이디, 비밀번호, 이름, 생년월일, 이메일</td>
                                <td>프로필 사진</td>
                            </tr>
                            <tr>
                                <td>서비스 이용</td>
                                <td>경기 기록, 소속 팀 정보</td>
                                <td>선수 포지션, 배번</td>
                            </tr>
                            <tr>
                                <td>자동 수집</td>
                                <td>접속 IP, 서비스 이용 기록</td>
                                <td>-</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제3조 -->
                <div class="terms-article">
                    <div class="terms-title">제3조 (개인정보의 보유 및 이용 기간)</div>
                    <div class="terms-body">
                        <ol>
                            <li>이용자의 개인정보는 원칙적으로 회원 탈퇴 시까지 보유·이용됩니다.</li>
                            <li>관련 법령에 의해 보존할 필요가 있는 경우 해당 기간 동안 보관합니다.
                                <ul>
                                    <li>계약·청약 철회 기록: 5년 (전자상거래 등에서의 소비자 보호에 관한 법률)</li>
                                    <li>접속 로그 기록: 3개월 (통신비밀보호법)</li>
                                </ul>
                            </li>
                            <li>경기 기록 및 통계 데이터는 탈퇴 후 비식별화하여 서비스 내에 유지될 수 있습니다.</li>
                        </ol>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제4조 -->
                <div class="terms-article">
                    <div class="terms-title">제4조 (개인정보의 제3자 제공)</div>
                    <div class="terms-body">
                        <ol>
                            <li>SBN은 원칙적으로 이용자의 개인정보를 외부에 제공하지 않습니다.</li>
                            <li>다음의 경우에는 예외로 합니다.
                                <ul>
                                    <li>이용자가 사전에 동의한 경우</li>
                                    <li>법령의 규정에 의거하거나, 수사 기관의 적법한 요청이 있는 경우</li>
                                </ul>
                            </li>
                        </ol>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제5조 -->
                <div class="terms-article">
                    <div class="terms-title">제5조 (정보주체의 권리·의무 및 행사 방법)</div>
                    <div class="terms-body">
                        이용자는 언제든지 다음의 권리를 행사할 수 있습니다.
                        <ol>
                            <li>개인정보 열람 요청</li>
                            <li>개인정보 정정·삭제 요청</li>
                            <li>개인정보 처리 정지 요청</li>
                        </ol>
                        위 권리 행사는 마이페이지에서 직접 처리하거나, 관리자에게 요청할 수 있습니다.
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제6조 -->
                <div class="terms-article">
                    <div class="terms-title">제6조 (개인정보의 파기)</div>
                    <div class="terms-body">
                        <ol>
                            <li>SBN은 개인정보 보유 기간이 경과하거나 처리 목적이 달성된 경우 해당 정보를 지체 없이 파기합니다.</li>
                            <li>전자적 파일 형태의 경우 복구 불가능한 방법으로 영구 삭제합니다.</li>
                            <li>종이에 출력된 개인정보는 분쇄하거나 소각하여 파기합니다.</li>
                        </ol>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제7조 -->
                <div class="terms-article">
                    <div class="terms-title">제7조 (개인정보 안전성 확보 조치)</div>
                    <div class="terms-body">
                        SBN은 개인정보 보호를 위해 다음의 조치를 취하고 있습니다.
                        <ul>
                            <li>개인정보에 대한 접근 권한 관리 및 최소화</li>
                            <li>비밀번호 암호화 저장</li>
                            <li>개인정보 접근 기록 보관 및 위·변조 방지</li>
                        </ul>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제8조 -->
                <div class="terms-article">
                    <div class="terms-title">제8조 (공개 정보 및 선택권)</div>
                    <div class="terms-body">
                        <ol>
                            <li>선수명, 팀명, 배번, 경기 기록 등은 리그 참여자에게 공개될 수 있습니다.</li>
                            <li>이용자는 마이페이지에서 프로필 공개 여부 등 일부 정보의 공개 범위를 설정할 수 있습니다.</li>
                        </ol>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제9조 -->
                <div class="terms-article">
                    <div class="terms-title">제9조 (개인정보 보호 책임자)</div>
                    <div class="terms-body">
                        SBN은 개인정보 처리에 관한 업무를 총괄하는 개인정보 보호 책임자를 지정하고 있습니다.
                        <ul>
                            <li><strong>책임자:</strong> SBN 개발팀 (427호 1조)</li>
                            <li><strong>문의:</strong> 관리자 계정을 통해 접수</li>
                        </ul>
                        개인정보 관련 문의, 불만 처리 등은 관리자에게 요청하실 수 있습니다.
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 제10조 -->
                <div class="terms-article">
                    <div class="terms-title">제10조 (개인정보처리방침 변경)</div>
                    <div class="terms-body">
                        <ol>
                            <li>본 개인정보처리방침은 법령 및 정책의 변경에 따라 수정될 수 있습니다.</li>
                            <li>내용 추가·삭제 및 수정이 있을 경우 시행일 7일 전에 서비스 화면을 통해 공지합니다.</li>
                        </ol>
                    </div>
                </div>

                <hr class="terms-divider">

                <!-- 부칙 -->
                <div class="terms-addendum">
                    <strong>부칙</strong><br>
                    본 개인정보처리방침은 2026년 1월 1일부터 시행됩니다.
                </div>

            </div>

            <!-- 하단 버튼 -->
            <div class="terms-card btn-area">
                <a href="/terms" class="btn-outline">이용약관</a>
                <a href="/" class="btn-back">홈으로</a>
            </div>

        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

</body>
</html>
