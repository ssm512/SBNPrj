<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리그경기추가</title>
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
				<td>${game.game_idx}</td>
				<td>${game.league_name}</td>
				<td>${game.game_date}</td>
				<td>${game.game_time}</td>
				<td>${game.game_field}</td>
			</tr>
		</table>
		<table id="gamestat">
			<tr>
				<td>${file.awayfile_name}</td>
				<td>${game.awayteam_name}</td>
				<td>${game.awayteam_score}</td>
				<td>${game.game_status}</td>
				<td>${game.hometeam_score}</td>
				<td>${game.hometeam_name}</td>
				<td>${file.homefile_name}</td>
			</tr>
		</table>
		<table>
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
				<td>${game.awayteam_name}</td>
				<td>${result1.inning }</td>
				<td>${result1.inning }</td>
				<td>${result1.inning }</td>
				<td>${result1.inning }</td>
				<td>${result1.inning }</td>
				<td>${result1.inning }</td>
				<td>${result1.inning }</td>
				<td>${result1.inning }</td>
				<td>${result1.inning }</td>				
				<td>${result1. }</td>
				<td>H</td>
				<td>B</td>
			</tr>
						
		</table>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp" %> 
</body>
</html>