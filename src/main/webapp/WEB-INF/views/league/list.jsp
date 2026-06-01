<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>League List</title>

<link rel="shortcut icon" href="/img/favicon.png" type="image/x-icon" />
<link href="/css/common.css" rel="stylesheet" />

<style>

  table {
    width:90%;
    margin: 0 auto;
  }
</style>
</head>
<body>
  <%@include file="/WEB-INF/include/headermenu.jsp" %>

  <div class="main-wrapper">
  
    <form action="/League/List" method="get">
    <input type="hidden" name="nowpage" value="${map.nowpage}" />
    
    <div id="search">
      <select name="searchType">
        <option value="league_name" ${ map.searchType == 'league_name' ? 'selected' : '' }>리그 이름</option>
        <option value="league_location" ${ map.searchType == 'league_location' ? 'selected' : '' }>연고지</option>
      </select>
      <input type="text" name="keyword" value="${ map.keyword }" />
      <input type="submit" value="검색" />
    </div>
    
    </form>
    
    <div>${league.league_name}</div>
  
    <h2>League List</h2>
    <table id="list" class="table table-hover">
      <tr>
        <td>리그 이름</td>
        <td>연고지</td>
        <td>리그 소개 멘트</td>
      </tr>
      
      <c:forEach var="league" items="${leagueList }">
      <tr>
        <td>
        <a href="/League/Info?league_idx=${league.league_idx }">
          ${league.league_name}
        </a>
        </td>
        <td>${league.league_location}</td>
        <td>${league.league_content}</td>
      </tr>
      </c:forEach>
      
    </table>
  
  <%@include file="/WEB-INF/include/leaguepaging.jsp" %>
  
  </div>
  
  <%@include file="/WEB-INF/include/footer.jsp" %> 
  
</body>
</html>
















