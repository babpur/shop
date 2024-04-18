<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "shop.dao.*" %>
<%
	System.out.println("--------------------");
	System.out.println("dropCustomerAction.jsp");
	
	if(session.getAttribute("loginCustomer") == null) {
		// 로그인이 되었을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		return;
	}
%>

<%
	// customerOne -> dropCustomerAction     
	String mail = null;
	String pw = null;
	
	int row = CustomerDAO.deleteCustomer(mail, pw);
	if(row == 1) {
		System.out.println("회원 탈퇴 완료");
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
	} else {
		System.out.println("회원 탈퇴 실패");
		response.sendRedirect("/shop/customer/customerOne.jsp?mail=" + mail);
		return;
	}
%>