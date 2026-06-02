<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 선수 목록</title>

<link rel="shortcut icon" href="/img/favicon.png" type="image/x-icon" />
<link href="/css/common.css" rel="stylesheet" />

<style>

	.main-wrapper {
		margin: 25px auto;
		display: flex;
	}
	
	#left-side {
		flex: 3;
	}
	
	#right-side {
		text-align: center;
		margin-top: 55px;
		flex: 1;
	}
	
	#right-side table {
		width: 90%;
		text-align: center;
		margin: 15px auto;
	}
	
	#left-side table {
		width: 90%;
		text-align: center;
		tr {
			height: 40px;
		}
	}
	
	.members {
		margin: 25px auto;
		a {
			text-decoration: none;
			color: black;
			&:hover {
				color: gray;
				font-style: italic;
			}
		}
	}
	
	form {
		margin-left: 60px;
	}
		
	.members tr:first-of-type {
		background-color: #F5F5DC;
	}
	
	#paging {
    text-align: center;
    margin: 15px auto;
	}

	#paging a {
    display: inline-block;
    padding: 6px 12px;
    margin: 0 3px;
    border: 1px solid #ccc;
    border-radius: 4px;
    text-decoration: none;
    color: #333;
	}

	#paging a:hover {
    background-color: #D9D9D9;
	}

	#paging a.active {
    background-color: #006500;
    color: white;
    border-color: #006500;
	}
	
	
</style>

