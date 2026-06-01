<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<%-- 페이징 변수 세팅 --%>
<c:set var="startnum"       value="${searchDto.pagination.startPage}" />
<c:set var="endnum"         value="${searchDto.pagination.endPage}" />
<c:set var="totalpagecount" value="${searchDto.pagination.totalPageCount}" />

<div id="paging">
    <table>
      <tr>

        <%-- 처음 / 이전 버튼: 첫 번째 페이지 구간이 아닐 때만 출력 --%>
        <c:if test="${startnum gt 1}">
          <td><a href="/Team/List?nowpage=1&keyword=${map.keyword}">처음</a></td>
          <td><a href="/Team/List?nowpage=${startnum-1}&keyword=${map.keyword}">이전</a></td>
        </c:if>

        <%-- 페이지 번호 목록 출력 (총 페이지 수 초과 번호는 제외) --%>
        <c:forEach var="pagenum" begin="${startnum}" end="${endnum}" step="1">
          <c:if test="${pagenum le totalpagecount}">
            <td>
              <%-- 현재 페이지에 active 클래스 적용 --%>
              <a href="/Team/List?nowpage=${pagenum}&keyword=${map.keyword}"
                 class="${pagenum eq map.nowpage ? 'active' : ''}">
                ${pagenum}
              </a>
            </td>
          </c:if>
        </c:forEach>

        <%-- 다음 / 마지막 버튼 : 마지막 페이지 구간이 아닐 때만 출력 --%>
        <c:if test="${endnum lt totalpagecount}">
          <td><a href="/Team/List?nowpage=${endnum+1}&keyword=${map.keyword}">다음</a></td>
          <td><a href="/Team/List?nowpage=${totalpagecount}&keyword=${map.keyword}">마지막</a></td>
        </c:if>

      </tr>
    </table>
</div>