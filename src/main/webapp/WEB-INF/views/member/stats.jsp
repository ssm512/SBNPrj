<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 선수 기록</title>

<link rel="shortcut icon" href="/img/favicon.png" type="image/x-icon" />
<link href="/css/common.css" rel="stylesheet" />

<style>

	.main-wrapper {
		display: grid;
		justify-content: center;
		gap: 20px;
		grid-template-columns: 1fr 3fr;
	}
	
	.hit-pitch-btn {
		margin: 15px auto;
		text-align: center;
		width: 100%;
		display: flex;
		gap: 5px;
		input {
			flex: 1;
			margin: 5px 10px;
			height: 40px;
		}
	}
	
	.profile {
		height: 45px;
		border: 2px solid green;
		border-radius: 15px;
		text-align: center;
		p {
			padding: 10px;
		}
	}
	
	.myteamlist {
		margin-top: 25px;
		width: 100%;
		text-align: center;
		td { padding: 10px; }
	}
	
	.myteamlist tr:first-of-type {
		background: #F5F5DC;
	}
	
  .myteamlist tr:not(:first-of-type):hover {
  	background-color: #D9D9D9;
  	cursor: pointer;
  }
  
  table {
  	width: 100%;
  	text-align: center;
  	margin: 15px auto;
  }
  
  .stats-top {
  	margin-top: 45px;
    height: 130px;
  }
  
  .stats-mid, .stats-bottom {
  	tr:first-of-type {
  		background: #F5F5DC;
  	}
  	td {
  		height: 45px;
  		width: 10%;
  	}
  }
  
  .hit-pitch-btn input {
    background: white;
    border-radius: 15px;
    border: 2px solid #006500;
    cursor: pointer;
	}

	.hit-pitch-btn input.active {
    background: #FFD700;
    font-weight: bold;
	}
  
	
</style>

