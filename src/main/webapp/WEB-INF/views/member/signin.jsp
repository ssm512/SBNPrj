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
						<input type="button" value="목록" 
						onclick ="window.location.href='/'"/>
					</td>
				</tr>
		</table>
	</form>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp" %> 
</body>
</html>