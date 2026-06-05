<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 구단 만들기</title>
<link rel="shortcut icon" href="/img/favicon2.png" type="image/png" />
<link href="/css/common.css" rel="stylesheet" />
<link href="https://webfontworld.github.io/sunn/SCDream.css" rel="stylesheet" />
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
        background: rgba(249, 249, 234, 0.93);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 36px 40px;
        margin: 0 auto;
        margin-bottom: 32px;
        max-width: 500px;
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
        font-family: 'S-Core Dream', sans-serif;
        font-size: 16px;
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
        border-radius: 3px;
        font-size: 17px;
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
        font-size: 16px;
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
        border-radius: 3px;
        font-size: 18px;
        font-family: 'S-Core Dream', sans-serif;
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
      
      const formEl         = document.querySelector('form');
      const teamNameEl     = document.querySelector('[name="team_name"]');
      const teamLocationEl = document.querySelector('[name="team_location"]');
      const teamContentEl  = document.querySelector('[name="team_content"]');
      
      // 작성한 내용의 양이 DB 설정값을 초과했을때 500 에러 방지
      function getByteSize(str) {
    	  let byte = 0;
    	  for (let i = 0; i < str.length; i++) {
    		byte += str.charCodeAt(i) > 127 ? 3 : 1;
    	}
    	  return byte;
      }
      
      formEl.addEventListener('submit', function( e ) {
    	  
	      // 팀이름이 값을 초과했을 때
	   	  if( getByteSize(teamNameEl.value) > 100 ) {
	   		  alert('팀이름이 너무 깁니다. (현재' + getByteSize(teamNameEl.value) + 'byte / 최대 100byte)');
	   		  teamNameEl.focus();
	   		  e.preventDefault()  // 이벤트 취소
	   		  e.stopPropagation() // 이벤트 버블링 방지
	   		  return;
	   	  }
	      
	      // 팀 연고지가 값을 초과했을 때
	   	  if( getByteSize(teamLocationEl.value) > 20 ) {
	   		  alert('연고지가 너무 깁니다. (현재' + getByteSize(teamLocationEl.value) + 'byte / 최대 20byte)');
	   		  teamLocationEl.focus();
	   		  e.preventDefault()  // 이벤트 취소
	   		  e.stopPropagation() // 이벤트 버블링 방지
	   		  return;
	   	  }
	      
	      // 팀 소개가 값을 초과했을 때
	   	  if( getByteSize(teamContentEl.value) > 2000 ) {
	   		  alert('소개가 너무 깁니다. (현재' + getByteSize(teamContentEl.value) + 'byte / 최대 2000byte)');
	   		  teamContentEl.focus();
	   		  e.preventDefault()  // 이벤트 취소
	   		  e.stopPropagation() // 이벤트 버블링 방지
	   		  return;
	   	  }
	      
      })
      
    </script>
</body>
</html>