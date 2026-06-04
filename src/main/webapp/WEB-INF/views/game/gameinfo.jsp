<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 경기 정보</title>
<link rel="shortcut icon" href="/img/favicon2.png" type="image/png" />
<link href="/css/common.css" rel="stylesheet" />
<style>
    html, body {
        height: 100%;
    }

    body {
        background-color: #f5f7fa;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    .content-area {
        flex: 1;
        padding: 104px 0 32px;
        position: relative;
        overflow: visible;
        
        display: flex;
    		flex-direction: column;
    }

    .content-area::before {
        content: '';
        position: fixed;
        inset: 0;
        background-image: url('/img/index.png');
        background-size: cover;
        background-position: center 60%;
        filter: blur(10px) brightness(0.85);
        transform: scale(1.05);
        z-index: 0;
        pointer-events : none;
    }

    .main-wrapper {
        position: relative;
        z-index: 1;
        
        flex: 1;
    }

    .footer {
        position: relative;
    		z-index: 2;
    }
		
    .envdiv, .statdiv, .scorediv, .gamerecord, .btndiv {
        width: 95%;
        margin: 0 auto 28px;
        padding: 24px 28px;
        background: rgba(245, 245, 220, 0.88);
        border-radius: 10px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        box-sizing: border-box;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        border: none;
        background-color: transparent;
        margin-bottom: 15px;
    }

    td {
        border: none;
        border-bottom: 1px solid #e0dcc8;
        padding: 12px 14px;
        text-align: center;
        font-size: 14px;
        font-weight: 600;
        color: #111111;
    }

    tr:first-of-type td {
        background-color: #1a3d1a;
        color: #ffffff;
        font-family: 'Oswald', sans-serif;
        font-weight: 500;
        letter-spacing: 1px;
        border-bottom: 2px solid #FFD700;
    }

    tr:first-of-type td:first-child {
        border-radius: 6px 0 0 0;
    }

    tr:first-of-type td:last-child {
        border-radius: 0 6px 0 0;
    }

    tr:not(:first-of-type):hover td {
        background-color: #ece8d0;
    }

    input[type="button"],
    button {
        min-width: 120px;
        height: 36px;
        padding: 0 18px;
        background-color: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 6px;
        font-family: 'Oswald', sans-serif;
        font-weight: 700;
        letter-spacing: 0.5px;
        cursor: pointer;
        margin: 3px;
    }

    input[type="button"]:hover,
    button:hover {
        background-color: #e6c200;
    }

    .selected {
        background-color: #1a3d1a !important;
        color: #FFD700 !important;
        font-weight: 700;
    }

		.game-control-bar {
		    width: 95%;
		    margin: 0 auto 28px;
		    padding: 20px 28px;
		
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		
		    background: rgba(245, 245, 220, 0.88);
		    border-radius: 10px;
		    box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
		    box-sizing: border-box;
		}
		
		.awayhomechoose {
		    display: flex;
		    gap: 10px;
		}
		
		#updatebtn {
		    display: flex;
		}
		
		.btndiv {
		    text-align: center;
		}
		
		.team-logo {
    width: 70px;
    height: 70px;
    object-fit: contain;
		}
</style>
</head>
<body>
	<%@include file="/WEB-INF/include/headermenu.jsp" %>
	<div class="content-area">
	<div class="main-wrapper">
		<div class="envdiv">
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
		</div>
		<br>
		<div class="statdiv">
		<table id="gamestat">
			<tr>
				<td>로고</td>
				<td>Away팀</td>
				<td>Away점수</td>
				<td>경기상황</td>
				<td>Home점수</td>
				<td>Home팀</td>
				<td>로고</td>
			</tr>
			<tr>
				<td>
			    <c:if test="${not empty teamNames.away_logo}">
			        <img src="/sbndata/${teamNames.away_logo}" class="team-logo">
	        </c:if>
				</td>
				<td>${teamNames.away_name}</td>
				<td>${topScoreBoard.r}</td>
				<td>
				<c:choose>
				    <c:when test="${gameinfo.game_status == 0}">경기미진행</c:when>
				    <c:when test="${gameinfo.game_status == 1}">경기종료</c:when>
				    <c:when test="${gameinfo.game_status == 2}">경기중</c:when>
				    <c:when test="${gameinfo.game_status == 3}">우천취소</c:when>
				</c:choose>
				</td>
				<td>${bottomScoreBoard.r}</td>
				<td>${teamNames.home_name}</td>
				<td>
			    <c:if test="${not empty teamNames.home_logo}">
			        <img src="/sbndata/${teamNames.home_logo}" class="team-logo">
	        </c:if>
				</td>
			</tr>
		</table>
		</div>
		<br>
		<div class="scorediv">
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
				<td>R</td>
				<td>H</td>
				<td>B</td>
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
		</div>
		<br>
		<div class="game-control-bar">
			<div class="awayhomechoose">
				<input type="button" id="awayBtn" value="AWAY"/>
				<input type="button" id="homeBtn" value="HOME"/>
			</div>
			<c:if test="${sessionScope.login.is_admin == 'Y'}">
			<div id="updatebtn">
				<input type="button" value="경기결과 입력" 
				onclick ="window.location.href='/Game/AddResultForm?league_idx=${league_idx}&game_idx=${game_idx}'"/>
				<input type="button" value="경기결과 수정" 
				onclick ="window.location.href='/Game/UpdateResultForm?league_idx=${league_idx}&game_idx=${game_idx}'">
			</div>
			</c:if>
		</div>
		<br>
		<div class="gamerecord">
			<table id="awayhitterrecords" class="away">
				<tr>
					<td>타순</td>
					<td>이름</td>
					<td>타석</td>
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
							<td>${recorda.pa}</td>
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
					<td>타석</td>
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
							<td>${recordb.pa}</td>
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
		<div class="btndiv">
		<input type="button" value="경기목록"
		onclick ="window.location.href='/League/Info?league_idx=${league_idx}'">
		</div>
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
	    awayBtnEl.classList.add('selected');
		});
	
		awayBtnEl.addEventListener('click', () => {
	    awayEls.forEach(el => {el.style.display = '';});
	    homeEls.forEach(el => {el.style.display = 'none';});
	    awayBtnEl.classList.add('selected');
	    homeBtnEl.classList.remove('selected');
		});
	
		homeBtnEl.addEventListener('click', () => {
	    homeEls.forEach(el => {el.style.display = '';});
	    awayEls.forEach(el => {el.style.display = 'none';});
	    homeBtnEl.classList.add('selected');
	    awayBtnEl.classList.remove('selected');
		});
	
</script>
</body>
</html>