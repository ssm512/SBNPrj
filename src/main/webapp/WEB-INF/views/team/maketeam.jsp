<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 구단 만들기</title>
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

    /* 콘텐츠 영역이 남은 공간을 모두 차지해 푸터를 하단으로 밀어냄 */
    .page-wrapper {
        flex: 1;
        padding: 104px 0 32px;
    }

    /* common.css의 margin-top: 50px 오버라이드 */
    .footer { margin-top: 0 !important; }

    /* ===== 폼 카드 (베이지 배경 + 둥근 모서리) ===== */
    .form-card {
        background: #F5F5DC;
        border-radius: 10px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 36px 40px;
        margin: 0 auto;
        margin-bottom: 32px;
        max-width: 700px;
    }

    /* ===== 폼 필드 그룹 ===== */
    .form-group {
        display: flex;
        flex-direction: column;
        gap: 6px;
        margin-bottom: 18px;
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

    /* 입력창 - 베이지 카드 위에서 흰 배경으로 구분 */
    .form-input,
    .form-textarea {
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

    .form-input:focus,
    .form-textarea:focus {
        border-color: #1a3d1a;
    }

    /* 팀 소개글 textarea */
    .form-textarea {
        height: 110px;
        resize: none;
    }

    /* 파일 업로드 입력창 */
    .form-file {
        font-size: 13px;
        color: #555;
    }

    /* ===== 구분선 ===== */
    .form-divider {
        border: none;
        border-top: 1px solid #a8a48a;
        margin: 8px 0 20px;
    }

    /* ===== 생성하기 버튼 (골드 배경 + 그린 텍스트) ===== */
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
    }

    .btn-submit:hover {
        background-color: #e6c200;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">
        <div class="main-wrapper">

            <%-- 폼 카드 --%>
            <form action="/Team/MakeTeam" method="post" enctype="multipart/form-data">
                <div class="form-card">

                    <div class="form-group">
                        <label class="form-label">구단 이름 <span class="required">*</span></label>
                        <input class="form-input" type="text" name="team_name" placeholder="구단 이름을 입력하세요" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">연고지 <span class="required">*</span></label>
                        <input class="form-input" type="text" name="team_location" placeholder="연고지를 입력하세요" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">구단 소개</label>
                        <textarea class="form-textarea" name="team_content" placeholder="구단 소개글을 입력하세요"></textarea>
                    </div>

                    <hr class="form-divider">

                    <div class="form-group">
                        <label class="form-label">구단 로고</label>
                        <input class="form-file" type="file" name="team_logo" accept="image/*">
                    </div>

                    <%-- 생성하기 버튼 --%>
                    <button type="submit" class="btn-submit">구단 만들기</button>

                </div>
            </form>

        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

    <%-- 팀 이름 중복 알림 --%>
    <script>
        <c:if test="${param.alert == 'duplicate_name'}">alert('이미 사용 중인 구단 이름입니다.');</c:if>
    </script>
</body>
</html>