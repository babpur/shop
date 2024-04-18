<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
	System.out.println("----------");
	System.out.println("customerMenu.jsp");
	
 	// 인증 분기: 세션 변수 이름 - loginCustomer
	if(session.getAttribute("loginCustomer") == null) {
		// 로그인이 되지 않았을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		return;
	} 
%>

<%
	HashMap<String, Object> loginCustomer = (HashMap<String, Object>)session.getAttribute("loginCustomer");
	String customerName = null;
	String customerEmail = null;
	String customerPw = null;
	if(loginCustomer != null) {
	    // HashMap에서 customerName 값 가져오기
		customerName = (String)loginCustomer.get("customerName");
		customerEmail = (String)loginCustomer.get("customerEmail");
		customerPw = (String)loginCustomer.get("customerPw");
	}
	
	System.out.println("customerName: " + customerName);
	System.out.println("customerEmail: " + customerEmail);
	System.out.println("customerPw: " + customerPw);
%>
<style>
	.shop-logo {
		height: 50px;
		width: 50px;
	}
	.commBar {
		height: 50px;
		display: flex;
		font-size: 20px;
		align-items: center;
	}
	.barContent {
		margin-left: 20px;
	}
	.commBar a {
		color: #FFFFFF;
	}
	.user-id {
		display: flex;
		justify-content: end;
		color: #000000;
	}
	.logoutLink{
		margin-left: auto;
	}
</style>
<div class="commBar bg-dark bg-gradient">
	 <a href="/shop/customer/productList.jsp">
		<img class="shop-logo" src="/shop/img/shopLogo1.png">
	</a>
	<a class="barContent logoutLink" href="/shop/customer/customerLogout.jsp">LOGOUT</a>
</div>
<div class="user-id">
	<span class="barContent">
		<a href="/shop/customer/customerOne.jsp?customerEmail=<%=customerEmail%>&customerPw=<%=customerPw%>">'<%=customerName%>' 님 반갑습니다</a> 
	</span> 
</div>