</head>
<body>
	<%@include file="/WEB-INF/include/headermenu.jsp" %>
	
	
	<div class="main-wrapper">
		<div class="left-side">
			<div class="hit-pitch-btn">
				<input type="button" id="hitBtn" value="타자"/>
				<input type="button" id="pitchBtn" value="투수"/>
			</div>
			<div class="profile">
				<p>${ member.member_name } [${ member.elite }]</p>
			</div>
			<table class="myteamlist">
				<tr>
					<td>소속팀목록</td>
				</tr>
				<c:forEach var="team" items="${ teamList }" >
					<tr onclick='location.href="/Team/Info?team_idx=${ team.team_idx }&keyword="' style="cursor:pointer;">
						<td>${ team.team_name } 
						<b>${ member.member_idx eq team.team_manager ? '[감독]' : '' }</b></td>
					</tr>
				</c:forEach>
			</table>
		</div>
		
		<div class="right-side">
		<c:forEach var="team" items="${ teamList }" >
			<input type="button" id="team-stats-btn" value="${team.team_name}" data-team-idx="${ team.team_idx }"/>
		</c:forEach>
			<!-- 타자 -->
			<div id="hitArea">
			<table class="stats-top">
				<tr>
					<td>타율<br>0.000</td>
					<td>경기 수<br>0 경기</td>
					<td>총 안타<br>0 개</td>
					<td>타점<br>0 점</td>
				</tr>
				<tr>
					<td>사사구<br>0 개</td>
					<td>장타율<br>0.000</td>
					<td>출루율<br>0.000</td>
					<td>OPS<br>0.000</td>
				</tr>
			</table>
			<table class="stats-mid">
				<tr>
					<td>시즌</td>
					<td>경기 수</td>
					<td>타율</td>
					<td>타석</td>
					<td>타수</td>
					<td>총 안타</td>
					<td>1루타</td>
					<td>2루타</td>
					<td>3루타</td>
					<td>홈런</td>
				</tr>
				<tr>
					<td>통산</td>
					<td>.경기 수</td>
					<td>.타율</td>
					<td>.타석</td>
					<td>.타수</td>
					<td>.총 안타</td>
					<td>.1루타</td>
					<td>.2루타</td>
					<td>.3루타</td>
					<td>.홈런</td>
				</tr>
			</table>
			<table class="stats-bottom">
				<tr>
					<td>시즌</td>
					<td>루타</td>
					<td>타점</td>
					<td>사사구</td>
					<td>삼진</td>
					<td>장타율</td>
					<td>출루율</td>
					<td>OPS</td>
					<td>희타<br>희비</td>
					<td>임시 공란</td>
				</tr>
				<tr>
					<td>통산</td>
					<td>.루타</td>
					<td>.타점</td>
					<td>.사사구</td>
					<td>.삼진</td>
					<td>.장타율</td>
					<td>.출루율</td>
					<td>.OPS</td>
					<td>.희타/희비</td>
					<td>.임시 공란</td>
				</tr>
			</table>
			</div>
			<!-- 투수 -->
			<div id="pitchArea" style="display:none;">
			<table class="stats-top">
				<tr>
					<td>방어율<br>0.00</td>
					<td>승<br>0</td>
					<td>패<br>0</td>
					<td>탈삼진<br>0 개</td>
				</tr>
				<tr>
					<td>이닝<br>0</td>
					<td>사사구<br>0 개</td>
					<td>피안타<br>0 개</td>
					<td>WHIP<br>0.00</td>
				</tr>
			</table>
			<table class="stats-mid">
				<tr>
					<td>시즌</td>
					<td>경기 수</td>
					<td>방어율</td>
					<td>승</td>
					<td>패</td>
					<td>세이브</td>
					<td>홀드</td>
					<td>타자</td>
					<td>타수</td>
					<td>이닝</td>
				</tr>
				<tr>
					<td>.시즌</td>
					<td>.경기 수</td>
					<td>.방어율</td>
					<td>.승</td>
					<td>.패</td>
					<td>.세이브</td>
					<td>.홀드</td>
					<td>.타자</td>
					<td>.타수</td>
					<td>.이닝</td>
				</tr>
			</table>
			<table class="stats-bottom">
				<tr>
					<td>통산</td>
					<td>피안타</td>
					<td>피홈런</td>
					<td>사사구</td>
					<td>희타<br>희비</td>
					<td>탈삼진</td>
					<td>실점</td>
					<td>자책점</td>
					<td>WHIP</td>
					<td>임시 공란</td>
				</tr>
				<tr>
					<td>.통산</td>
					<td>.피안타</td>
					<td>.피홈런</td>
					<td>.사사구</td>
					<td>.희타<br>희비</td>
					<td>.탈삼진</td>
					<td>.실점</td>
					<td>.자책점</td>
					<td>.WHIP</td>
					<td>.임시 공란</td>
				</tr>
			</table>
			</div>
		</div>
	
	
	</div>
	
	
	
	 
	<%@include file="/WEB-INF/include/footer.jsp" %> 
	
	
	<script>
	
	const hitBtnEl    = document.querySelector('#hitBtn')
	const pitchBtnEl  = document.querySelector('#pitchBtn')
	const hitAreaEl   = document.querySelector('#hitArea')
	const pitchAreaEl = document.querySelector('#pitchArea')
	
	// 초기 active 설정
	hitBtnEl.classList.add('active')

	hitBtnEl.addEventListener('click', function() {
    hitAreaEl.style.display   = 'block'
    pitchAreaEl.style.display = 'none'
    hitBtnEl.classList.add('active')
    pitchBtnEl.classList.remove('active')
	})

	pitchBtnEl.addEventListener('click', function() {
    hitAreaEl.style.display   = 'none'
    pitchAreaEl.style.display = 'block'
    pitchBtnEl.classList.add('active')
    hitBtnEl.classList.remove('active')
	})
	
	
	
	</script>
</body>
</html>