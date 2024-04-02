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
	@font-face {
		/* 고령딸기체 */	
	    font-family: 'GoryeongStrawberry';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-01@1.0/GoryeongStrawberry.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
	}
	body {
		/* 고령딸기체 전체 적용 */	
	    font-family: 'GoryeongStrawberry';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-01@1.0/GoryeongStrawberry.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
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