<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리그경기추가</title>
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

</style>
</head>
<body>
<%@include file="/WEB-INF/include/headermenu.jsp" %>
<div class="main-wrapper">
<form action="/Game/AddResult" method="post">
	<table id="gameenv">
		<tr>
			<td></td>
			<td></td>
		</tr>
	</table>
	<table id="gameresultinput">
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
			<td>행추가</td>
			<td>행삭제</td>
		</tr>
		<tr class="result-line">
			<td>
				<input type="number" name="inning"/>
			</td>
			<td>
				<select name="top_bottom">
					<option>T</option>
					<option>B</option>
				</select>
			</td>
			<td>
				<input type="number" name="hitter_num"/>
			</td>
			<td>
				<input type="text" name="hitter_name"/>
			</td>
			<td>
				<input type="text" name="hitter_id"/>
			</td>
			<td>
				<input type="text" name="pitcher_name"/>
			</td>
			<td>
				<input type="text" name="pitcher_id"/>
			</td>
			<td>
				<select name="result">
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
				<input type="number" name="get_score"/>
			</td>
			<td>
				<input type="number" name="era"/>
			</td>
			<td>
				<textarea rows="1" cols="10" maxlength="2000" name="content"></textarea>
			</td>
			<td>
				<input type="button" class="btn-row-add" value="행추가"/>
			</td>
			<td>
				<input type="button" class="btn-row-remove" value="행삭제"/>
			</td>
		</tr>
	</table>
	<br>
	<input type="submit" value="입력"/>
</form>
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<script>

	const gameTableEl = document.querySelector('#gameresultinput')
	gameTableEl.addEventListener('click', function(e) {
		// 행 추가
		if(e.target.classList.contains('btn-row-add')) {
			const currentRow = e.target.closest('tr')
			const newRow = currentRow.cloneNode(true)
			// 값 초기화
			newRow.querySelectorAll('input').forEach(input => {
				if(input.type !== 'button') {
					input.value = ''
				}
			})
			newRow.querySelectorAll('textarea').forEach(textarea => {
				textarea.value = ''
			})

			newRow.querySelectorAll('select').forEach(select => {
				select.selectedIndex = 0
			})

			gameTableEl.appendChild(newRow)

		}

		// 행 삭제
		if(e.target.classList.contains('btn-row-remove')) {
			const rows = document.querySelectorAll('.result-line')
			// 최소 1줄 유지
			if(rows.length <= 1) {
				alert('최소 1개의 행은 필요합니다.')
				return
			}
			e.target.closest('tr').remove()
		}
	})

</script>

</body>
</html>