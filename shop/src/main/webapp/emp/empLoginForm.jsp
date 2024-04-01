<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("----------");
	System.out.println("empLoginForm.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") != null) {
		// 로그인이 되었을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<style>
		main {
			justify-content: center;
		}
		
		.form-container {
			justify-content: center;
		}
	
	
	</style>
</head>
<body>
	<main>
		<div class="form-container">
			<form method="post" action="/shop/emp/empLoginAction.jsp">
				<div>아이디</div>
				<input type="text" name="empId">
				<div>pw</div>
				<input type="password" name="empPw">
			<button type="submit">로그인</button>
			</form>
		</div>
	</main>
</body>
</html>