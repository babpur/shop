<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>    
<%
	System.out.println("----------");
	System.out.println("editPwAction");
	
	// customerOne -> 'editPwAction'     
	String mail = request.getParameter("mail");
	String oldPw = request.getParameter("oldPw");
	String newPw = request.getParameter("newPw");
	
	System.out.println("mail: " + mail);
	System.out.println("oldPw: " + oldPw);
	System.out.println("newPw: " + newPw);
	
	int row = CustomerDAO.updatePw(mail, oldPw, newPw);
	if(row > 0 ){
		System.out.println("비밀번호가 변경되었습니다.");
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		
	} else {
		System.out.println("비밀번호가 변경되지 않았습니다.");
		response.sendRedirect("/shop/customer/editPwForm.jsp?mail=" + mail);
	}
%>    