</head>
<body>
	<%@include file="/WEB-INF/include/headermenu.jsp" %>
	
	<div class="main-wrapper">
	<div id="left-side">
	  <form action="/Member/List" method="get">
	  <input type="hidden" name="nowpage" value="1" />	  
	  <div id="search">
	    <select name="searchType">   
	      <option value="member_name" ${ map.searchType == 'member_name' ? 'selected' : '' }>선수명</option>     <!-- searchType=title -->
	      <option value="team_name"  ${ map.searchType == 'team_name'   ? 'selected' : '' }>소속 팀 이름</option> 
	    </select>
	    <input type="text" name="keyword"  value="${ map.keyword }"/>
	    <input type="submit" value="검색" />	    
	  </div>
	  </form>
	  		
		<table class="members">
			<tr>
				<td>이미지</td>
				<td>선수 이름</td>
				<td>가입 팀</td>
				<td>선출여부</td>
				<td>조회</td>
			</tr>
			<c:forEach var="member" items="${ memberList }">
			<tr>
				<td>선수 사진</td>
				<td>${ member.member_name }</td>
				<td>${ member.join_team_name }
					<c:if test="${ member.join_team_count eq 0 }" >
						<span style="color:gray;">소속된 팀이 없습니다.</span>
					</c:if>
					<c:if test="${ member.join_team_count gt 1 }" >
						<b>외 ${ member.join_team_count - 1 }팀</b>
					</c:if>
				</td>
				<td>${ member.elite }</td>
				<td><a href="/Member/Stats?member_idx=${ member.member_idx }">조회</a></td>
			</tr>
			</c:forEach>			
		</table>	
	
	<%@include file="/WEB-INF/include/memberpaging.jsp" %>
	</div> <!-- #left-side -->
	<div id="right-side">
		<h3>SBN 명예의 전당</h3>
		<!-- 타자/투수 전환 버튼 -->
		<div>
		    <input type="button" id="hitRankerBtn"   value="타자" class="active"/>
		    <input type="button" id="pitchRankerBtn" value="투수"/>
		</div>

		<!-- 타자 랭킹 -->
		<div id="hitRankerArea">
	    <div>
        <input type="button" class="hit-item-btn active" data-target="avgArea"      value="타율"/>
        <input type="button" class="hit-item-btn"        data-target="homeRunArea"  value="홈런"/>
        <input type="button" class="hit-item-btn"        data-target="getScoreArea" value="타점"/>
        <input type="button" class="hit-item-btn"        data-target="hitArea"      value="안타"/>
	    </div>
	    <div id="avgArea">
        <table>
           <tr><td colspan="3">타율 TOP 5</td></tr>
           <c:forEach var="m" items="${rankerList.avgRanker}" varStatus="vs">
	           <tr>
		           <td>${vs.index + 1}위</td>
		           <td>${m.member_name}</td>
		           <td>${m.hitstats.avg}</td>
	           </tr>
           </c:forEach>
        </table>
    	</div>
    	<div id="homeRunArea" style="display:none;">
        <table>
	        <tr><td colspan="3">홈런 TOP 5</td></tr>
	        <c:forEach var="m" items="${rankerList.homeRunRanker}" varStatus="vs">
	          <tr>
	            <td>${vs.index + 1}위</td>
	            <td>${m.member_name}</td>
	            <td>${m.hitstats.homeRun}</td>
	          </tr>
	        </c:forEach>
        </table>
    	</div>
    	<div id="getScoreArea" style="display:none;">
	      <table>
          <tr><td colspan="3">타점 TOP 5</td></tr>
          <c:forEach var="m" items="${rankerList.getScoreRanker}" varStatus="vs">
	          <tr>
	            <td>${vs.index + 1}위</td>
	            <td>${m.member_name}</td>
	            <td>${m.hitstats.getScore}</td>
	          </tr>
          </c:forEach>
	      </table>
    	</div>
   	  <div id="hitArea" style="display:none;">
				<table>
			    <tr><td colspan="3">안타 TOP 5</td></tr>
			    <c:forEach var="m" items="${rankerList.hitRanker}" varStatus="vs">
			      <tr>
		          <td>${vs.index + 1}위</td>
		          <td>${m.member_name}</td>
		          <td>${m.hitstats.totalHit}</td>
			      </tr>
					</c:forEach>
				</table>
	    </div>
		</div> <!-- 타자 랭킹 End -->
    
		<!-- 투수 랭킹 -->
		<div id="pitchRankerArea" style="display:none;">
	    <div>
	      <input type="button" class="pitch-item-btn active" data-target="eraArea"       value="방어율"/>
	      <input type="button" class="pitch-item-btn"        data-target="winArea"       value="승"/>
	      <input type="button" class="pitch-item-btn"        data-target="strikeOutArea" value="탈삼진"/>
	      <input type="button" class="pitch-item-btn"        data-target="inningArea"    value="이닝"/>
	    </div>
	    <div id="eraArea">
	      <table>
	        <tr><td colspan="3">방어율 TOP 5</td></tr>
	        <c:forEach var="m" items="${rankerList.eraRanker}" varStatus="vs">
	          <tr>
	            <td>${vs.index + 1}위</td>
	            <td>${m.member_name}</td>
	            <td>${m.pitchstats.era}</td>
	          </tr>
	        </c:forEach>
	      </table>
	    </div>
	    <div id="winArea" style="display:none;">
	      <table>
	        <tr><td colspan="3">승리 TOP 5</td></tr>
	        <c:forEach var="m" items="${rankerList.winRanker}" varStatus="vs">
	          <tr>
	            <td>${vs.index + 1}위</td>
	            <td>${m.member_name}</td>
	            <td>${m.pitchstats.win}</td>
	          </tr>
	        </c:forEach>
	      </table>
	    </div>
	    <div id="strikeOutArea" style="display:none;">
	      <table>
	        <tr><td colspan="3">탈삼진 TOP 5</td></tr>
	        <c:forEach var="m" items="${rankerList.strikeOutRanker}" varStatus="vs">
	          <tr>
	            <td>${vs.index + 1}위</td>
	            <td>${m.member_name}</td>
	            <td>${m.pitchstats.strikeOut}</td>
	          </tr>
	        </c:forEach>
	      </table>
	    </div>
	    <div id="inningArea" style="display:none;">
	      <table>
	        <tr><td colspan="3">이닝 TOP 5</td></tr>
	        <c:forEach var="m" items="${rankerList.inningRanker}" varStatus="vs">
	          <tr>
	            <td>${vs.index + 1}위</td>
	            <td>${m.member_name}</td>
	            <td>${m.pitchstats.inning}</td>
	          </tr>
	        </c:forEach>
	      </table>
	    </div>
		</div> <!-- 투수 랭킹 End  -->
		
	</div> <!-- #right-side -->
	</div> <!-- .main-wrapper  -->
	
	
	
	 
	<%@include file="/WEB-INF/include/footer.jsp" %> 
	
	
	
	<script>
	
	// 타자/투수 전환
	const hitRankerBtnEl    = document.querySelector('#hitRankerBtn')
	const pitchRankerBtnEl  = document.querySelector('#pitchRankerBtn')
	const hitRankerAreaEl   = document.querySelector('#hitRankerArea')
	const pitchRankerAreaEl = document.querySelector('#pitchRankerArea')

	hitRankerBtnEl.classList.add('active')

	hitRankerBtnEl.addEventListener('click', function() {
    hitRankerAreaEl.style.display   = 'block'
    pitchRankerAreaEl.style.display = 'none'
    hitRankerBtnEl.classList.add('active')
    pitchRankerBtnEl.classList.remove('active')
	})

	pitchRankerBtnEl.addEventListener('click', function() {
    hitRankerAreaEl.style.display   = 'none'
    pitchRankerAreaEl.style.display = 'block'
    pitchRankerBtnEl.classList.add('active')
    hitRankerBtnEl.classList.remove('active')
	})

	// 타자 항목 전환
	document.querySelectorAll('.hit-item-btn').forEach(btn => {
    btn.addEventListener('click', function() {
       document.querySelectorAll('#hitRankerArea > div[id]').forEach(area => {
	       area.style.display = 'none'
       })
       document.querySelector('#' + this.getAttribute('data-target')).style.display = 'block'
       document.querySelectorAll('.hit-item-btn').forEach(b => b.classList.remove('active'))
       this.classList.add('active')
    })
	})

	// 투수 항목 전환
	document.querySelectorAll('.pitch-item-btn').forEach(btn => {
    btn.addEventListener('click', function() {
	    document.querySelectorAll('#pitchRankerArea > div[id]').forEach(area => {
	      area.style.display = 'none'
	    })
	    document.querySelector('#' + this.getAttribute('data-target')).style.display = 'block'
	    document.querySelectorAll('.pitch-item-btn').forEach(b => b.classList.remove('active'))
	    this.classList.add('active')
    })
	})
	
	
	
	</script>
	
	
</body>
</html>