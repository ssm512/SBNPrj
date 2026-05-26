<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SBN Login</title>

<link rel="shortcut icon" href="/img/favicon.png" type="image/x-icon" />
<link href="/css/common.css" rel="stylesheet" />

<style>
	.main-wrapper {
		background-color: #F5F5DC;
		text-align: center;
		margin: 30px auto;
		padding: 30px;
		width: 500px;
		height: 600px;
	}
</style>

</head>
<body>
	<%@include file="/WEB-INF/include/headermenu.jsp" %>
	
	<div class="main-wrapper">
		<h2>SBN 로그인</h2>
		<form action="/Member/Login" method="post">
		  <div >
		    <input type="text"  name="member_id" id="member_id" placeholder="아이디" required  />
		  </div>
		  <div >
		    <input type="password"  name="password" id="password" placeholder="비밀번호" required />
		  </div>
		  <div>
		  ${ msg }
		  </div>
		  <div>
		  	<button type="submit"  >로그인</button>
		  </div>
		  <div>
		  	<a href="/Member/SigninForm" >회원가입</a>
		  </div>
		</form>
	</div>
	
	
	
	 
	<%@include file="/WEB-INF/include/footer.jsp" %> 
</body>
</html>