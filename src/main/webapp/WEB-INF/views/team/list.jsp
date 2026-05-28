<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 팀 목록</title>
<link href="/css/common.css" rel="stylesheet" />
<style>

	h2 {
    text-align: center;
	}
	
   table {
      width: 70%;
      margin: 0 auto;
   }

   td {
      padding: 5px;
      text-align: center;
   }

   /* 헤더 행 */
   tr:first-of-type {
      background-color: #F5F5DC;
      color: black;
      td {
         border: 1px solid white;
      }
   }

   /* 팀 목록 컬럼 너비 */
   #list {
      td:nth-of-type(1) { width: 150px; }  /* 팀 이름 */
      td:nth-of-type(2) { width: 100px; }  /* 감독    */
      td:nth-of-type(3) { width: 150px; }  /* 리그    */
      td:nth-of-type(4) { width: 600px; }  /* 팀 소개 */
   }

   #list tr:not(:first-of-type):hover {
      background-color: #D9D9D9;
      cursor: pointer;
   }

</style>
</head>
<body>
 	<%@ include file="/WEB-INF/include/headermenu.jsp" %>
	<div class="">
	  <h2>S B N</h2>
	
	<!-- 검색창 -->
	<div style="width:70%; margin:10px auto; text-align:right;">
    	<form action="/Team/List" method="get" style="display:inline;">
        	<input type="text" name="keyword" value="${keyword}" placeholder="검색(팀 이름 또는 지역)">
        	<button type="submit">검색</button>
    	</form>
	</div>
	  
		<table id="list">
		
		  <tr>
			<td>팀 이름</td>
			<td>감독</td>
			<td>리그</td>
			<td>팀 소개</td>
		  </tr>
	<c:forEach var="team" items="${teamList}">
		  <tr onclick="location.href='/Team/Info?team_idx=${team.team_idx}'" style="cursor:pointer;">
			<td>${team.team_name   }</td>
			<td>${team.manager_name }</td>
			<td>${team.league_name }</td>
			<td>${team.team_content}</td>
		  </tr>
	</c:forEach>
		  
		
	</table>
	<div style="width:70%; margin:5px auto; text-align:right;">
	    <a href="/Team/Maketeam"><button type="button">팀 생성</button></a>
	</div>
		

	</main>
	 
	<%@ include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>