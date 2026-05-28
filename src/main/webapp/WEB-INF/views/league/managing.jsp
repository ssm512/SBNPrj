<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>League List</title>

<link rel="shortcut icon" href="/img/favicon.png" type="image/x-icon" />
<link href="/css/common.css" rel="stylesheet" />

<style>
  /* 기본 레이아웃 구성 */
  .main-wrapper {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 20px;
    box-sizing: border-box;
    font-family: 'Malgun Gothic', sans-serif;
  }

  /* 공통 버튼 및 소제목 스타일 정의 */
  .section-title {
    display: inline-block;
    border: 2px solid #006400; /* 진한 초록 테두리 */
    border-radius: 20px;
    padding: 6px 20px;
    font-weight: bold;
    font-size: 14px;
    background-color: #f9f9f9;
    margin-bottom: 20px;
  }

  /* 왼쪽: 리그 정보 수정 구역 */
  .info-edit-section {
    width: 35%;
  }
  .form-container {
    background-color: #f4f3e6; /* 사진의 연한 미색 배경 반영 */
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 25px 20px;
  }
  .input-group {
    margin-bottom: 15px;
  }
  .input-group input[type="text"],
  .input-group textarea {
    width: 100%;
    padding: 12px;
    border: 1px solid #777;
    border-radius: 6px;
    box-sizing: border-box;
    font-size: 14px;
  }
  .input-group textarea {
    height: 180px;
    resize: none; /* 크기 조절 비활성화 */
  }

  /* 오른쪽: 리그 가입 신청 현황 구역 */
  .request-status-section {
    width: 60%;
    text-align: right; /* 하단 '수정 완료' 버튼 배치를 위해 우측 정렬 */
  }
  .table-wrapper {
    width: 100%;
    margin-bottom: 25px;
  }
  .status-table {
    width: 100%;
    border-collapse: collapse;
    border: 1px solid #ccc;
    border-radius: 8px;
    overflow: hidden; /* 테두리 곡면 처리 유지 */
    text-align: center;
    font-size: 14px;
  }
  .status-table th {
    background-color: #f7f6e7; /* 헤더 연노랑/미색 배경 */
    border-bottom: 1px solid #ccc;
    border-right: 1px solid #e0e0e0;
    padding: 12px 8px;
    font-weight: normal;
  }
  .status-table td {
    border-bottom: 1px solid #eee;
    border-right: 1px solid #eee;
    padding: 12px 8px;
  }
  /* 테이블 마지막 열 우측 테두리 제거 */
  .status-table th:last-child,
  .status-table td:last-child {
    border-right: none;
  }
  /* O, X 아이콘 스타일 색상 부여 */
  .btn-approve { color: #ff4d4d; font-weight: bold; cursor: pointer; text-decoration: none; }
  .btn-reject { color: #ff4d4d; font-size: 16px; font-weight: bold; cursor: pointer; text-decoration: none; }

  /* 하단 수정 완료 버튼 */
  .submit-btn-container {
    margin-top: 15px;
  }
  .btn-submit {
    border: 2px solid #006400;
    background-color: #fff;
    color: #000;
    padding: 8px 30px;
    font-weight: bold;
    font-size: 14px;
    border-radius: 20px;
    cursor: pointer;
    transition: background 0.2s;
  }
  .btn-submit:hover {
    background-color: #006400;
    color: #fff;
  }
</style>
</head>
<body>
  <%@include file="/WEB-INF/include/headermenu.jsp" %>

  <div class="main-wrapper">
    <section class="info-edit-section">
      <div class="section-title">리그 정보 수정</div>
      
      <form action="/league/update" method="post">
        <div class="form-container">
          <div class="input-group">
            <input type="text" name="leagueName" placeholder="리그 이름">
          </div>
          <div class="input-group">
            <input type="text" name="leagueLocation" placeholder="연고지">
          </div>
          <div class="input-group">
            <textarea name="leagueContent" placeholder="리그 소개"></textarea>
          </div>
        </div>
      </form>
    </section>

    <section class="request-status-section">
      <div style="text-align: left;">
        <div class="section-title">리그 가입 신청 현황</div>
      </div>
      
      <div class="table-wrapper">
        <table class="status-table">
            <tr>
              <td>팀 이름  </td>
              <td>감독     </td>
              <td>인원 수  </td>
              <td>연고지   </td>
              <td>승인 버튼</td>
              <td>거절 버튼</td>
            </tr>
            <tr>
              <td>bugout</td>
              <td>정소민</td>
              <td>17</td>
              <td>사상</td>
              <td><a href="#" class="btn-approve">O</a></td>
              <td><a href="#" class="btn-reject">✕</a></td>
            </tr>
        </table>
      </div>

      <div class="submit-btn-container">
        <button type="submit" class="btn-submit">수정 완료</button>
      </div>
    </section>
    
  </div>
  
  <%@include file="/WEB-INF/include/footer.jsp" %> 
  
</body>
</html>
















