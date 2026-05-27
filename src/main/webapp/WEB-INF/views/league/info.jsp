<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>League Info</title>

<link rel="shortcut icon" href="/img/favicon.png" type="image/x-icon" />
<!-- <link href="/css/common.css" rel="stylesheet" /> -->

<style>
  /* 기본 스타일 초기화 및 레이아웃 설정 */
  body {
    font-family: 'Malgun Gothic', sans-serif;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }
  
  /* 메인 콘텐츠 영역 (Flexbox 배치) */
  .main-wrapper {
    display: flex;
    width:90%;
    margin: 20px auto;
    padding: 0 20px;
    gap: 20px;
  }

  /* --- 좌측 콘텐츠 스타일 --- */
  .left-container {
    display: flex;
    gap: 15px;
    width: 40%;
  }

  .left-section-1, .left-section-2 {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 15px;
  }
  .left-section-2 {
    border:2px solid #1a5c1a;
  }

  /* 카드/박스 공통 스타일 */
  .info-box {
    background-color: #f6f8e7;
    border: 2px solid #1a5c1a;
    border-radius: 10px;
    padding: 15px;
    text-align: center;
    font-weight: bold;
    color: #333;
  }

  /* 소개 영역 길게 늘리기 */
  .intro-box {
    flex-grow: 1;
    min-height: 250px;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  /* 팀 리스트 내부 항목 스타일 */
  .team-item {
    background-color: #ffffff;
    border: 2px solid #1a5c1a;
    border-radius: 20px;
    padding: 10px;
    margin-bottom: 15px;
    text-align: center;
    font-weight: bold;
  }
  /* 마우스 호버 색상 예시 */
  .team-item.hover-effect:hover {
    background-color: #d1e7dd;
    cursor: pointer;
  }

  /* --- 우측 콘텐츠 스타일 (테이블) --- */
  .right-container {
    width: 60%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }

  .league-table {
    width: 100%;
    border-collapse: collapse;
    border-radius: 8px;
    overflow: hidden;
  }

  .league-table th {
    background-color: #f6f8e7;
    color: #333;
    font-weight: bold;
    padding: 12px;
    border: 1px solid #ddd;
  }

  .league-table td {
    padding: 12px;
    text-align: center;
    border: 1px solid #ddd;
    color: #444;
  }

  /* 테이블 빈 행 채우기용 (와이어프레임 느낌 재현) */
  .league-table tr:not(:first-child) {
    height: 45px;
  }

  /* --- 버튼 스타일 --- */
  .btn-container {
    margin-top: 15px;
    display: flex;
  }
  .justify-start { justify-content: flex-start; }
  .justify-end { justify-content: flex-end; }

  .green-btn {
    background-color: #ffffff;
    color: #1a5c1a;
    border: 2px solid #1a5c1a;
    border-radius: 20px;
    padding: 10px 20px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s;
  }

  .green-btn:hover {
    background-color: #1a5c1a;
    color: #ffffff;
  }
  
  .left-table {
    text-align:center;
  }
  .left-td {
    border: 1px solid #1a5c1a;
  }
</style>
</head>
<body>

  <%@include file="/WEB-INF/include/headermenu.jsp" %>
  
  <div class="main-wrapper">
    <div class="left-container">
      
      <div class="left-section-1">
        <div class="info-box">골든리그</div>
        <div class="info-box">부산</div>
        <div class="info-box intro-box">리그 소개</div>
        <div class="btn-container justify-start">
          <button type="button" class="green-btn">리그 가입 신청</button>
        </div>
      </div>
      
      <div class="left-section-2">
        <table class="left-table">
          <tr>
            <td class="left-td">팀 이름</td>
          </tr>
        </table>
      </div>
      
    </div>
    
    <div class="right-container">
      <table class="league-table">
          <tr>
            <td>리그</td>
            <td>날짜</td>
            <td>시간</td>
            <td>장소</td>
            <td>Home</td> 
            <td>Away</td>
            <td>비고</td>
          </tr>

          <tr>
            <td>
            <a href="/Game/GameInfo">
              골든리그
            </a>
            </td>
            <td>2026.06.18</td>
            <td>07:30</td>
            <td>모란야구장</td>
            <td>야방궁</td>
            <td>유니 자이언츠</td>
            <td>-</td>
          </tr>
      </table>
      
      <div class="btn-container justify-end">
        <button type="button" class="green-btn">
        <a href="/Game/AddGameForm">
          경기 일정 추가
        </a>
        </button>
      </div>
    </div>
  </div>
  
  <%@include file="/WEB-INF/include/footer.jsp" %> 
  
</body>
</html>