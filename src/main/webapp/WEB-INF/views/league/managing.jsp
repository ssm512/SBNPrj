<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>League List</title>

<link rel="shortcut icon" href="/img/favicon2.png" type="image/png" />
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
  
  <form action="/League/Update" method="post">
  <input type="hidden" name="league_idx" value="${league.league_idx}" />

  <div class="main-wrapper">
    <section class="info-edit-section">
      <div class="section-title">리그 정보 수정</div>
      
        <div class="form-container">
          <div class="input-group">
            <input type="text" name="league_name" value="${league.league_name}" placeholder="리그 이름">
          </div>
          <div class="input-group">
            <input type="text" name="league_location" value="${league.league_location}" placeholder="연고지">
          </div>
          <div class="input-group">
            <textarea name="league_content" placeholder="리그 소개글을 적어주세요">${league.league_content}</textarea>
          </div>
        </div>
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
            
            <c:forEach var="team" items="${signTeamList}">
              <tr>
                <td>${team.team_name}</td>
                <td>${team.manager_name}</td>
                <td>${team.number_of_members}</td>
                <td>${team.team_location}</td>
                <td>
                  <a href="#" class="btn-approve"
                     data-league="${param.league_idx}"
                     data-team="${team.team_idx}">
                    O
                  </a>
                </td>
                <td>
                  <a href="#" class="btn-reject"
                     data-league="${param.league_idx}"
                     data-team="${team.team_idx}">
                    X
                  </a>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty signTeamList}">
              <tr>
                <td colspan="6">리그 가입 신청 팀이 없습니다.</td>
              </tr>
            </c:if>
            
        </table>
      </div>

      <div class="submit-btn-container">
        <button type="submit" class="btn-submit">수정 완료</button>
      </div>
    </section>
    
  </div>
  
  </form>
  <%@include file="/WEB-INF/include/footer.jsp" %> 
  
  <script>
	document.addEventListener("DOMContentLoaded", function() {
	    
	    // 1. 승인(O) 버튼 클릭 이벤트
	    document.querySelectorAll('.btn-approve').forEach(button => {
	        button.addEventListener('click', function(e) {
	            e.preventDefault();
	            if(!confirm("이 팀의 가입을 승인하시겠습니까?")) return;
	            
	            const leagueIdx = this.getAttribute('data-league');
	            const teamIdx = this.getAttribute('data-team');
	            
	            // 클릭한 버튼 요소(this)를 함께 전달
	            sendRequest('/League/ApproveTeam', leagueIdx, teamIdx, this);
	        });
	    });
	
	    // 2. 거절(✕) 버튼 클릭 이벤트
	    document.querySelectorAll('.btn-reject').forEach(button => {
	        button.addEventListener('click', function(e) {
	            e.preventDefault();
	            if(!confirm("이 팀의 가입 신청을 거절(삭제)하시겠습니까?")) return;
	            
	            const leagueIdx = this.getAttribute('data-league');
	            const teamIdx = this.getAttribute('data-team');
	            
	            // 위와 마찬가지로 클릭한 버튼 요소(this)를 함께 전달
	            sendRequest('/League/RejectTeam', leagueIdx, teamIdx, this);
	        });
	    });
	    
	    // 서버로 데이터를 전송하는 공통 함수 (Fetch API 사용)
	    function sendRequest(url, leagueIdx, teamIdx, btnElement) {
	        const formData = new URLSearchParams();
	        formData.append('league_idx', leagueIdx);
	        formData.append('team_idx', teamIdx);
	        
	        fetch(url, {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/x-www-form-urlencoded'
	            },
	            body: formData
	        })
	        .then(response => response.text())
	        .then(data => {
	            if(data.trim() === "success") {
	                alert("처리가 완료되었습니다.");
	                
	                // 성공 시 새로고침 없이 화면에서 해당 팀 행(row) 제거
	                const row = btnElement.closest('tr');
	                if(row) {
	                	row.remove();
	                }
	            } else {
	                alert("처리 중 오류가 발생했습니다.");
	            }
	        })
	        .catch(error => {
	            console.error('Error:', error);
	            alert("서버 통신 오류가 발생했습니다.");
	        });
	    }
	    
		const formEl           = document.querySelector('form')
		const leagueNameEl     = document.querySelector('[name="league_name"]')
		const leagueLocationEl = document.querySelector('[name="league_location"]')
		const leagueContentEl  = document.querySelector('[name="league_content"]')
		
		// 작성한 내용의 양이 DB 설정값을 초과했을때 500 에러 방지
		function getByteSize(str) {
		  let byte = 0;
		  for (let i = 0; i < str.length; i++) {
			byte += str.charCodeAt(i) > 127 ? 3 : 1;
		}
		  return byte;
	  }
		
		formEl.addEventListener('submit', function( e ) {
			
			// 리그 이름 입력 안했을 때
			if( leagueNameEl.value.trim() == '' ) {
				alert('리그 이름을 입력하세요')
				leagueNameEl.focus();
				e.preventDefault()  // 이벤트 취소
				e.stopPropagation() // 이벤트 버블링 방지
				return;
			}
			
			// 연고지 입력 안했을 때
			if( leagueLocationEl.value.trim() == '' ) {
				alert('연고지를 입력하세요')
				leagueLocationEl.focus();
				e.preventDefault()  // 이벤트 취소
				e.stopPropagation() // 이벤트 버블링 방지
				return;
			}
			
			// 리그 이름이 값을 초과했을 때
			if ( getByteSize(leagueNameEl.value) > 50 ) {
				alert( '리그 이름이 너무 깁니다. (현재' + getByteSize(leagueNameEl.value) + 'byte / 최대 50byte)');
		        leagueNameEl.focus();
		        e.preventDefault()  // 이벤트 취소
				e.stopPropagation() // 이벤트 버블링 방지
				return;
			}
			// 연고지가 값을 초과했을 때
			if ( getByteSize(leagueLocationEl.value) > 20 ) {
				alert( '연고지 이름이 너무 깁니다. (현재' + getByteSize(leagueLocationEl.value) + 'byte / 최대 20byte)');
				leagueLocationEl.focus();
		        e.preventDefault()  // 이벤트 취소
				e.stopPropagation() // 이벤트 버블링 방지
				return;
			}
			// 리그 소개가 값을 초과했을 때
			if ( getByteSize(leagueContentEl.value) > 2000 ) {
				alert( '연고지 이름이 너무 깁니다. (현재' + getByteSize(leagueContentEl.value) + 'byte / 최대 2000byte)');
				leagueContentEl.focus();
		        e.preventDefault()  // 이벤트 취소
				e.stopPropagation() // 이벤트 버블링 방지
				return;
			}
			
	
		})
	});
	
	
  </script>
  
</body>
</html>
















