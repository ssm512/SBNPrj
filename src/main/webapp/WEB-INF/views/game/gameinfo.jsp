<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리그경기추가</title>
<link href="/css/common.css" rel="stylesheet" />
<style>
	table {
		border-collapse: collapse;
		width: 100%;
	}
	td {
		border: 1px solid black;
		padding: 5px;
		text-align: center;
	}
	.selected {
    background-color: #FFD700;
	}
</style>
</head>
<body>
	<%@include file="/WEB-INF/include/headermenu.jsp" %>
	<div class="main-wrapper">
		<table id="gameenv">
			<tr>
				<td>경기번호</td>
				<td>리그</td>
				<td>날짜</td>
				<td>시간</td>
				<td>장소</td>
			</tr>
			<tr>
				<td>${gameinfo.game_idx}</td>
				<td>${league_name}</td>
				<td>${gameinfo.game_date}</td>
				<td>${gameinfo.game_time}</td>
				<td>${gameinfo.game_field}</td>
			</tr>
		</table>
		<br>
		<table id="gamestat">
			<tr>
				<td><%-- ${file.awayfile_name} --%></td>
				<td>${teamNames.away_name}</td>
				<td>${topScoreBoard.r}</td>
				<td>${gameinfo.game_status}</td>
				<td>${bottomScoreBoard.r}</td>
				<td>${teamNames.home_name}</td>
				<td><%-- ${file.homefile_name} --%></td>
			</tr>
		</table>
		<br>
		<table id="scoreboard">
			<tr>
				<td>팀명</td>
				<td>1</td>
				<td>2</td>
				<td>3</td>
				<td>4</td>
				<td>5</td>
				<td>6</td>
				<td>7</td>
				<td>8</td>
				<td>9</td>
				<td>R(점수)</td>
				<td>H(안타+홈런)</td>
				<td>B(사사구)</td>
			</tr>
			<tr>
				<td>${teamNames.away_name}</td>
				<td>${topScoreBoard.i1}</td>
				<td>${topScoreBoard.i2}</td>
				<td>${topScoreBoard.i3}</td>
				<td>${topScoreBoard.i4}</td>
				<td>${topScoreBoard.i5}</td>
				<td>${topScoreBoard.i6}</td>
				<td>${topScoreBoard.i7}</td>
				<td>${topScoreBoard.i8}</td>
				<td>${topScoreBoard.i9}</td>
				<td>${topScoreBoard.r}</td>
				<td>${topScoreBoard.h}</td>
				<td>${topScoreBoard.b}</td>
			</tr>
			<tr>
				<td>${teamNames.home_name}</td>
				<td>${bottomScoreBoard.i1}</td>
				<td>${bottomScoreBoard.i2}</td>
				<td>${bottomScoreBoard.i3}</td>
				<td>${bottomScoreBoard.i4}</td>
				<td>${bottomScoreBoard.i5}</td>
				<td>${bottomScoreBoard.i6}</td>
				<td>${bottomScoreBoard.i7}</td>
				<td>${bottomScoreBoard.i8}</td>
				<td>${bottomScoreBoard.i9}</td>
				<td>${bottomScoreBoard.r}</td>
				<td>${bottomScoreBoard.h}</td>
				<td>${bottomScoreBoard.b}</td>
			</tr>
		</table>
		<br>
		<div id="awayhomechoose">
			<input type="button" id="awayBtn" value="away"/>
			<input type="button" id="homeBtn" value="home"/>
		</div>
		<div id="updatebtn">
			<input type="button" value="입력" 
			onclick ="window.location.href='/Game/AddResultForm?league_idx=${league_idx}&game_idx=${game_idx}'"/>
			<input type="button" value="수정"/>
		</div>
		<br>
		<div id="gamerecord">
			<table id="awayhitterrecords" class="away">
				<tr>
					<td>타순</td>
					<td>이름</td>
					<td>타수</td>
					<td>타점</td>
					<td>안타</td>
					<td>홈런</td>
					<td>희생타</td>
					<td>사사구</td>
					<td>삼진</td>
					<td>타율</td>
				</tr>
					<c:forEach var="recorda" items="${awayHRecord}">
						<tr>
							<td>${recorda.hitter_num}</td>
							<td>${recorda.hitter_name}</td>
							<td>${recorda.at_bat}</td>
							<td>${recorda.score}</td>
							<td>${recorda.hit}</td>
							<td>${recorda.hr}</td>
							<td>${recorda.sac}</td>
							<td>${recorda.bb}</td>
							<td>${recorda.k}</td>
							<td>${recorda.avg}</td>
						</tr>
					</c:forEach>
			</table>
			<table id="homehitterrecords" class="home">
				<tr>
					<td>타순</td>
					<td>이름</td>
					<td>타수</td>
					<td>타점</td>
					<td>안타</td>
					<td>홈런</td>
					<td>희생타</td>
					<td>사사구</td>
					<td>삼진</td>
					<td>타율</td>
				</tr>
					<c:forEach var="recordb" items="${homeHRecord}">
						<tr>
							<td>${recordb.hitter_num}</td>
							<td>${recordb.hitter_name}</td>
							<td>${recordb.at_bat}</td>
							<td>${recordb.score}</td>
							<td>${recordb.hit}</td>
							<td>${recordb.hr}</td>
							<td>${recordb.sac}</td>
							<td>${recordb.bb}</td>
							<td>${recordb.k}</td>
							<td>${recordb.avg}</td>
						</tr>
					</c:forEach>
			</table>
			<br>
			<table id="awaypitcherrecords" class="away">
				<tr>
					<td>이름</td>
					<td>이닝</td>
					<td>피안타</td>
					<td>실점</td>
					<td>자책점</td>
					<td>사사구</td>
					<td>탈삼진</td>
					<td>피홈런</td>
					<td>타자</td>
					<td>타수</td>
				</tr>
				<c:forEach var="awayP" items="${awayPRecord}">
					<tr>
						<td>${awayP.PITCHER_NAME}</td>
						<td>${awayP.INNINGS}</td>
						<td>${awayP.HIT_CNT}</td>
						<td>${awayP.RUN_CNT}</td>
						<td>${awayP.ERA_CNT}</td>
						<td>${awayP.BB_CNT}</td>
						<td>${awayP.K_CNT}</td>
						<td>${awayP.HR_CNT}</td>
						<td>${awayP.BATTER_CNT}</td>
						<td>${awayP.AT_BAT_CNT}</td>
					</tr>
				</c:forEach>
			</table>
			<table id="homepitcherrecords" class="home">
				<tr>
					<td>이름</td>
					<td>이닝</td>
					<td>피안타</td>
					<td>실점</td>
					<td>자책점</td>
					<td>사사구</td>
					<td>탈삼진</td>
					<td>피홈런</td>
					<td>타자</td>
					<td>타수</td>
				</tr>
				<c:forEach var="homeP" items="${homePRecord}">
					<tr>
						<td>${homeP.PITCHER_NAME}</td>
						<td>${homeP.INNINGS}</td>
						<td>${homeP.HIT_CNT}</td>
						<td>${homeP.RUN_CNT}</td>
						<td>${homeP.ERA_CNT}</td>
						<td>${homeP.BB_CNT}</td>
						<td>${homeP.K_CNT}</td>
						<td>${homeP.HR_CNT}</td>
						<td>${homeP.BATTER_CNT}</td>
						<td>${homeP.AT_BAT_CNT}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp" %> 
	
<script>
	const homeEls		= document.querySelectorAll('.home')
	const awayEls		= document.querySelectorAll('.away')
	const awayBtnEl	=	document.querySelector('#awayBtn')
	const homeBtnEl	=	document.querySelector('#homeBtn')
	
		homeEls.forEach(el => {
	    el.style.display = 'none';
		});
	
		awayBtnEl.addEventListener('click', () => {
	    awayEls.forEach(el => {
	        el.style.display = '';
	    });
	    homeEls.forEach(el => {
		       el.style.display = 'none';
	    });
	    awayBtnEl.classList.add('selected');
	    homeBtnEl.classList.remove('selected');
		});
	
		homeBtnEl.addEventListener('click', () => {
	    homeEls.forEach(el => {
	        el.style.display = '';
	    });
	    awayEls.forEach(el => {
	        el.style.display = 'none';
	    });
	    homeBtnEl.classList.add('selected');
	    awayBtnEl.classList.remove('selected');
		});
	
</script>
</body>
</html>