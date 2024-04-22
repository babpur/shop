<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	System.out.println("--------------------");
	System.out.println("cusomerLogout.jsp");
	
	
	session.invalidate();	
	response.sendRedirect("/shop/customer/customerLoginForm.jsp");
%>
