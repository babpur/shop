<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%
	System.out.println("----------");
	System.out.println("checkMailAction");

	// 인증 분기: 세션 변수 이름 - loginCustomer

	if(session.getAttribute("loginCustomer") != null) {
	// 로그인이 되지 않았을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/productList.jsp");
		return;
	}
 %>
<!-- addCustomerForm -> 'chechMailAction' -->    
<%
	String checkMail = request.getParameter("checkMail");
	System.out.println("checkMail: " + checkMail);
	
	String mail = checkMail;
%>
<%
	boolean result = CustomerDAO.checkMail(mail);
%>
<%
	if(result) {
		result = true;
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkMail=" + checkMail + "&ck=F");
	} else {
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkMail=" + checkMail + "&ck=T");
	}
%>
