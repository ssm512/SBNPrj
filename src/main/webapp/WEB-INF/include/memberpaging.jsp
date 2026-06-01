<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="startnum"         value="${searchDto.pagination.startPage }" />
<c:set  var="endnum"          value="${searchDto.pagination.endPage }" />
<c:set  var="totalpagecount"  value="${searchDto.pagination.totalPageCount }" />

<div id="paging">

  <!-- 처음 / 이전 -->
	<c:if test="${startnum gt 1 }">
		<a href="/Member/List?nowpage=1&searchType=${map.searchType}&keyword=${map.keyword}">처음</a>
		<a href="/Member/List?nowpage=${startnum-1}&searchType=${map.searchType}&keyword=${map.keyword}">이전</a>
	</c:if>
	    
  <c:forEach var="pagenum" begin="${startnum}" end="${endnum}" step="1">
    <c:if test="${pagenum le totalpagecount }">
      <a href="/Member/List?nowpage=${pagenum}&searchType=${map.searchType}&keyword=${map.keyword}" class="${pagenum eq map.nowpage ? 'active' : ''}">
        ${pagenum}
      </a>
    </c:if>
  </c:forEach>
	    
 <!-- 다음/마지막 --> 
	<c:if test="${ endnum lt totalpagecount }">
		<a href="/Member/List?nowpage=${endnum+1}&searchType=${map.searchType}&keyword=${map.keyword}"> 다음 </a>
		<a href="/Member/List?nowpage=${totalpagecount}&searchType=${map.searchType}&keyword=${map.keyword}"> 마지막 </a>
	</c:if>
	 
</div>

