<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리그경기결과수정</title>
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
	input, select, textarea {
		width: 100%;
		box-sizing: border-box;
	}
	#gameresultdisplay tr:first-of-type{
	background-color: #F5F5DC;
	}
</style>
</head>
<body>
<%@include file="/WEB-INF/include/headermenu.jsp" %>
<div class="main-wrapper">
	<form id="gameUpdateForm" action="/Game/UpdateResult" method="post">
	<input type="hidden" name="game_idx" value="${gameDto.game_idx}">
	<input type="hidden" name="league_idx" value="${gameDto.league_idx}">
		<table id="gameresultdisplay">
			<tr>
				<td>회</td>
				<td>초(T)/말(F)</td>
				<td>타순</td>
				<td>타자</td>
				<td>타자ID</td>
				<td>투수</td>
				<td>투수ID</td>
				<td>결과</td>
				<td>타점</td>
				<td>투수자책점</td>
				<td>비고란</td>
			</tr>
			<c:forEach var="record" item="resultList">
			<tr class="result-line">
				<td>
					<input type="number" name="resultList[0].inning" value="${record.inning}" />
				</td>
				<td>
					<select name="resultList[0].top_bottom" value="${record.top_bottom}">
						<option>T</option>
						<option>B</option>
					</select>
				</td>
				<td>
					<input type="number" name="resultList[0].hitter_num" value="${record.hitter_num}"/>
				</td>
				<td>
					<input type="text" name="resultList[0].hitter_name" value="${record.hitter_name}" />
				</td>
				<td>
					<input type="text" name="resultList[0].hitter_id" value="${record.hitter_id}" />
				</td>
				<td>
					<input type="text" name="resultList[0].pitcher_name" value="${record.pitcher_name}" />
				</td>
				<td>
					<input type="text" name="resultList[0].pitcher_id" value="${record.pitcher_id}" />
				</td>
				<td>
					<select name="resultList[0].result" value="${record.result}">
						<option>1B</option>
						<option>2B</option>
						<option>3B</option>
						<option>HR</option>
						<option>K</option>
						<option>BB</option>
						<option>SAC</option>
						<option>OUT</option>
						<option>ETC</option>
					</select>
				</td>
				<td>
					<input type="number" name="resultList[0].get_score" min='0' max='4' value="${record.get_score}"/> 
				</td>
				<td>
					<input type="number" name="resultList[0].era" min='0' max='4' value="${record.era}"/>
				</td>
				<td>
					<textarea rows="1" cols="10" maxlength="2000" name="resultList[0].content" value="${record.content}"></textarea>
				</td>
			</tr>
			</c:forEach>
		</table>
		<input type="submit" value="경기결과 수정">
		<input type="submit" value="경기목록" onclick ="window.location.href='/League/Info?league_idx=${map.league_idx}'">
	<br>
	</form>
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>

</body>
</html>