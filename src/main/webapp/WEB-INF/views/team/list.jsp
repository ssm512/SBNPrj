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
   .h2 {
   text-align : center;
   }

   table {
      width: 70%;
      margin: 0 auto;   /* 테이블 중앙 정렬 */
   }
   
   td {
      padding    : 5px;
      text-align : center;
   }

	#list {
		td:nth-of-type(1)  {width:150px;}	/* 팀 이름 */	  
		td:nth-of-type(2)  {width:100px;}	/* 감독	   */
		td:nth-of-type(3)  {width:150px;}	/* 리그    */	 
		td:nth-of-type(4)  {width:600px;}   /* 팀 소개 */
}

   tr:first-of-type {
      background-color: #F5F5DC;
      color: black;
      td {
         border: 1px solid white;
      }
   }
   
   #create {
    	text-align : center;
   }
</style>
</head>
<body>
	<main>
	  <h2 class="h2">S B N</h2>
		<table id="list">
		
		  <tr>
			<td>팀 이름</td>
			<td>감독</td>
			<td>리그</td>
			<td>팀 소개</td>
		  </tr>
		  
		
		</table>
		  <tr class="create">
	      <td colspan="4">
	       [<a href="/Team/Maketeam">
	       팀 생성
	       </a>] 
	      </td>
	    </tr>
		
	<div class="main-wraper">
	</div>
	</main>
</body>
</html>