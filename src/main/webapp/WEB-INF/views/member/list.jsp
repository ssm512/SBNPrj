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
	
	table {
		width: 90%;
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
				<td>선출여부</td>
				<td>조회</td>
			</tr>
			<c:forEach var="member" items="${ memberList }">
			<tr>
				<td>선수 사진</td>
				<td>${ member.member_name }</td>
				<td>${ member.elite }</td>
				<td><a href="/Member/Stats?member_idx=${ member.member_idx }">조회</a></td>
			</tr>
			</c:forEach>			
		</table>	
	
	<%@include file="/WEB-INF/include/memberpaging.jsp" %>
	
	</div>
	
	
	
	 
	<%@include file="/WEB-INF/include/footer.jsp" %> 
</body>
</html>