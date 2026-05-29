<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 팀 생성</title>
<link href="/css/common.css" rel="stylesheet" />
<style>

    /* ===== 폼 컨테이너 ===== */
    .form-box {
        width: 280px;
        margin: 40px auto;
        padding: 30px;
        background-color: #F5F5DC;
        border: 1px solid #ccc;
        display: flex;
        flex-direction: column;
        gap: 12px;
    }

    .form-box input,
    .form-box textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        font-size: 14px;
        box-sizing: border-box;
    }

    .form-box textarea {
        height: 100px;
        resize: none;
    }

    /* ===== 생성하기 버튼 ===== */
    .btn-create {
        width: 100%;
        padding: 12px;
        background-color: #FFD700;
        border: none;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
    }

    .btn-create:hover {
        background-color: #D9D9D9;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="main-wrapper">
        <form action="/Team/MakeTeam" method="post" enctype="multipart/form-data">
            <div class="form-box">

                <input type="text"  name="team_name"     placeholder="팀 이름"     required>
                <input type="text"  name="team_location" placeholder="연고지"      required>
                <textarea           name="team_content"  placeholder="팀 소개글"></textarea>
                <input type="file"  name="team_logo"     placeholder="이미지 업로드 (팀로고)">

                <button type="submit" class="btn-create">생성하기</button>

            </div>
        </form>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>