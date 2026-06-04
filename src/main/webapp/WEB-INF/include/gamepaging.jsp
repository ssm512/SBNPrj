<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="startnum"        value="${searchDto.pagination.startPage}" />
<c:set var="endnum"          value="${searchDto.pagination.endPage}" />
<c:set var="totalpagecount"  value="${searchDto.pagination.totalPageCount}" />

<div id="paging">
    <table>
        <tr>
            <!-- 처음 / 이전 -->
            <c:if test="${startnum gt 1}">
                <td>
                    <a href="/Game/UpdateResultForm?league_idx=${league_idx}&game_idx=${game_idx}&nowpage=1">처음</a>
                </td>
                <td>
                    <a href="/Game/UpdateResultForm?league_idx=${league_idx}&game_idx=${game_idx}&nowpage=${startnum - 1}">이전</a>
                </td>
            </c:if>

            <!-- inning 번호 -->
            <c:forEach var="pagenum" begin="${startnum}" end="${endnum}" step="1">
                <c:if test="${pagenum le totalpagecount}">
                    <td>
                        <a href="/Game/UpdateResultForm?league_idx=${league_idx}&game_idx=${game_idx}&nowpage=${pagenum}"
                           class="${pagenum eq searchDto.pageNo ? 'active' : ''}">
                            ${pagenum}회
                        </a>
                    </td>
                </c:if>
            </c:forEach>

            <!-- 다음 / 마지막 -->
            <c:if test="${endnum lt totalpagecount}">
                <td>
                    <a href="/Game/UpdateResultForm?league_idx=${league_idx}&game_idx=${game_idx}&nowpage=${endnum + 1}">다음</a>
                </td>
                <td>
                    <a href="/Game/UpdateResultForm?league_idx=${league_idx}&game_idx=${game_idx}&nowpage=${totalpagecount}">마지막</a>
                </td>
            </c:if>
        </tr>
    </table>
</div>