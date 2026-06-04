<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리그경기결과추가</title>
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
        pointer-events: none;
    }

    .main-wrapper {
        position: relative;
        z-index: 1;
        
    }

    .footer {
		    position: relative;
		    z-index: 2;
    }
    
		.statdiv, .resultdiv {
		    width: 95%;
		    margin: 30px auto;
		    padding: 24px 28px;
		
		    background: rgba(245,245,220,0.88);
		    border-radius: 10px;
		    box-shadow: 0 2px 16px rgba(26,61,26,0.07);
		
		    box-sizing: border-box;
		}
		
		table {
		    width: 100%;
		    border-collapse: collapse;
		}
		
		td {
		    border-bottom: 1px solid #e0dcc8;
		    padding: 10px;
		    text-align: center;
		}
		
		tr:first-child td {
		    background-color: #1a3d1a;
		    color: white;
		    border-bottom: 2px solid #FFD700;
		}
		
		input, select, textarea {
		    width: 100%;
		    height: 34px;
		
		    border: 1px solid #dde2ea;
		    border-radius: 6px;
		
		    padding: 0 8px;
		    box-sizing: border-box;
		}
		
		input[type="radio"] {
    width: auto;
    height: auto;
    transform: scale(0.8);
    margin-right: 3px;
		}
		
		input[type="submit"],	input[type="button"],	button {
		    background-color: #FFD700;
		    color: #1a3d1a;
		
		    border: none;
		    border-radius: 6px;
		
		    font-weight: 700;
		    cursor: pointer;
		    width: 130px;
		}
		
		#btns {
				margin: 20px auto 0;
				text-align: center;
		}
		
		#btnGameStatUpdate {
				width: 130px;
		}
</style>

</head>
<body>
<%@include file="/WEB-INF/include/headermenu.jsp" %>
<div class="content-area">
<div class="main-wrapper">
	<div class="statdiv">
	<form id="gamestatForm">
	<input type="hidden" id="game_idx" value="${gameDto.game_idx}">
	<input type="hidden" name="league_idx" value="${gameDto.league_idx}">
		<table id="gamestat">
			<tr>
				<td id="view_game_idx">경기번호 : ${gameDto.game_idx}</td>
				<td>경기정보</td>
				<td>리그번호 : ${gameDto.league_idx}</td>
			</tr>
			<tr>
				<td>Away : ${teamNames.away_name}</td>
				<td>경기시각 : ${gameDto.game_time}</td>
				<td>Home : ${teamNames.home_name}</td>
			</tr>
			<tr>
				<td>경기날짜 : ${gameDto.game_date}</td>
				<td>
				경기여부 : 
				<span style="display:inline-block; width:100px;">
				<input type="radio" name="game_status" id="statusbeforegame" value="0" 
				${gameDto.game_status == '0' ? 'checked' : '' }/>
				<label for="statusbeforegame">경기미진행</label>
				</span>
				<span style="display:inline-block; width:100px;">
				<input type="radio" name="game_status" id="endgame" value="1"
				${gameDto.game_status == '1' ? 'checked' : '' }/>
				<label for="endgame">경기종료</label>
				</span>
				<span style="display:inline-block; width:100px;">
				<input type="radio" name="game_status" id="ingame" value="2"
				${gameDto.game_status == '2' ? 'checked' : '' }/>
				<label for="ingame">경기중</label>
				</span>
				<span style="display:inline-block; width:100px;">
				<input type="radio" name="game_status" id="rainstop" value="3"
				${gameDto.game_status == '3' ? 'checked' : '' }/>
				<label for="rainstop">우천취소</label>
				</span>
				</td>
				<td>경기장 : ${gameDto.game_field}</td>
			</tr>
			<tr>
				<td>
					승리투수 : <input type="text" id="win_pitcher" name="win_pitcher" value="${gameDto.win_pitcher}">
				</td>
				<td>
					승자여부 : 
					<span style="display:inline-block; width:100px;">
					<input type="radio" name="winner" id="beforegame" value="0" 
					${gameDto.winner == '0' ? 'checked' : '' }/>
					<label for="beforegame">미정</label>
					</span>
					<span style="display:inline-block; width:100px;">
					<input type="radio" name="winner" id="awaywin" value="1"
					${gameDto.winner == '1' ? 'checked' : '' }/>
					<label for="awaywin">원정승</label>
					</span>
					<span style="display:inline-block; width:100px;">
					<input type="radio" name="winner" id="homewin" value="2"
					${gameDto.winner == '2' ? 'checked' : '' }/>
					<label for="homewin">홈승</label>
					</span>
					<span style="display:inline-block; width:100px;">
					<input type="radio" name="winner" id="draw" value="3"
					${gameDto.winner == '3' ? 'checked' : '' }/>
					<label for="draw">무승부</label>
					</span>
				</td>
				<td>
					패전투수 : <input type="text" id="lose_pitcher" name="lose_pitcher" value="${gameDto.lose_pitcher}">
				</td>
			</tr>
			<tr>
				<td>
					세이브투수 : <input type="text" id="save_pitcher" name="save_pitcher" value="${gameDto.save_pitcher}">
				</td>
				<td>
					<input type="button" id="btnGameStatUpdate" value="경기정보 수정">
				</td>
				<td>
					홀드 투수 : <input type="text" id="hold_pitcher" name="hold_pitcher" value="${gameDto.hold_pitcher}">
				</td>
			</tr>
		</table>		
	</form>
	</div>
	<br>
	<div class="resultdiv">
	<form id="gameResultForm" action="/Game/AddResult" method="post">
	<input type="hidden" name="game_idx" value="${gameDto.game_idx}">
	<input type="hidden" name="league_idx" value="${gameDto.league_idx}">
		<table id="gameresultinput">
			<tr>
				<td>회</td>
				<td>초(T)/말(B)</td>
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
					<input type="number" name="resultList[0].inning" value="0"/>
				</td>
				<td>
					<select name="resultList[0].top_bottom" >
						<option>T</option>
						<option>B</option>
					</select>
				</td>
				<td>
					<input type="number" name="resultList[0].hitter_num"/>
				</td>
				<td>
					<input type="text" name="resultList[0].hitter_name"/>
				</td>
				<td>
					<input type="text" name="resultList[0].hitter_id"/>
				</td>
				<td>
					<input type="text" name="resultList[0].pitcher_name"/>
				</td>
				<td>
					<input type="text" name="resultList[0].pitcher_id"/>
				</td>
				<td>
					<select name="resultList[0].result">
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
					<input type="number" name="resultList[0].get_score" min='-4' max='4' value="0"/>
				</td>
				<td>
					<input type="number" name="resultList[0].era" min='-4' max='4' value='0'/>
				</td>
				<td>
					<textarea rows="1" cols="10" maxlength="2000" name="resultList[0].content"></textarea>
				</td>
				<td>
					<input type="button" class="btn-row-add" style="width:auto;" value="행추가"/>
				</td>
				<td>
					<input type="button" class="btn-row-remove" style="width:auto;" value="행삭제"/>
				</td>
			</tr>
		</table>
		<div id="btns">
			<input type="submit" value="경기결과 입력">
			<input type="button" value="경기결과 수정" 
			onclick ="window.location.href='/Game/UpdateResultForm?league_idx=${gameDto.league_idx}&game_idx=${gameDto.game_idx}'">
			<input type="button" value="경기목록"
			onclick ="window.location.href='/Game/GameInfo?league_idx=${gameDto.league_idx}&game_idx=${gameDto.game_idx}'">
		</div>
	</form>
	</div>
