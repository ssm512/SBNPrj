<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 경기 결과 수정</title>
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
        padding: 28px 32px;
        margin-bottom: 12px;
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
        text-align: center !important;
    }

    #gameresultdisplay td:nth-of-type(1) { width: 60px; }
    #gameresultdisplay td:nth-of-type(3) { width: 60px; }
    #gameresultdisplay td:nth-of-type(8) { width: 100px; }
    #gameresultdisplay td:nth-of-type(9) { width: 70px; }

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

    textarea {
        height: auto;
        padding: 4px 6px;
        resize: none;
    }

    /* ===== 버튼 ===== */
    button, input[type="button"], input[type="submit"] {
        min-width: 70px;
        height: 34px;
        background-color: #FFD700;
        color: #1a3d1a;
        border: none;
        border-radius: 3px;
        font-family: 'S-Core Dream', sans-serif;
        font-size: 13px;
        font-weight: 700;
        letter-spacing: 0.5px;
        cursor: pointer;
        transition: background 0.15s;
    }

    button:hover, input[type="button"]:hover, input[type="submit"]:hover {
        background-color: #e6c200;
    }

    /* 하단 버튼 카드 */
    .btn-card {
        background: rgba(249, 249, 234, 0.93);
        border-radius: 4px;
        box-shadow: 0 2px 16px rgba(26, 61, 26, 0.07);
        padding: 16px 32px;
        text-align: center;
    }

    #btn-cell {
        display: flex;
        justify-content: center;
        gap: 5px;
        border: none !important;
    }

    #btn-cell button {
        width: auto;
        min-width: 54px;
    }

    .btn-area {
        display: flex;
        justify-content: center;
        gap: 8px;
    }

    .btn-area button,
    .btn-area input[type="button"] {
        width: auto;
        min-width: 80px;
    }

    /* ===== 페이징 ===== */
    #paging {
        margin-top: 24px;
        text-align: center;
    }

    #paging table {
        border: none !important;
        margin: 0 auto;
        box-shadow: none;
        width: auto !important;
    }

    #paging td {
        border: none !important;
        padding: 0 2px !important;
        background: none !important;
    }

    #paging a {
        display: inline-block;
        padding: 6px 13px;
        color: #1a3d1a;
        text-decoration: none;
        border-radius: 3px;
        font-size: 14px;
        font-family: 'S-Core Dream', sans-serif;
        border: 1px solid #c8c4aa;
        background: rgba(255, 255, 255, 0.7);
        transition: all 0.15s;
    }

    #paging a:hover {
        background: #1a3d1a;
        color: #ffffff;
        border-color: #1a3d1a;
    }

    #paging a.active {
        background: #FFD700;
        color: #1a3d1a;
        font-weight: 700;
        border-color: #FFD700;
    }

