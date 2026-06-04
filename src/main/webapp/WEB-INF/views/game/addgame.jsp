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
    }

    .footer {
        position: relative;
    		z-index: 2;
    }
		
		.game-add-box {
		    width: 50%;
		    margin: 50px auto 30px;
		    padding: 24px 28px;
		
		    background: rgba(245,245,220,0.88);
		    border-radius: 10px;
		    box-shadow: 0 2px 16px rgba(26,61,26,0.07);
		
		    box-sizing: border-box;
		}
		
		.game-add-box ul {
		    list-style: none;
		    margin: 0;
		    padding: 0;
		}
		
		.game-add-box li {
		    margin-bottom: 12px;
		}
		
		.game-add-box input {
		    width: 100%;
		    height: 40px;
		
		    border: 1px solid #dde2ea;
		    border-radius: 6px;
		
		    padding: 0 12px;
		    font-size: 14px;
		}
		
		.game-add-box input[type="submit"] {
		    background-color: #FFD700;
		    color: #1a3d1a;
		    border: none;
		    font-weight: 700;
		    cursor: pointer;
		}
		
		.game-add-box input[type="button"] {
		    background-color: #1a3d1a;
		    color: white;
		    border: none;
		    cursor: pointer;
		}
</style>

</head>
<body>
	<%@include file="/WEB-INF/include/headermenu.jsp" %>
<div class="content-area">
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
</div>
<%@include file="/WEB-INF/include/footer.jsp" %> 
</body>
</html>