</div>
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<!-- 게임 stat update -->
<script>
const btnGameStatUpdate = document.querySelector('#btnGameStatUpdate');

btnGameStatUpdate.addEventListener('click', function () {
    const data = {
        game_idx: Number(document.querySelector('#game_idx').value),
        game_status: Number(
            document.querySelector('input[name="game_status"]:checked').value
        ),
        winner: Number(
            document.querySelector('input[name="winner"]:checked').value
        ),
        win_pitcher: document.querySelector('#win_pitcher').value,
        lose_pitcher: document.querySelector('#lose_pitcher').value,
        save_pitcher: document.querySelector('#save_pitcher').value,
        hold_pitcher: document.querySelector('#hold_pitcher').value
    };

    fetch('/Game/UpdateGameStat', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(updatedGame => {
        document.querySelector('#win_pitcher').value = updatedGame.win_pitcher ?? '';
        document.querySelector('#lose_pitcher').value = updatedGame.lose_pitcher ?? '';
        document.querySelector('#save_pitcher').value = updatedGame.save_pitcher ?? '';
        document.querySelector('#hold_pitcher').value = updatedGame.hold_pitcher ?? '';
        document.querySelector(
            'input[name="game_status"][value="' + updatedGame.game_status + '"]'
        ).checked = true;
        document.querySelector(
            'input[name="winner"][value="' + updatedGame.winner + '"]'
        ).checked = true;

        alert('경기 정보가 수정되었습니다.');
    });
});
</script>
<!-- 게임결과추가 script -->
<script>
	function resetResultListIndex() {
		const rows = document.querySelectorAll('.result-line');
	
		rows.forEach((row, index) => {
			row.querySelectorAll('input, select, textarea').forEach(el => {
				if (!el.name) {
					return;
				}
	
				el.name = el.name.replace(
					/resultList\[[^\]]*\]/,
					'resultList[' + index + ']'
				);
			});
		});
	}
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
			resetResultListIndex();
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
			resetResultListIndex();
		}
	})

	document.querySelector('#gameResultForm').addEventListener('submit', function () {
	resetResultListIndex();

	console.log('submit 직전 name 확인');
	document.querySelectorAll('.result-line input, .result-line select, .result-line textarea')
		.forEach(el => console.log(el.name));
	});
</script>

</body>
</html>