</style>
</head>
<body>
    <%@ include file="/WEB-INF/include/headermenu.jsp" %>

    <div class="page-wrapper">

        <div class="section-header">경기 결과 수정</div>

        <div class="main-wrapper">
            <form id="gameUpdateForm" action="/Game/UpdateResult" method="post">
                <input type="hidden" name="game_idx"    value="${game_idx}">
                <input type="hidden" name="league_idx"  value="${league_idx}">

                <div class="manage-card">
                    <table id="gameresultdisplay">
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
                            <td>BTN</td>
                        </tr>
                        <c:forEach var="record" items="${resultList}">
                            <input type="hidden" class="league_idx" value="${league_idx}">
                            <tr class="result-line" data-record-num="${record.record_num}">
                                <td><input class="inning"       type="number" value="${record.inning}" /></td>
                                <td>
                                    <select class="top_bottom">
                                        <option value="T" ${record.top_bottom == 'T' ? 'selected' : ''}>T</option>
                                        <option value="B" ${record.top_bottom == 'B' ? 'selected' : ''}>B</option>
                                    </select>
                                </td>
                                <td><input class="hitter_num"   type="number" value="${record.hitter_num}" /></td>
                                <td><input class="hitter_name"  type="text"   value="${record.hitter_name}" /></td>
                                <td><input class="hitter_id"    type="text"   value="${record.hitter_id}" /></td>
                                <td><input class="pitcher_name" type="text"   value="${record.pitcher_name}" /></td>
                                <td><input class="pitcher_id"   type="text"   value="${record.pitcher_id}" /></td>
                                <td>
                                    <select class="result">
                                        <option value="1B"  ${record.result == '1B'  ? 'selected' : ''}>1B</option>
                                        <option value="2B"  ${record.result == '2B'  ? 'selected' : ''}>2B</option>
                                        <option value="3B"  ${record.result == '3B'  ? 'selected' : ''}>3B</option>
                                        <option value="HR"  ${record.result == 'HR'  ? 'selected' : ''}>HR</option>
                                        <option value="K"   ${record.result == 'K'   ? 'selected' : ''}>K</option>
                                        <option value="BB"  ${record.result == 'BB'  ? 'selected' : ''}>BB</option>
                                        <option value="SAC" ${record.result == 'SAC' ? 'selected' : ''}>SAC</option>
                                        <option value="OUT" ${record.result == 'OUT' ? 'selected' : ''}>OUT</option>
                                        <option value="ETC" ${record.result == 'ETC' ? 'selected' : ''}>ETC</option>
                                    </select>
                                </td>
                                <td><input class="get_score" type="number" min="-4" max="4" value="${record.get_score}" /></td>
                                <td><input class="era"       type="number" min="-4" max="4" value="${record.era}" /></td>
                                <td><textarea class="content" rows="1" maxlength="2000">${record.content}</textarea></td>
                                <td id="btn-cell">
                                    <button type="button" onclick="updateRow(this)">수정</button>
                                    <button type="button" onclick="deleteRow(this)">삭제</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>

                    <%@ include file="/WEB-INF/include/gamepaging.jsp" %>
                </div>

                <div class="btn-card">
                    <div class="btn-area">
                        <button type="button" onclick="updateAll(this)">일괄수정</button>
                        <input type="button" value="경기정보"
                               onclick="location.href='/Game/GameInfo?league_idx=${league_idx}&game_idx=${game_idx}'">
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="/WEB-INF/include/footer.jsp" %>

    <%-- 개별 수정 --%>
    <script>
    function updateRow(btn) {
        const tr = btn.closest('.result-line');
        const data = {
            record_num:   Number(tr.dataset.recordNum),
            game_idx:     Number(document.querySelector("[name='game_idx']").value),
            league_idx:   Number(document.querySelector("[name='league_idx']").value),
            inning:       Number(tr.querySelector('.inning').value),
            top_bottom:   tr.querySelector('.top_bottom').value,
            hitter_num:   Number(tr.querySelector('.hitter_num').value),
            hitter_name:  tr.querySelector('.hitter_name').value,
            hitter_id:    tr.querySelector('.hitter_id').value,
            pitcher_name: tr.querySelector('.pitcher_name').value,
            pitcher_id:   tr.querySelector('.pitcher_id').value,
            result:       tr.querySelector('.result').value,
            get_score:    Number(tr.querySelector('.get_score').value || 0),
            era:          Number(tr.querySelector('.era').value || 0),
            content:      tr.querySelector('.content').value
        };

        fetch('/Game/UpdateResultAjax', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        })
        .then(res => res.text())
        .then(result => {
            alert(result === 'OK' ? '수정 완료' : '수정 실패');
        });
    }
    </script>

    <%-- 개별 삭제 --%>
    <script>
    function deleteRow(btn) {
        const tr = btn.closest('.result-line');
        const record_num = Number(tr.dataset.recordNum);

        if (!confirm('삭제하시겠습니까?')) return;

        fetch('/Game/DeleteResultAjax', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ record_num })
        })
        .then(res => res.text())
        .then(result => {
            if (result === 'OK') {
                alert('삭제 완료');
                tr.remove();
            } else {
                alert('삭제 실패');
            }
        })
        .catch(err => {
            console.error(err);
            alert('오류 발생');
        });
    }
    </script>

    <%-- 일괄 수정 --%>
    <script>
    let changedRows = new Set();

    document.querySelectorAll('.result-line input, .result-line select, .result-line textarea')
        .forEach(el => {
            el.addEventListener('change', function () {
                const tr = this.closest('.result-line');
                if (tr) {
                    changedRows.add(tr.dataset.recordNum);
                    tr.style.backgroundColor = '#e8f0e8';
                }
            });
        });

    function makeRowData(tr) {
        return {
            record_num:   Number(tr.dataset.recordNum),
            game_idx:     Number(document.querySelector("[name='game_idx']").value),
            league_idx:   Number(document.querySelector("[name='league_idx']").value),
            inning:       Number(tr.querySelector('.inning').value),
            top_bottom:   tr.querySelector('.top_bottom').value,
            hitter_num:   Number(tr.querySelector('.hitter_num').value),
            hitter_name:  tr.querySelector('.hitter_name').value,
            hitter_id:    tr.querySelector('.hitter_id').value,
            pitcher_name: tr.querySelector('.pitcher_name').value,
            pitcher_id:   tr.querySelector('.pitcher_id').value,
            result:       tr.querySelector('.result').value,
            get_score:    Number(tr.querySelector('.get_score').value || 0),
            era:          Number(tr.querySelector('.era').value || 0),
            content:      tr.querySelector('.content').value
        };
    }

    function updateAll() {
        if (changedRows.size === 0) { alert('변경된 기록이 없습니다.'); return; }

        const resultList = [];
        changedRows.forEach(recordNum => {
            const tr = document.querySelector(".result-line[data-record-num='" + recordNum + "']");
            if (tr) resultList.push(makeRowData(tr));
        });

        fetch('/Game/UpdateResultAllAjax', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(resultList)
        })
        .then(res => res.text())
        .then(result => {
            if (result === 'OK') {
                alert('일괄수정 완료');
                changedRows.forEach(recordNum => {
                    const tr = document.querySelector(".result-line[data-record-num='" + recordNum + "']");
                    if (tr) tr.style.backgroundColor = '';
                });
                changedRows.clear();
            } else {
                alert('일괄수정 실패');
            }
        })
        .catch(err => {
            console.error(err);
            alert('일괄수정 중 오류 발생');
        });
    }
    </script>

</body>
</html>
