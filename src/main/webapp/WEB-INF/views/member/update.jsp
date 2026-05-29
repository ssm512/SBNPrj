<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 정보수정</title>

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
		td:nth-of-type(odd) {
			width: 70px;
			padding: 10px;
		}
		td:nth-of-type(even) {
			background: white;
		}
		td:nth-of-type(2) {
			width: 30%;
		}
		tr:nth-of-type(3)>td {
			padding: 10px 0;
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
  
  input[type="text"], input[type="date"], input[type="email"] {
   	display: block;
  	align-items: flex-start;
  	border: none;
  	width: 90%;
  	height: 35px;
  	margin: 0 auto;
  } 
  
  input[name="phone_num"], input[name="email"] {
  	height: 20px;
  	margin-bottom: 5px;
  }
  
  input[name="hope_position"] {
  	display: inline;
  	width: 70%;
  	height: 20px;
  	margin: 0;
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
					<tr onclick='location.href="/Team/Info?team_idx=${ team.team_idx }"' style="cursor:pointer;">
						<td>${ team.team_name } 
						<b>${ sessionScope.login.member_idx eq team.team_manager ? '[감독]' : '' }</b></td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<div class="member-profile">
			<h3>회원 정보</h3>
			<form action="/Member/Update" method="post" >
				<input type="hidden" name="member_idx" value="${ sessionScope.login.member_idx }" />
				<input type="hidden" name="member_id" value="${ sessionScope.login.member_id }" />
				<table>
					<tr>
						<td>아이디</td>
						<td>${ sessionScope.login.member_id }</td>
						<td>주소</td>
						<td><input type="text"  name="address"  value="${ sessionScope.login.address }"/></td>
					</tr>
					<tr>
						<td>생년</td>
						<td><input type="date"  name="birth"  value="${ sessionScope.login.birth }"/></td>
						<td>이름</td>
						<td><input type="text"  name="member_name"  value="${ sessionScope.login.member_name }" required /></td>
					</tr>
					<tr>
						<td>연락처</td>
						<td><input type="text"  name="phone_num"  value="${ sessionScope.login.phone_num }"/>
						     <input type="button" id="phoneDupCheck" value="중복확인" /></td>
						<td>이메일</td>
						<td><input type="email"  name="email"  value="${ sessionScope.login.email }"/>
						     <input type="button" id="emailDupCheck" value="중복확인" /></td>
					</tr>
				</table>
				<h3>추가 정보</h3>
				<span>투타 구분</span> &emsp;&emsp;
					<input type="radio" name="use_hand" id="right_right" value="우투우타"
					${ sessionScope.login.use_hand == '우투우타' ? 'checked' : '' }/>
					<label for="right_right">우투우타</label> &nbsp;&nbsp;
					<input type="radio" name="use_hand" id="right_left" value="우투좌타"
					${ sessionScope.login.use_hand == '우투좌타' ? 'checked' : '' }/>
					<label for="right_left">우투좌타</label> &nbsp;&nbsp;
					<input type="radio" name="use_hand" id="left_left" value="좌투좌타"
					${ sessionScope.login.use_hand == '좌투좌타' ? 'checked' : '' }/>
					<label for="left_left">좌투좌타</label> &nbsp;&nbsp;
					<input type="radio" name="use_hand" id="left_right" value="좌투우타"
					${ sessionScope.login.use_hand == '좌투우타' ? 'checked' : '' }/>
					<label for="left_right">좌투우타</label> &nbsp;&nbsp;
					<input type="radio" name="use_hand" id="switch" value="스위치"
					${ sessionScope.login.use_hand == '스위치' ? 'checked' : '' }/>
					<label for="switch">스위치</label> <br>
					
				<span>선출 여부</span> &emsp;&emsp;
					<input type="radio" name="elite" id="normal" value="비선출"
					${ sessionScope.login.elite == '비선출' ? 'checked' : '' }/>
					<label for="normal">비선출</label> &nbsp;&nbsp;
					<input type="radio" name="elite" id="middle_school" value="중출"
					${ sessionScope.login.elite == '중출' ? 'checked' : '' }/>
					<label for="middle_school">중출</label> &nbsp;&nbsp;
					<input type="radio" name="elite" id="high_school" value="고출"
					${ sessionScope.login.elite == '고출' ? 'checked' : '' }/>
					<label for="high_school">고출</label> &nbsp;&nbsp;
					<input type="radio" name="elite" id="pro" value="프로"
					${ sessionScope.login.elite == '프로' ? 'checked' : '' }/>
					<label for="pro">프로</label>	<br>
					
				<span>선호 포지션</span> &emsp;
				<input type="text"  name="hope_position"  value="${ sessionScope.login.hope_position }"/>
				<input type="submit"  id="updatebtn" value="수정 완료"  />
			</form>
		</div>
	
	</div>
	
	
	
	 
	<%@include file="/WEB-INF/include/footer.jsp" %> 
	
	
	<script>
	
	var		phoneDupChecked		=	true;
	var		emailDupChecked		=	true;
	
	const formEl         = document.querySelector('form')
	const memberNameEl   = document.querySelector('[name="member_name"]')
	const memberIdEl     = document.querySelector('[name="member_id"]')
	const phoneEl        = document.querySelector('[name="phone_num"]')
	const emailEl        = document.querySelector('[name="email"]')
	const phoneDupBtnEl  = document.querySelector('#phoneDupCheck')
	const emailDupBtnEl  = document.querySelector('#emailDupCheck')
	
	
	// 입력항목 체크
	formEl.addEventListener('submit', function(e){
		
		// 아이디값 체크
		if ( memberNameEl.value.trim() == '' ) {
			alert('이름을 입력하세요')
			e.preventDefault() 
			e.stopPropagation() 
			memberNameEl.focus()
			return;
		}
		
		if(phoneEl.value.trim() == '') {
	    alert('연락처를 입력하세요.')
	    e.preventDefault()
	    phoneEl.focus()
	    return;
		}

		if(emailEl.value.trim() == '') {
	    alert('이메일을 입력하세요.')
	    e.preventDefault()
	    emailEl.focus()
	    return;
		}
		
		const phoneRegex = /^01[016789]\d{7,8}$/;
		if (!phoneRegex.test(phoneEl.value.trim())) {
		    alert('전화번호 형식이 올바르지 않습니다. (예: 01012345678)');
		    e.preventDefault();
		    phoneEl.focus();
		    return;
		}
		
		// 연락처 중복 체크 여부 확인
		if(!phoneDupChecked) {
			alert('연락처 중복확인이 필요합니다.')
			e.preventDefault() 
			e.stopPropagation() 
			return;
		}
		
		// 이메일 중복 체크 여부 확인
		if(!emailDupChecked) {
			alert('이메일 중복확인이 필요합니다.')
			e.preventDefault() 
			e.stopPropagation() 
			return;
		}

	}) // formEl.submit
	
	
	// 중복 확인(Ajax) - 연락처
	phoneDupBtnEl.addEventListener('click', function () {
		if(phoneEl.value.trim() ==''){
			alert('연락처를 입력하세요')
			phoneEl.focus()
			return ;
		}
		const phoneRegex = /^01[016789]\d{7,8}$/;
		if (!phoneRegex.test(phoneEl.value.trim())) {
		    alert('전화번호 형식이 올바르지 않습니다. (예: 01012345678)');
		    phoneEl.focus();
		    return;
		}
		let		url		=	'/Member/PhoneDupCheck/'+ phoneEl.value;
		fetch(url)
	    .then( (response) => response.json() ) 
		  .then( (json) => {
			  if( json.member.member_id == memberIdEl.value  ){
				  alert('본인이 사용중인 번호입니다.')
				  phoneDupChecked = true
			  }
			  else if(json.member && json.member.phone_num !=null) {
				  alert('사용불가능')
				  phoneEl.focus()
				  phoneDupChecked = false
			  }
				else {
					alert('사용가능')
					phoneDupChecked = true
				}
		  })
		  .catch((error) => {
	    	  console.dir(error)
	      }) //then end
	}) // phoneDupBtnEl function end
	
	// 중복확인(Ajax) - 이메일
	emailDupBtnEl.addEventListener('click', function () {
		if(emailEl.value.trim() ==''){
			alert('이메일을 입력하세요')
			emailEl.focus()
			return ;
		}
		let		url		=	'/Member/EmailDupCheck/'+ emailEl.value;
		fetch(url)
	    .then( (response) => response.json() ) 
		  .then( (json) => {
			  if( json.member.member_id == memberIdEl.value  ){
				  alert('본인이 사용중인 이메일입니다.')
				  emailDupChecked = true
			  }
			  else if(json.member && json.member.email !=null) {
				  alert('사용불가능')
				  emailEl.focus()
				  emailDupChecked = false
			  }
				else {
					alert('사용가능')
					emailDupChecked = true
				}
		  })
		  .catch((error) => {
	    	  console.dir(error)
	      }) //then end
	}) // emailDupBtnEl function end
	
	
	// 연락처나 이메일의 value가 바뀌면 DupChecked = false
	// change가 아닌 key press로 해 놓았으면, 아이디에 다른곳에서 값을 붙여넣기 하면 검증 불가 
	phoneEl.addEventListener('change', function () {
		phoneDupChecked = false;
	})
	
	emailEl.addEventListener('change', function () {
		emailDupChecked = false;
	})
	
	

	
	</script>
</body>
</html>