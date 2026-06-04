<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리그경기추가</title>
<link rel="shortcut icon" href="/img/favicon2.png" type="image/png" />
<link href="/css/common.css" rel="stylesheet" />

<style>
    .game-add-box {
        width: 50%;
        margin: 40px auto 0 auto;
        padding: 18px 28px 25px 28px;
        background-color: #F5F5DC;
        border: 1px solid #cfcfb0;
        border-radius: 4px;
    }

    .game-add-box ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .game-add-box li {
        margin-bottom: 10px;
    }

    .game-add-box input {
        width: 100%;
        height: 36px;
        box-sizing: border-box;
        border: 2px solid #777;
        border-radius: 3px;
        padding: 0 8px;
        font-size: 14px;
    }

    .game-add-box input[type="submit"] {
        background-color: #ffd700;
        border: 1px solid #d6b300;
        font-weight: bold;
        cursor: pointer;
    }

    .game-add-box input[type="button"] {
        background-color: #fff;
        cursor: pointer;
    }
</style>

</head>
<body>
	<%@include file="/WEB-INF/include/headermenu.jsp" %>
	<div class="main-wrapper">
	<form action="/Game/AddGame" method="post">
	<input type="hidden" name="league_idx" value="${map.league_idx}">
	<div class="game-add-box">
		<ul>
			<li>
				<input type="text" name="home_name" placeholder="홈팀명"/>
			</li>
			<li>
				<input type="text" name="away_name" placeholder="어웨이팀명"/>
			</li>
			<li>
				<input type="text" name="game_date" placeholder="경기날짜(2026-05-26)"/>
			</li>
			<li>
				<input type="text" name="game_time" placeholder="경기시간(18:30)"/>
			</li>
			<li>
				<input type="text" name="game_field" placeholder="경기장소"/>
			</li>
			<li>
					<input type="submit" value="추가"/>
			</li>
			<li>
					<input type="button" value="경기목록" 
					onclick ="window.location.href='/League/Info?league_idx=${map.league_idx}'"/>
			</li>
		</ul>
	</div>
	</form>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp" %> 
</body>
</html>