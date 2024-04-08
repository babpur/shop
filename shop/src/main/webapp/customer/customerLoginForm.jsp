<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("--------------------");
	System.out.println("customerLoginForm.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginCustomer
	
	if(session.getAttribute("loginCustomer") != null) {
		// 로그인이 되었을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/productList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<form method="post" action="/shop/customer/customerLoginAction.jsp">
		<div>
			E-MAIL:
			<input type="text" name="customerEmail">
		</div>
		<div>
			PW
			<input type="password" name="customerPw">
		</div>
	<button type="submit">로그인</button>
	</form>
	<a href="/shop/customer/addCustomerForm.jsp">회원 가입</a>
</body>
</html>