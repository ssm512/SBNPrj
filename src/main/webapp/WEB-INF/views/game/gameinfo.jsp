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
				<td>${gameinfo.game_idx}</td>
				<td>${gameinfo.league_name}</td>
				<td>${gameinfo.game_date}</td>
				<td>${gameinfo.game_time}</td>
				<td>${gameinfo.game_field}</td>
			</tr>
		</table>
		<table id="gamestat">
			<tr>
				<td>${file.awayfile_name}</td>
				<td>${gameresult.awayteam_name}</td>
				<td>${gameresult.awayteam_score}</td>
				<td>${gameinfo.game_status}</td>
				<td>${gameresult.hometeam_score}</td>
				<td>${gameresult.hometeam_name}</td>
				<td>${file.homefile_name}</td>
			</tr>
		</table>
		<table>
			<tr>
				<td>팀명</td>
				<c:forEach var="result" items="resultList">
				 <td></td>
				</c:forEach>
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
				<td>${result1.inning }</td>
				<td>H</td>
				<td>B</td>
			</tr>
						
		</table>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp" %> 
</body>
</html>