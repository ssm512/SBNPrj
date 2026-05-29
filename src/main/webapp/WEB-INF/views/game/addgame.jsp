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
	<form action="/Game/AddGame" method="post">
	<input type="hidden" name="league_idx" value="${map.league_idx}">
		<table>
			<tr>
				<td>
				<input type="text" name="home_name" placeholder="홈팀명"/>
				</td>
			</tr>
			<tr>
				<td>
				<input type="text" name="away_name" placeholder="어웨이팀명"/>
				</td>
			</tr>
			<tr>
				<td>
				<input type="text" name="game_date" placeholder="경기날짜(2026-05-26)"/>
				</td>
			</tr>
			<tr>
				<td>
				<input type="text" name="game_time" placeholder="경기시간(18:30)"/>
				</td>
			</tr>
			<tr>
				<td>
				<input type="text" name="game_field" placeholder="경기장소"/>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="추가"/>
					<input type="button" value="목록" 
					onclick ="window.location.href='/League/Info?league_idx=${map.league_idx}'"/>
				</td>
			</tr>
		</table>
	</form>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp" %> 
</body>
</html>