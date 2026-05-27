<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<%@include file="/WEB-INF/include/headermenu.jsp" %>
	<div class="main-wrapper">
	<form action="/Member/Signin" method="post">
		<table>
				<tr>
					<td>
					<input type="text" name="member_id" placeholder="아이디"/>
					<input type="button" id="dupCheck" value="중복확인" />
					</td>
				</tr>
				<tr>
					<td><input type="password" id="password" name="password" placeholder="비밀번호"/></td>
				</tr>
				<tr>
					<td><input type="password" id="password2" placeholder="비밀번호 확인"/></td>
				</tr>
				<tr>
					<td><input type="text" name="member_name" placeholder="이름"/></td>
				</tr>
				<tr>
					<td><input type="date" name="birth" /></td>
				</tr>
				<tr>
					<td><input type="text" name="phone_num" placeholder="연락처(01012345678)"/></td>
				</tr>
				<tr>
					<td><input type="email" name="email" placeholder="이메일"/></td>
				</tr>
				<tr>
					<td>
						선출여부 : 
						<input type="radio" name="elite" id="normal" value="비선출"/>
						<label for="normal">비선출</label>
						<input type="radio" name="elite" id="middle_school" value="중출"/>
						<label for="middle_school">중출</label>
						<input type="radio" name="elite" id="high_school" value="고출"/>
						<label for="high_school">고출</label>
						<input type="radio" name="elite" id="pro" value="프로"/>
						<label for="pro">프로</label>					
					</td> 
				</tr>
				<tr>
					<td>
					투타구분 : 
						<input type="radio" name="use_hand" id="right_right" value="우투우타"/>
						<label for="right_right">우투우타</label>
						<input type="radio" name="use_hand" id="right_left" value="우투좌타"/>
						<label for="right_left">우투좌타</label>
						<input type="radio" name="use_hand" id="left_left" value="좌투좌타"/>
						<label for="left_left">좌투좌타</label>
						<input type="radio" name="use_hand" id="left_right" value="좌투우타"/>
						<label for="left_right">좌투우타</label>
						<input type="radio" name="use_hand" id="switch" value="스위치"/>
						<label for="switch">스위치</label>
					</td>
				</tr>
				<td>
					<tr>
						<td><input type="text" name="hope_position" placeholder="선호포지션"/></td>
					</tr>
				</td>
				<tr>
					<td>
						<input type="submit" value="추가"/>
						<input type="button" value="Home" 
						onclick ="window.location.href='/'"/>
					</td>
				</tr>
		</table>
	</form>
	</div>
	
	<!-- 입력 여부 체크 -->
	<script>
		/* 아이디 중복 체크 여부 전역변수 */	
		var		idDupChecked		=	false;
	
		/* 필요한것들 미리 찾고 */
		const	formEl					=	document.querySelector('form');
		const	memberIdEl				=	document.querySelector('[name="member_id"]');
		const	passwordEl			=	document.querySelector('#password');
		const	password2El			=	document.querySelector('#password2');
		const	membernameEl			=	document.querySelector('[name="member_name"]');
		// 입력항목 체크
		formEl.addEventListener('submit', function(e){
		// 아이디값 체크
		if ( memberIdEl.value.trim() == '' ) {
			alert('아이디를 입력하세요')
			useridEl.focus();
			e.preventDefault() // 이벤트 취소
			e.stopPropagation() // 이벤트 버블링 방지 
			return;
		}
		
		// 아이디 중복 체크 여부 확인
		if(!idDupChecked) {
			alert('아이디 중복확인 필요')
			e.preventDefault() // 이벤트 취소
			e.stopPropagation() // 이벤트 버블링 방지 
			return;
		}
		
		// 비밀번호값 체크
		if ( passwordEl.value.trim() == '' ) {
			alert('암호를 입력하세요')
			passwordEl.focus();
			e.preventDefault() // 이벤트 취소
			e.stopPropagation() // 이벤트 버블링 방지
			return;
		}
		
		// 비밀번호2값 체크
		if ( password2El.value.trim() == '' ) {
			alert('비밀번호 확인을 입력하세요')
			password2El.focus();
			e.preventDefault() // 이벤트 취소
			e.stopPropagation() // 이벤트 버블링 방지
			return;
		}
		
		// 비밀번호 == 비밀번호2 체크
		if ( passwordEl.value != password2El.value ) {
			alert('비밀번호가 일치하지 않습니다')
			password2El.focus();
			e.preventDefault() // 이벤트 취소
			e.stopPropagation() // 이벤트 버블링 방지
			return;
		}
	</script>
	<!-- 아이디 중복 확인 -->
	<script>
		// 아이디 중복 확인(Ajax)
		const btnDupEl		=	document.querySelector('#dupCheck')
		btnDupEl.addEventListener('click', function () {
			if(memberIdEl.value.trim() ==''){
				alert('아이디를 입력하세요')
				memberIdEl.focus()
				return ;
			}
			//alert('ok2')
			// .then( response => response.json() )  넘겨받은것 json으로 변환하고
			// .then(data => ...) 뭐 하는 것
			let		url		=	"/Member/IdDupCheck?member_id="+memberIdEl.value;
			fetch(url)
				.then( response => response.json() ) 
			  .then(data => {
				  console.log(data.userid)
				  if(data.memberid !=null) {
					  alert('사용불가능')
					  idDupChecked = false
				  }
					else {
						alert('사용가능')
						idDupChecked = true
					}
			  }); //then end
		}) // btnDup function end
		
		// userid의 value가 바뀌면 idDupChecked = false
		// change가 아닌 key press로 해 놓았으면, 아이디에 다른곳에서 값을 붙여넣기 하면 못 알아차림 -> change로 해놓은 이유 
		memberidEl.addEventListener('change', function () {
			idDupChecked = false;
		})
</script>
	
	<%@include file="/WEB-INF/include/footer.jsp" %> 
</body>
</html>