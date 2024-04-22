<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*"%>

    
<%
	System.out.println("--------------------");
	System.out.println("/customer/addOrders.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginCustomer
	
	if(session.getAttribute("loginCustomer") == null) {
		// 로그인이 되었을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		return;
	}
%>    
<%
	String mail = null;
	int totalAmount = 0;
	int totalPrice = 0;
	String address = null;
%>

	<!-- productList -> productOne -> 'addOrders' -->
<%
	int row = OrdersDAO.insertOrders(mail, totalAmount, totalPrice, address);
	
%>
