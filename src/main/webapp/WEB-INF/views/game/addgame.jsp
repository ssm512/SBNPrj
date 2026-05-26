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
	<form action="/Member/Signin" method="post">
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
				<input type="date" name="game_date" placeholder="경기날짜(2026-05-26)"/>
				</td>
			</tr>
			<tr>
				<td>
				<input type="time" name="game_time" placeholder="경기시간(18:30)"/>
				</td>
			</tr>
			<tr>
				<td>
				<input type="text" name="game_feild" placeholder="경기장소"/>
				</td>
			</tr>
			<tr>
				<td>
				경기 진행 여부 : 
				<input type="radio" name="game_status" id="no_game" value="0" checked/>
				<label for="no_game">미진행</label>
				<input type="radio" name="game_status" id="game_end" value="1"/>
				<label for="game_end">완료</label>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="추가"/>
					<input type="button" value="목록" 
					onclick ="window.location.href='/league/list'"/>
				</td>
			</tr>
		</table>
	</form>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp" %> 
</body>
</html>