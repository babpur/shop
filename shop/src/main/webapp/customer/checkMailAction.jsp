<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%
	System.out.println("----------");
	System.out.println("checkMailAction");
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
	}
		response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkMail=" + checkMail + "&ck=T");
%>
