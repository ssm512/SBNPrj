<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN - 회원가입</title>

<link rel="shortcut icon" href="/img/favicon.png" type="image/x-icon" />
<link href="/css/common.css" rel="stylesheet" />

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
					<td><input type="text" name="member_name" placeholder="이름" required/></td>
				</tr>
				<tr>
					<td><input type="date" name="birth" required/></td>
				</tr>
				<tr>
					<td>
					<input type="text" name="phone_num" placeholder="연락처(01012345678)"/>
					<input type="button" id="phoneDupCheck" value="중복확인" />
					</td>
				</tr>
				<tr>
					<td><input type="text" name="address" placeholder="주소(부산 해운대구 등)"/></td>
				</tr>
				<tr>
					<td>
					<input type="email" name="email" placeholder="이메일"/>
					<input type="button" id="emailDupCheck" value="중복확인" />
					</td>
				</tr>
				<tr>
					<td>
						선출여부 : 
						<input type="radio" name="elite" id="normal" value="비선출" checked/>
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
						<input type="radio" name="use_hand" id="right_right" value="우투우타" checked/>
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
				<tr>
						<td><input type="text" name="hope_position" placeholder="선호포지션"/></td>
				</tr>
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
		var		idDupChecked		  =	false;
		var		phoneDupChecked		=	true;
		var		emailDupChecked		=	true;
	
		/* 필요한것들 미리 찾고 */
		const	formEl					=	document.querySelector('form');
		const	memberIdEl			=	document.querySelector('input[name="member_id"]');
		const	passwordEl			=	document.querySelector('#password');
		const	password2El			=	document.querySelector('#password2');
		const	membernameEl		=	document.querySelector('[name="member_name"]');
		const phoneEl         = document.querySelector('[name="phone_num"]');
		const emailEl         = document.querySelector('[name="email"]');
		const phoneDupBtnEl   = document.querySelector('#phoneDupCheck');
		const emailDupBtnEl   = document.querySelector('#emailDupCheck');
		
		// 아이디에 영어+숫자 제외한 나머지 문자 입력시 제거
		memberIdEl.addEventListener('input', function() {
		    this.value = this.value.replace(/[^a-zA-Z0-9]/g, '');
		})
		
		// 입력항목 체크
		formEl.addEventListener('submit', function(e){
		// 아이디값 체크
		if ( memberIdEl.value.trim() == '' ) {
			alert('아이디를 입력하세요')
			e.preventDefault() 
			e.stopPropagation() 
			memberIdEl.focus()
			return;
		}
		
		// 아이디 중복 체크 여부 확인
		if(!idDupChecked) {
			alert('아이디 중복확인 필요')
			e.preventDefault() 
			e.stopPropagation() 
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
		
		
		// 비밀번호값 체크
		if ( passwordEl.value.trim() == '' ) {
			alert('암호를 입력하세요')
			passwordEl.focus();
			e.preventDefault() 
			e.stopPropagation()
			return;
		}
		
		// 비밀번호 길이 체크
		if(passwordEl.value.length < 4) {
	    alert('비밀번호는 4자리 이상 입력하세요')
      e.preventDefault()
	    passwordEl.focus()
   		return;
		}

		
		// 비밀번호2값 체크
		if ( password2El.value.trim() == '' ) {
			alert('비밀번호 확인을 입력하세요')
			password2El.focus();
			e.preventDefault() 
			e.stopPropagation()
			return;
		}
		
		// 비밀번호 == 비밀번호2 체크
		if ( passwordEl.value != password2El.value ) {
			alert('비밀번호가 일치하지 않습니다')
			password2El.focus();
			e.preventDefault() 
			e.stopPropagation()
			return;
		}
		
		if (phoneEl.value.trim() != '') {
	    const phoneRegex = /^01[016789]\d{7,8}$/;
	    if (!phoneRegex.test(phoneEl.value.trim())) {
	        alert('전화번호 형식이 올바르지 않습니다. (예: 01012345678)');
	        e.preventDefault();
	        phoneEl.focus();
	        return;
	    }
		}
		
		
	})


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
			let		url		=	'/Member/IdDupCheck/'+memberIdEl.value;
			fetch(url)
		    .then( (response) => response.json() ) 
			  .then( (json) => {				  
				  console.log(json)
				  if(json.member && json.member.member_id !=null) {
					  alert('사용불가능')
					  idDupChecked = false
				  }
					else {
						alert('사용가능')
						idDupChecked = true
					}
			  })
			  .catch((error) => {
		    	  console.dir(error)
		    	  //alert(error)			    	  
		      }) //then end
		}) // btnDup function end
		
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
				  if(json.member && json.member.phone_num !=null) {
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
				  if(json.member && json.member.email !=null) {
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
		
		
		
		
		
		
		// userid의 value가 바뀌면 idDupChecked = false
		// change가 아닌 key press로 해 놓았으면, 아이디에 다른곳에서 값을 붙여넣기 하면 못 알아차림 -> change로 해놓은 이유 
		memberIdEl.addEventListener('change', function () {
			idDupChecked = false;
		})
		
		phoneEl.addEventListener('change', function () {
	    if(this.value.trim() == '') {
        phoneDupChecked = true; // 빈값이면 다시 true
	    } else {
        phoneDupChecked = false; // 값 있으면 재확인 필요
	    }
		})
	
		emailEl.addEventListener('change', function () {
	    if(this.value.trim() == '') {
        emailDupChecked = true;
	    } else {
        emailDupChecked = false;
	    }
		})
		
	</script>
	
	<%@include file="/WEB-INF/include/footer.jsp" %> 
</body>
</html>