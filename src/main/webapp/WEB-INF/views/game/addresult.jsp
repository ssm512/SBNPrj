<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 경기 결과 입력</title>
<link rel="shortcut icon" href="/img/favicon2.png" type="image/png" />
<link href="/css/common.css" rel="stylesheet" />
<link href="https://webfontworld.github.io/sunn/SCDream.css" rel="stylesheet" />
<style>

    html, body { height: 100%; }

    body {
        background-color: #f5f7fa;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    body::before {
        content: '';
        position: fixed;
        inset: -5%;
        background-image: url('/img/index.png');
        background-size: cover;
        background-position: center 60%;
        filter: blur(10px) brightness(0.85);
        z-index: -1;
    }

    .page-wrapper {
        flex: 1;
        padding: 84px 32px 48px;
    }

    .footer { margin-top: 0 !important; }

    /* ===== 섹션 헤더 ===== */
    .section-header {
        background-color: #1a3d1a;
        color: #FFD700;
        padding: 10px 20px;
        font-family: 'S-Core Dream', sans-serif;
        font-size: 24px;
        font-weight: 700;
        letter-spacing: 3px;
        margin: 0 auto 16px;
        border-radius: 3px;
        max-width: 1160px;
        position: relative;
        overflow: hidden;
    }

    .section-header::after {
        content: '';
        position: absolute;
        top: -20px; right: -10px;
        width: 100px; height: 100px;
        background: repeating-linear-gradient(
            45deg,
            transparent, transparent 5px,
            rgba(255, 215, 0, 0.12) 5px, rgba(255, 215, 0, 0.12) 10px
        );
        pointer-events: none;
    }

    /* ===== 메인 래퍼 ===== */
    .main-wrapper {
        max-width: 1160px;
        margin: 0 auto;
    }

    /* ===== 카드 ===== */
    .manage-card {
        background: rgba(249, 249, 234, 0.93);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 24px 28px;
        margin-bottom: 16px;
    }

    /* ===== 테이블 ===== */
    table {
        width: 100%;
        border-collapse: collapse;
        border: none !important;
    }

    td {
        border: none !important;
        border-bottom: 1px solid #e0dcc8 !important;
        padding: 10px 8px !important;
        text-align: center;
        font-size: 14px;
    }

    /* 헤더 행 */
    tr:first-child td {
        font-family: 'S-Core Dream', sans-serif;
        font-size: 14px !important;
        font-weight: 600 !important;
        color: #1a3d1a !important;
        letter-spacing: 1px;
        background: rgba(26, 61, 26, 0.08) !important;
        border-bottom: 2px solid #1a3d1a !important;
        padding: 10px 8px 12px !important;
    }

    /* ===== 입력 요소 ===== */
    input, select, textarea {
        width: 100%;
        height: 32px;
        border: 1px solid #c8c4aa;
        border-radius: 3px;
        padding: 0 6px;
        box-sizing: border-box;
        font-size: 13px;
        font-family: 'S-Core Dream', sans-serif;
        background: #fff;
        outline: none;
        transition: border-color 0.15s;
    }

    input:focus, select:focus, textarea:focus {
        border-color: #1a3d1a;
    }

    input[type="radio"] {
        width: auto;
        height: auto;
        transform: scale(0.9);
        margin-right: 3px;
        border: none;
        outline: none;
    }

    textarea {
        height: auto;
        padding: 4px 6px;
        resize: none;
    }

    /* 경기정보 테이블 라벨 셀 */
    #gamestat td:first-child,
    #gamestat td:last-child {
        background: rgba(26, 61, 26, 0.04);
        font-size: 13px;
    }

    /* ===== 버튼 ===== */
    input[type="submit"], input[type="button"], button {
        background-color: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 3px;
        font-family: 'S-Core Dream', sans-serif;
        font-size: 13px;
        font-weight: 700;
        letter-spacing: 0.5px;
        cursor: pointer;
        width: 120px;
        height: 34px;
        transition: background 0.15s;
    }

    input[type="submit"]:hover,
    input[type="button"]:hover,
    button:hover {
        background-color: #e6c200;
    }

    /* 행 추가/삭제 버튼 */
    .btn-row-add, .btn-row-remove {
        width: auto !important;
        min-width: 54px;
        padding: 0 8px;
    }

    /* 하단 버튼 영역 */
    .btn-area {
        text-align: center;
        padding-top: 4px;
        display: flex;
        justify-content: center;
        gap: 8px;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">

        <div class="section-header">경기 결과 입력</div>

        <div class="main-wrapper">

            <%-- 경기 정보 수정 --%>
            <div class="manage-card">
                <form id="gamestatForm">
                    <input type="hidden" id="game_idx"    value="${gameDto.game_idx}">
                    <input type="hidden" name="league_idx" value="${gameDto.league_idx}">
                    <table id="gamestat">
                        <tr>
                            <td>경기번호 : ${gameDto.game_idx}</td>
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
                                <span style="display:inline-block; width:90px;">
                                    <input type="radio" name="game_status" id="statusbeforegame" value="0"
                                           ${gameDto.game_status == '0' ? 'checked' : ''} />
                                    <label for="statusbeforegame">경기미진행</label>
                                </span>
                                <span style="display:inline-block; width:80px;">
                                    <input type="radio" name="game_status" id="endgame" value="1"
                                           ${gameDto.game_status == '1' ? 'checked' : ''} />
                                    <label for="endgame">경기종료</label>
                                </span>
                                <span style="display:inline-block; width:70px;">
                                    <input type="radio" name="game_status" id="ingame" value="2"
                                           ${gameDto.game_status == '2' ? 'checked' : ''} />
                                    <label for="ingame">경기중</label>
                                </span>
                                <span style="display:inline-block; width:80px;">
                                    <input type="radio" name="game_status" id="rainstop" value="3"
                                           ${gameDto.game_status == '3' ? 'checked' : ''} />
                                    <label for="rainstop">우천취소</label>
                                </span>
                            </td>
                            <td>경기장 : ${gameDto.game_field}</td>
                        </tr>
                        <tr>
                            <td>승리투수 : <input type="text" id="win_pitcher"  name="win_pitcher"  value="${gameDto.win_pitcher}"></td>
                            <td>
                                승자여부 :
                                <span style="display:inline-block; width:60px;">
                                    <input type="radio" name="winner" id="beforegame" value="0"
                                           ${gameDto.winner == '0' ? 'checked' : ''} />
                                    <label for="beforegame">미정</label>
                                </span>
                                <span style="display:inline-block; width:80px;">
                                    <input type="radio" name="winner" id="awaywin" value="1"
                                           ${gameDto.winner == '1' ? 'checked' : ''} />
                                    <label for="awaywin">원정승</label>
                                </span>
                                <span style="display:inline-block; width:70px;">
                                    <input type="radio" name="winner" id="homewin" value="2"
                                           ${gameDto.winner == '2' ? 'checked' : ''} />
                                    <label for="homewin">홈승</label>
                                </span>
                                <span style="display:inline-block; width:80px;">
                                    <input type="radio" name="winner" id="draw" value="3"
                                           ${gameDto.winner == '3' ? 'checked' : ''} />
                                    <label for="draw">무승부</label>
                                </span>
                            </td>
                            <td>패전투수 : <input type="text" id="lose_pitcher" name="lose_pitcher" value="${gameDto.lose_pitcher}"></td>
                        </tr>
                        <tr>
                            <td>세이브투수 : <input type="text" id="save_pitcher" name="save_pitcher" value="${gameDto.save_pitcher}"></td>
                            <td><input type="button" id="btnGameStatUpdate" value="경기정보 수정" style="width:auto; min-width:100px;"></td>
                            <td>홀드 투수 : <input type="text" id="hold_pitcher" name="hold_pitcher" value="${gameDto.hold_pitcher}"></td>
                        </tr>
                    </table>
                </form>
            </div>

            <%-- 경기 결과 입력 --%>
            <div class="manage-card">
                <form id="gameResultForm" action="/Game/AddResult" method="post">
                    <input type="hidden" name="game_idx"    value="${gameDto.game_idx}">
                    <input type="hidden" name="league_idx"  value="${gameDto.league_idx}">
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
                            <td><input type="number" name="resultList[0].inning"      value="0" /></td>
                            <td>
                                <select name="resultList[0].top_bottom">
                                    <option>T</option>
                                    <option>B</option>
                                </select>
                            </td>
                            <td><input type="number" name="resultList[0].hitter_num"  value="0" /></td>
                            <td><input type="text"   name="resultList[0].hitter_name" maxlength="50" /></td>
                            <td><input type="text"   name="resultList[0].hitter_id"   maxlength="100" /></td>
                            <td><input type="text"   name="resultList[0].pitcher_name" maxlength="50" /></td>
                            <td><input type="text"   name="resultList[0].pitcher_id"  maxlength="100" /></td>
                            <td>
                                <select name="resultList[0].result">
                                    <option>1B</option><option>2B</option><option>3B</option>
                                    <option>HR</option><option>K</option><option>BB</option>
                                    <option>SAC</option><option>OUT</option><option>ETC</option>
                                </select>
                            </td>
                            <td><input type="number" name="resultList[0].get_score" min="-4" max="4" value="0" /></td>
                            <td><input type="number" name="resultList[0].era"       min="-4" max="4" value="0" /></td>
                            <td><textarea rows="1" maxlength="2000" name="resultList[0].content"></textarea></td>
                            <td><input type="button" class="btn-row-add"    value="행추가" /></td>
                            <td><input type="button" class="btn-row-remove" value="행삭제" /></td>
                        </tr>
                    </table>

                    <div class="btn-area" style="margin-top:20px;">
                        <input type="button" id="btnAddResult"  value="경기결과 입력" />
                        <input type="button" value="경기결과 수정"
                               onclick="location.href='/Game/UpdateResultForm?league_idx=${gameDto.league_idx}&game_idx=${gameDto.game_idx}'" />
                        <input type="button" value="경기목록"
                               onclick="location.href='/Game/GameInfo?league_idx=${gameDto.league_idx}&game_idx=${gameDto.game_idx}'" />
                    </div>
                </form>
            </div>

        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

    <%-- 경기 정보 수정 --%>
    <script>
    document.querySelector('#btnGameStatUpdate').addEventListener('click', function () {
        const data = {
            game_idx:    Number(document.querySelector('#game_idx').value),
            game_status: Number(document.querySelector('input[name="game_status"]:checked').value),
            winner:      Number(document.querySelector('input[name="winner"]:checked').value),
            win_pitcher:  document.querySelector('#win_pitcher').value,
            lose_pitcher: document.querySelector('#lose_pitcher').value,
            save_pitcher: document.querySelector('#save_pitcher').value,
            hold_pitcher: document.querySelector('#hold_pitcher').value
        };

        fetch('/Game/UpdateGameStat', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        })
        .then(res => res.json())
        .then(updatedGame => {
            document.querySelector('#win_pitcher').value  = updatedGame.win_pitcher  ?? '';
            document.querySelector('#lose_pitcher').value = updatedGame.lose_pitcher ?? '';
            document.querySelector('#save_pitcher').value = updatedGame.save_pitcher ?? '';
            document.querySelector('#hold_pitcher').value = updatedGame.hold_pitcher ?? '';
            document.querySelector('input[name="game_status"][value="' + updatedGame.game_status + '"]').checked = true;
            document.querySelector('input[name="winner"][value="'      + updatedGame.winner      + '"]').checked = true;
            alert('경기 정보가 수정되었습니다.');
        });
    });
    </script>

    <%-- 바이트 체크 --%>
    <script>
    function getByteSize(str) {
        let byte = 0;
        for (let i = 0; i < str.length; i++) {
            byte += str.charCodeAt(i) > 127 ? 3 : 1;
        }
        return byte;
    }

    function validateResultRows() {
        const rows = document.querySelectorAll('.result-line');
        for (let i = 0; i < rows.length; i++) {
            const row = rows[i];
            const hitterName  = row.querySelector('[name$=".hitter_name"]').value;
            const hitterId    = row.querySelector('[name$=".hitter_id"]').value;
            const pitcherName = row.querySelector('[name$=".pitcher_name"]').value;
            const pitcherId   = row.querySelector('[name$=".pitcher_id"]').value;
            const content     = row.querySelector('[name$=".content"]').value;
            if (getByteSize(hitterName)  > 50)   { alert((i+1) + '번째 행 타자명이 50byte를 초과했습니다.');   return false; }
            if (getByteSize(hitterId)    > 100)  { alert((i+1) + '번째 행 타자ID가 100byte를 초과했습니다.');  return false; }
            if (getByteSize(pitcherName) > 50)   { alert((i+1) + '번째 행 투수명이 50byte를 초과했습니다.');   return false; }
            if (getByteSize(pitcherId)   > 100)  { alert((i+1) + '번째 행 투수ID가 100byte를 초과했습니다.');  return false; }
            if (getByteSize(content)     > 2000) { alert((i+1) + '번째 행 비고란이 2000byte를 초과했습니다.'); return false; }
        }
        return true;
    }
    </script>

    <%-- 행 추가/삭제 + 경기결과 입력 --%>
    <script>
    function resetResultListIndex() {
        document.querySelectorAll('.result-line').forEach((row, index) => {
            row.querySelectorAll('input, select, textarea').forEach(el => {
                if (el.name) {
                    el.name = el.name.replace(/resultList\[[^\]]*\]/, 'resultList[' + index + ']');
                }
            });
        });
    }

    const gameTableEl = document.querySelector('#gameresultinput');
    gameTableEl.addEventListener('click', function (e) {
        if (e.target.classList.contains('btn-row-add')) {
            const currentRow = e.target.closest('tr');
            const newRow = currentRow.cloneNode(true);
            newRow.querySelectorAll('input[type="text"]').forEach(input => { input.value = ''; });
            newRow.querySelectorAll('textarea').forEach(ta => { ta.value = ''; });
            newRow.querySelectorAll('select').forEach(sel => { sel.selectedIndex = 0; });
            gameTableEl.appendChild(newRow);
            resetResultListIndex();
        }
        if (e.target.classList.contains('btn-row-remove')) {
            const rows = document.querySelectorAll('.result-line');
            if (rows.length <= 1) { alert('최소 1개의 행은 필요합니다.'); return; }
            e.target.closest('tr').remove();
            resetResultListIndex();
        }
    });

    document.querySelector('#btnAddResult').addEventListener('click', function () {
        resetResultListIndex();
        if (!validateResultRows()) return;
        document.querySelector('#gameResultForm').submit();
    });
    </script>

</body>
</html>
