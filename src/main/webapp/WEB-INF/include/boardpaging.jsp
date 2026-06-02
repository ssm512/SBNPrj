<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="startnum"         value="${searchDto.pagination.startPage }" />
<c:set  var="endnum"          value="${searchDto.pagination.endPage }" />
<c:set  var="totalpagecount"  value="${searchDto.pagination.totalPageCount }" />

<div id="paging">
	<table>
	  <tr>
	  <!-- 처음 / 이전 -->
	    <c:if test="${startnum gt 1 }">
	     <td>
	       <a href="/Board/List?nowpage=1&searchType=${map.searchType}&keyword=${map.keyword}&board_type=${map.board_type}">처음</a>
	     </td>
	     <td>  
           <a href="/Board/List?nowpage=${startnum-1}&searchType=${map.searchType}&keyword=${map.keyword}&board_type=${map.board_type}">이전</a>
         </td>
	    </c:if>
	    
	    <c:forEach var="pagenum" begin="${startnum}" end="${endnum}" step="1">
	      <c:if test="${pagenum le totalpagecount }">
	        <td>
	          <a href="/Board/List?nowpage=${pagenum}&searchType=${map.searchType}&keyword=${map.keyword}&board_type=${map.board_type}" class="${pagenum eq map.nowpage ? 'active' : ''}">
	          ${pagenum}
	          </a>
	        </td>
	      </c:if>
	    </c:forEach>
	    
		 <!-- 다음/마지막 --> 
	     <c:if test="${ endnum lt totalpagecount }">
	      <td>
	        <a href="/Board/List?nowpage=${endnum+1}&searchType=${map.searchType}&keyword=${map.keyword}&board_type=${map.board_type}"> 다음 </a>
	      </td>
	      <td>
	        <a href="/Board/List?nowpage=${totalpagecount}&searchType=${map.searchType}&keyword=${map.keyword}&board_type=${map.board_type}"> 마지막 </a>
	      </td>
	     </c:if>
	    
	  </tr>
	</table>
</div>

