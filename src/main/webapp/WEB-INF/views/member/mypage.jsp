<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 마이페이지</title>

<link rel="shortcut icon" href="/img/favicon.png" type="image/x-icon" />
<link href="/css/common.css" rel="stylesheet" />

<style>

	.main-wrapper {
		display: grid;
		justify-content: center;
		gap: 20px;
		grid-template-columns: 1fr 3fr;
	}
	
	.member-profile-img {
		background-color: #FFD700;
		text-align: center;
	}
	
	.myteamlist {
		margin-top: 25px;
		width: 100%;
		text-align: center;
		td { padding: 10px; }
	}
	
	.myteamlist tr:first-of-type {
		background: #F5F5DC;
	}
	
	
	.member-profile {
		padding: 15px;
		background: #F5F5DC;
		width: 100%;
	}
	
	.member-profile table {
		margin: 20px auto;
		text-align: center;
		width: 95%;
		td { padding: 10px; }
		td:nth-of-type(odd) {
			width: 70px;
		}
		td:nth-of-type(even) {
			background: white;
		}
	}
	
	
	#updatebtn {
		display: block;
		margin: 40px auto 0;
	}
	
  .myteamlist tr:not(:first-of-type):hover {
  	background-color: #D9D9D9;
  	cursor: pointer;
  }
	
</style>

</head>
<body>
	<%@include file="/WEB-INF/include/headermenu.jsp" %>
	
	<div class="main-wrapper">
		<div>
			<div class="member-profile-img">
				<p>이미지</p>
				<p>${ sessionScope.login.member_name }</p>
				<input type="button" id="mystatsbtn" value="내 전적 조회"  />
			</div>
			<table class="myteamlist">
				<tr>
					<td>소속팀목록</td>
				</tr>
				<c:forEach var="team" items="${ teamList }" >
					<tr onclick='location.href="/Team/Info?team_idx=${ team.team_idx }&keyword="' style="cursor:pointer;">
						<td>${ team.team_name } 
						<b>${ sessionScope.login.member_idx eq team.team_manager ? '[감독]' : '' }</b></td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="member-profile">
			<h3>회원 정보</h3>
			<table>
				<tr>
					<td>아이디</td>
					<td>${ sessionScope.login.member_id }</td>
					<td>주소</td>
					<td>${ sessionScope.login.address }</td>
				</tr>
				<tr>
					<td>생년</td>
					<td>${ sessionScope.login.birth }</td>
					<td>이름</td>
					<td>${ sessionScope.login.member_name }</td>
				</tr>
				<tr>
					<td>연락처</td>
					<td>${ sessionScope.login.phone_num }</td>
					<td>이메일</td>
					<td>${ sessionScope.login.email }</td>
				</tr>
			</table>
			<h3>추가 정보</h3>
			<span>투타 구분 &emsp;&emsp; ${ sessionScope.login.use_hand }</span><br>
			<span>선출 여부 &emsp;&emsp; ${ sessionScope.login.elite }</span><br>
			<span>선호 포지션 &emsp; ${ sessionScope.login.hope_position }</span><br>
			<input type="button" id="updatebtn" value="정보 수정"  />
		</div>
	
	</div>
	
	
	
	 
	<%@include file="/WEB-INF/include/footer.jsp" %> 
	
	
	<script>
	
	// 수정 완료후 alert
	if('${param.updated}' == 'true') {
		alert('수정이 완료되었습니다.')
	}
	
	const updatebtnEl   = document.querySelector('#updatebtn')
	const mystatsbtnEl  = document.querySelector('#mystatsbtn')
	
	updatebtnEl.addEventListener('click', function () {
		location.href = "/Member/UpdateForm"
	})
	
	mystatsbtnEl.addEventListener('click', function () {
		location.href = "/Member/Stats?member_idx=" + ${sessionScope.login.member_idx}
	})
	
	
	</script>
</body>
</html>