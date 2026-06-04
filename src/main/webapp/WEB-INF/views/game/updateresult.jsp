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
	<input type="hidden" name="game_idx" value="${game_idx}">
	<input type="hidden" name="league_idx" value="${league_idx}">
	<div id="displaydiv">
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
			    <td><input class="inning" type="number" value="${record.inning}" /></td>
			
			    <td>
			        <select class="top_bottom">
			            <option value="T" ${record.top_bottom == 'T' ? 'selected' : ''}>T</option>
			            <option value="B" ${record.top_bottom == 'B' ? 'selected' : ''}>B</option>
			        </select>
			    </td>
			
			    <td><input class="hitter_num" type="number" value="${record.hitter_num}" /></td>
			    <td><input class="hitter_name" type="text" value="${record.hitter_name}" /></td>
			    <td><input class="hitter_id" type="text" value="${record.hitter_id}" /></td>
			    <td><input class="pitcher_name" type="text" value="${record.pitcher_name}" /></td>
			    <td><input class="pitcher_id" type="text" value="${record.pitcher_id}" /></td>
			
			    <td>
			        <select class="result">
			            <option value="1B" ${record.result == '1B' ? 'selected' : ''}>1B</option>
			            <option value="2B" ${record.result == '2B' ? 'selected' : ''}>2B</option>
			            <option value="3B" ${record.result == '3B' ? 'selected' : ''}>3B</option>
			            <option value="HR" ${record.result == 'HR' ? 'selected' : ''}>HR</option>
			            <option value="K" ${record.result == 'K' ? 'selected' : ''}>K</option>
			            <option value="BB" ${record.result == 'BB' ? 'selected' : ''}>BB</option>
			            <option value="SAC" ${record.result == 'SAC' ? 'selected' : ''}>SAC</option>
			            <option value="OUT" ${record.result == 'OUT' ? 'selected' : ''}>OUT</option>
			            <option value="ETC" ${record.result == 'ETC' ? 'selected' : ''}>ETC</option>
			        </select>
			    </td>
			
			    <td><input class="get_score" type="number" min="-4" max="4" value="${record.get_score}" /></td>
			    <td><input class="era" type="number" min="-4" max="4" value="${record.era}" /></td>
			    <td><textarea class="content" rows="1" cols="10" maxlength="2000">${record.content}</textarea></td>
			
			    <td>
			        <button type="button" onclick="updateRow(this)">수정</button>
			        <button type="button" onclick="deleteRow(this)">삭제</button>
			    </td>
			</tr>
			</c:forEach>
		</table>
		</div>
		<div id="buttondiv">	
		<button type="button" onclick="updateAll(this)">일괄수정</button>
		<input type="button" value="경기정보" onclick ="window.location.href='/Game/GameInfo?league_idx=${league_idx}&game_idx=${game_idx}'">
		</div>
	</form>
	
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<!-- 개별수정버튼 -->
<script>
function updateRow(btn) {

    const tr = btn.closest(".result-line");

    const data = {
    	    record_num: Number(tr.dataset.recordNum),
    	    game_idx: Number(document.querySelector("[name='game_idx']").value),
    	    league_idx: Number(document.querySelector("[name='league_idx']").value),

    	    inning: Number(tr.querySelector(".inning").value),
    	    top_bottom: tr.querySelector(".top_bottom").value,
    	    hitter_num: Number(tr.querySelector(".hitter_num").value),

    	    hitter_name: tr.querySelector(".hitter_name").value,
    	    hitter_id: tr.querySelector(".hitter_id").value,
    	    pitcher_name: tr.querySelector(".pitcher_name").value,
    	    pitcher_id: tr.querySelector(".pitcher_id").value,

    	    result: tr.querySelector(".result").value,
    	    get_score: Number(tr.querySelector(".get_score").value || 0),
    	    era: Number(tr.querySelector(".era").value || 0),
    	    content: tr.querySelector(".content").value
    };

    fetch("/Game/UpdateResultAjax", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(data)
    })
    .then(res => res.text())
    .then(result => {
        if (result === "OK") {
            alert("수정 완료");
        } else {
            alert("수정 실패");
        }
    });
}
</script>

<!-- 삭제버튼 -->
<script>
function deleteRow(btn) {
    const tr = btn.closest(".result-line");
    console.log("tr:", tr);
    console.log("record_num:", tr.dataset.recordNum);
    const record_num = Number(tr.dataset.recordNum);
    const isDelete = confirm("삭제하시겠습니까?");
    if(!isDelete){
        return;
    }

    fetch("/Game/DeleteResultAjax", {
        method : "POST",
        headers : {
            "Content-Type" : "application/json"
        },
        body : JSON.stringify({
            record_num : record_num
        })
    })
    .then(res => res.text())
    .then(result => {
        if(result === "OK"){
            alert("삭제 완료");
            // 화면에서 해당 행 제거
            tr.remove();
        } else {
            alert("삭제 실패");
        }
    })
    .catch(err => {
        console.error(err);
        alert("오류 발생");
    });
}
</script>
<!-- 일괄수정 버튼 -->
<script>
let changedRows = new Set();

// input, select, textarea 변경 감지
document.querySelectorAll(".result-line input, .result-line select, .result-line textarea")
    .forEach(el => {
        el.addEventListener("change", function() {
            const tr = this.closest(".result-line");
            if(tr != null){
                changedRows.add(tr.dataset.recordNum);
                tr.style.backgroundColor = "#D9D9D9";
            }
        });
    });

function makeRowData(tr) {
    return {
        record_num: Number(tr.dataset.recordNum),
        game_idx: Number(document.querySelector("[name='game_idx']").value),
        league_idx: Number(document.querySelector("[name='league_idx']").value),

        inning: Number(tr.querySelector(".inning").value),
        top_bottom: tr.querySelector(".top_bottom").value,
        hitter_num: Number(tr.querySelector(".hitter_num").value),

        hitter_name: tr.querySelector(".hitter_name").value,
        hitter_id: tr.querySelector(".hitter_id").value,
        pitcher_name: tr.querySelector(".pitcher_name").value,
        pitcher_id: tr.querySelector(".pitcher_id").value,

        result: tr.querySelector(".result").value,
        get_score: Number(tr.querySelector(".get_score").value || 0),
        era: Number(tr.querySelector(".era").value || 0),
        content: tr.querySelector(".content").value
    };
}

function updateAll() {
    if(changedRows.size === 0){
        alert("변경된 기록이 없습니다.");
        return;
    }
    const resultList = [];
    changedRows.forEach(recordNum => {
        const tr =
            document.querySelector(".result-line[data-record-num='" + recordNum + "']");
        if(tr != null){
            resultList.push(makeRowData(tr));
        }
    });

    fetch("/Game/UpdateResultAllAjax", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(resultList)
    })
    .then(res => res.text())
    .then(result => {
        if(result === "OK"){
            alert("일괄수정 완료");
            changedRows.forEach(recordNum => {
                const tr =
                    document.querySelector(".result-line[data-record-num='" + recordNum + "']");
                if(tr != null){
                    tr.style.backgroundColor = "";
                }
            });

            changedRows.clear();

        } else {
            alert("일괄수정 실패");
        }
    })
    .catch(err => {
        console.error(err);
        alert("일괄수정 중 오류 발생");
    });
}
</script>
</body>
</html>