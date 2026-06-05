<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 회원가입</title>
<link rel="shortcut icon" href="/img/favicon2.png" type="image/png" />
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

    /* 블러 배경 - position: fixed 로 스크롤해도 항상 전체 화면 덮음 */
    /* 폼이 길어 page-wrapper가 뷰포트보다 커지는 경우에도 배경 잘림 방지 */
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

    /* 콘텐츠 영역 */
    .page-wrapper {
        flex: 1;
        padding: 104px 0 32px;
    }

    /* main-wrapper가 블러 배경 위에 뜨도록 */
    .main-wrapper {
        position: relative;
        z-index: 0;
    }

    /* common.css의 margin-top: 50px 오버라이드 */
    .footer { margin-top: 0 !important; }

    /* ===== 폼 카드 (반투명 베이지 + 둥근 모서리) ===== */
    .form-card {
        background: rgba(249, 249, 234, 0.93);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 36px 44px;
        margin: 0 auto;
        margin-bottom: 32px;
        max-width: 520px;
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
        margin-bottom: 14px;
    }

    /* 라벨 - 그린 텍스트 */
    .form-label {
        font-family: 'Oswald', sans-serif;
        font-size: 13px;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 1px;
    }

    /* 필수 항목 표시 */
    .form-label .required {
        color: #c0392b;
        margin-left: 3px;
    }

    /* 입력창 */
    .form-input {
        width: 100%;
        padding: 10px 14px;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
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

    /* ===== 중복확인 버튼이 있는 입력 행 ===== */
    .input-with-btn {
        display: flex;
        gap: 8px;
    }

    .input-with-btn .form-input {
        flex: 1;
    }

    /* 중복확인 버튼 - 그린 테두리 */
    .btn-dup {
        padding: 0 14px;
        background: none;
        border: 1px solid #1a3d1a;
        border-radius: 3px;
        font-family: 'Oswald', sans-serif;
        font-size: 12px;
        font-weight: 600;
        color: #1a3d1a;
        letter-spacing: 0.5px;
        cursor: pointer;
        white-space: nowrap;
        transition: all 0.2s;
    }

    .btn-dup:hover {
        background-color: #1a3d1a;
        color: #FFD700;
    }

    /* ===== 라디오 버튼 그룹 ===== */
    .radio-group {
        display: flex;
        flex-wrap: wrap;
        gap: 10px 18px;
        padding: 6px 0 2px;
    }

    .radio-group label {
        display: flex;
        align-items: center;
        gap: 5px;
        font-size: 13px;
        color: #333;
        cursor: pointer;
    }

    .radio-group input[type="radio"] {
        accent-color: #1a3d1a;
        width: 14px;
        height: 14px;
        cursor: pointer;
    }

    /* ===== 구분선 ===== */
    .form-divider {
        border: none;
        border-top: 1px solid #a8a48a;
        margin: 8px 0 20px;
    }

    /* ===== 가입하기 버튼 (골드 배경 + 그린 텍스트) ===== */
    .btn-submit {
        width: 100%;
        padding: 12px;
        background-color: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 3px;
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

    /* ===== 로그인 링크 ===== */
    .login-link {
        text-align: center;
        font-size: 13px;
        color: #555;
    }

    .login-link a {
        color: #1a3d1a;
        font-weight: 700;
        text-decoration: none;
        transition: color 0.2s;
    }

    .login-link a:hover {
        color: #2a5a2a;
        text-decoration: underline;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">
        <div class="main-wrapper">

            <%-- 회원가입 폼 카드 --%>
            <form action="/Member/Signin" method="post">
                <div class="form-card">

                    <div class="form-title">SIGN UP</div>

                    <%-- 아이디 --%>
                    <div class="form-group">
                        <label class="form-label">아이디 <span class="required">*</span></label>
                        <div class="input-with-btn">
                            <input class="form-input" type="text" name="member_id" placeholder="영문, 숫자만 입력 가능" />
                            <button type="button" class="btn-dup" id="dupCheck">중복확인</button>
                        </div>
                    </div>

                    <%-- 비밀번호 --%>
                    <div class="form-group">
                        <label class="form-label">비밀번호 <span class="required">*</span></label>
                        <input class="form-input" type="password" id="password" name="password" placeholder="4자리 이상 입력" />
                    </div>

                    <%-- 비밀번호 확인 --%>
                    <div class="form-group">
                        <label class="form-label">비밀번호 확인 <span class="required">*</span></label>
                        <input class="form-input" type="password" id="password2" placeholder="비밀번호를 다시 입력하세요" />
                    </div>

                    <%-- 이름 --%>
                    <div class="form-group">
                        <label class="form-label">이름 <span class="required">*</span></label>
                        <input class="form-input" type="text" name="member_name" placeholder="이름을 입력하세요" required />
                    </div>

                    <%-- 생년월일 --%>
                    <div class="form-group">
                        <label class="form-label">생년월일 <span class="required">*</span></label>
                        <input class="form-input" type="date" name="birth" required />
                    </div>

                    <%-- 연락처 --%>
                    <div class="form-group">
                        <label class="form-label">연락처</label>
                        <div class="input-with-btn">
                            <input class="form-input" type="text" name="phone_num" placeholder="01012345678" />
                            <button type="button" class="btn-dup" id="phoneDupCheck">중복확인</button>
                        </div>
                    </div>

                    <%-- 주소 --%>
                    <div class="form-group">
                        <label class="form-label">주소</label>
                        <input class="form-input" type="text" name="address" placeholder="부산 해운대구 등" />
                    </div>

                    <%-- 이메일 --%>
                    <div class="form-group">
                        <label class="form-label">이메일</label>
                        <div class="input-with-btn">
                            <input class="form-input" type="email" name="email" placeholder="example@email.com" />
                            <button type="button" class="btn-dup" id="emailDupCheck">중복확인</button>
                        </div>
                    </div>

                    <%-- 선출 여부 --%>
                    <div class="form-group">
                        <label class="form-label">선출 여부</label>
                        <div class="radio-group">
                            <label><input type="radio" name="elite" id="normal" value="비선출" checked /> 비선출</label>
                            <label><input type="radio" name="elite" id="middle_school" value="중출" /> 중출</label>
                            <label><input type="radio" name="elite" id="high_school" value="고출" /> 고출</label>
                            <label><input type="radio" name="elite" id="pro" value="프로" /> 프로</label>
                        </div>
                    </div>

                    <%-- 투타 구분 --%>
                    <div class="form-group">
                        <label class="form-label">투타 구분</label>
                        <div class="radio-group">
                            <label><input type="radio" name="use_hand" id="right_right" value="우투우타" checked /> 우투우타</label>
                            <label><input type="radio" name="use_hand" id="right_left"  value="우투좌타" /> 우투좌타</label>
                            <label><input type="radio" name="use_hand" id="left_left"   value="좌투좌타" /> 좌투좌타</label>
                            <label><input type="radio" name="use_hand" id="left_right"  value="좌투우타" /> 좌투우타</label>
                            <label><input type="radio" name="use_hand" id="switch"      value="스위치"   /> 스위치</label>
                        </div>
                    </div>

                    <%-- 선호 포지션 --%>
                    <div class="form-group">
                        <label class="form-label">선호 포지션</label>
                        <input class="form-input" type="text" name="hope_position" placeholder="선호 포지션을 입력하세요" />
                    </div>

                    <hr class="form-divider">

                    <%-- 가입하기 버튼 --%>
                    <button type="submit" class="btn-submit">가입하기</button>

                    <div class="login-link">
                        이미 회원이신가요? <a href="/Member/LoginForm">로그인</a>
                    </div>

                </div>
            </form>

        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

    <%-- 입력 여부 체크 및 중복확인 Ajax --%>
    <script>
        /* 아이디 중복 체크 여부 전역변수 */
        var idDupChecked    = false;
        var phoneDupChecked = true;
        var emailDupChecked = true;

        /* 필요한 요소 미리 찾기 */
        const formEl        = document.querySelector('form');
        const memberIdEl    = document.querySelector('input[name="member_id"]');
        const passwordEl    = document.querySelector('#password');
        const password2El   = document.querySelector('#password2');
        const membernameEl  = document.querySelector('[name="member_name"]');
        const phoneEl       = document.querySelector('[name="phone_num"]');
        const emailEl       = document.querySelector('[name="email"]');
        const phoneDupBtnEl = document.querySelector('#phoneDupCheck');
        const emailDupBtnEl = document.querySelector('#emailDupCheck');

        // 아이디에 영어+숫자 외 문자 입력 시 제거
        memberIdEl.addEventListener('input', function () {
            this.value = this.value.replace(/[^a-zA-Z0-9]/g, '');
        });

        // 폼 제출 유효성 검사
        formEl.addEventListener('submit', function (e) {

            if (memberIdEl.value.trim() == '') {
                alert('아이디를 입력하세요');
                e.preventDefault(); e.stopPropagation();
                memberIdEl.focus(); return;
            }

            if (!idDupChecked) {
                alert('아이디 중복확인 필요');
                e.preventDefault(); e.stopPropagation(); return;
            }

            if (!phoneDupChecked) {
                alert('연락처 중복확인이 필요합니다.');
                e.preventDefault(); e.stopPropagation(); return;
            }

            if (!emailDupChecked) {
                alert('이메일 중복확인이 필요합니다.');
                e.preventDefault(); e.stopPropagation(); return;
            }

            if (passwordEl.value.trim() == '') {
                alert('암호를 입력하세요');
                passwordEl.focus();
                e.preventDefault(); e.stopPropagation(); return;
            }

            if (passwordEl.value.length < 4) {
                alert('비밀번호는 4자리 이상 입력하세요');
                e.preventDefault(); passwordEl.focus(); return;
            }

            if (password2El.value.trim() == '') {
                alert('비밀번호 확인을 입력하세요');
                password2El.focus();
                e.preventDefault(); e.stopPropagation(); return;
            }

            if (passwordEl.value != password2El.value) {
                alert('비밀번호가 일치하지 않습니다');
                password2El.focus();
                e.preventDefault(); e.stopPropagation(); return;
            }

            if (phoneEl.value.trim() != '') {
                const phoneRegex = /^01[016789]\d{7,8}$/;
                if (!phoneRegex.test(phoneEl.value.trim())) {
                    alert('전화번호 형식이 올바르지 않습니다. (예: 01012345678)');
                    e.preventDefault(); phoneEl.focus(); return;
                }
            }
        });

        // 아이디 중복확인 (Ajax)
        const btnDupEl = document.querySelector('#dupCheck');
        btnDupEl.addEventListener('click', function () {
            if (memberIdEl.value.trim() == '') {
                alert('아이디를 입력하세요');
                memberIdEl.focus(); return;
            }
            fetch('/Member/IdDupCheck/' + memberIdEl.value)
                .then(response => response.json())
                .then(json => {
                    if (json.member && json.member.member_id != null) {
                        alert('사용불가능'); idDupChecked = false;
                    } else {
                        alert('사용가능'); idDupChecked = true;
                    }
                })
                .catch(error => console.dir(error));
        });

        // 연락처 중복확인 (Ajax)
        phoneDupBtnEl.addEventListener('click', function () {
            if (phoneEl.value.trim() == '') {
                alert('연락처를 입력하세요');
                phoneEl.focus(); return;
            }
            const phoneRegex = /^01[016789]\d{7,8}$/;
            if (!phoneRegex.test(phoneEl.value.trim())) {
                alert('전화번호 형식이 올바르지 않습니다. (예: 01012345678)');
                phoneEl.focus(); return;
            }
            fetch('/Member/PhoneDupCheck/' + phoneEl.value)
                .then(response => response.json())
                .then(json => {
                    if (json.member && json.member.phone_num != null) {
                        alert('사용불가능'); phoneEl.focus(); phoneDupChecked = false;
                    } else {
                        alert('사용가능'); phoneDupChecked = true;
                    }
                })
                .catch(error => console.dir(error));
        });

        // 이메일 중복확인 (Ajax)
        emailDupBtnEl.addEventListener('click', function () {
            if (emailEl.value.trim() == '') {
                alert('이메일을 입력하세요');
                emailEl.focus(); return;
            }
            fetch('/Member/EmailDupCheck/' + emailEl.value)
                .then(response => response.json())
                .then(json => {
                    if (json.member && json.member.email != null) {
                        alert('사용불가능'); emailEl.focus(); emailDupChecked = false;
                    } else {
                        alert('사용가능'); emailDupChecked = true;
                    }
                })
                .catch(error => console.dir(error));
        });

        // 값 변경 시 중복확인 초기화
        memberIdEl.addEventListener('change', function () { idDupChecked = false; });

        phoneEl.addEventListener('change', function () {
            phoneDupChecked = this.value.trim() == '' ? true : false;
        });

        emailEl.addEventListener('change', function () {
            emailDupChecked = this.value.trim() == '' ? true : false;
        });

    </script>

</body>
</html>
