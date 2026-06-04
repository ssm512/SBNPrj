<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리그경기결과수정</title>
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
        
        display: flex;
    		flex-direction: column;
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
        pointer-events : none;
    }
    
		.main-wrapper {
		    position: relative;
		    z-index: 1;
		}

    .footer {
        position: relative;
    		z-index: 2;
    }
    
		#displaydiv, #buttondiv {
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
		
		#gameresultdisplay {
				td:nth-of-type(1) {width:80px;}
				td:nth-of-type(3) {width:80px;}
				td:nth-of-type(8) {width:100px;}
				td:nth-of-type(9) {width:80px;}
		}
		
		input, select, textarea {
		    width: 100%;
		    height: 34px;
		
		    border: 1px solid #dde2ea;
		    border-radius: 6px;
		
		    padding: 0 8px;
		    box-sizing: border-box;
		}
		
		button, input[type="button"], input[type="submit"] {
		    min-width: 80px;
		    height: 36px;
		
		    background-color: #FFD700;
		    color: #1a3d1a;
		
		    border: none;
		    border-radius: 6px;
		
		    font-weight: 700;
		    cursor: pointer;
		}
		
		#buttondiv {
		    text-align: center;
		    
		}
		
		#btn-cell {
    display: flex;
    justify-content: center;
    gap: 5px;
    border: none;
		} 
		
		#btn-cell button {
    width: auto;
    min-width: 60px;
		}
		
		#paging {
    margin-top: 20px;
		}
		
		#paging table {
		    margin: 0 auto;
		    width: auto;
		}
		
		#paging td {
		    background-color: #1a3d1a;
		    padding: 8px 12px;
		}
		
		#paging a {
		    color: white;
		    text-decoration: none;
		    font-weight: 700;
		}
		
		#paging a.active {
		    color: #FFD700;
		}
</style>
</head>
<body>
<%@include file="/WEB-INF/include/headermenu.jsp" %>
<div class="content-area">
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
			    <td id="btn-cell">
			        <button type="button" id="updatebtn" onclick="updateRow(this)">수정</button>
			        <button type="button" id="deletebtn" onclick="deleteRow(this)">삭제</button>
			    </td>
			</tr>
			</c:forEach>
		</table>
		<%@include file="/WEB-INF/include/gamepaging.jsp" %>
		</div>
		<div id="buttondiv">	
		<button type="button" style="width:auto;" onclick="updateAll(this)">일괄수정</button>
		<input type="button" style="width:auto;" value="경기정보" onclick ="window.location.href='/Game/GameInfo?league_idx=${league_idx}&game_idx=${game_idx}'">
		</div>
	</form>
	
</div>
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