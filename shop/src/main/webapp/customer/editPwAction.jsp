<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>    
<%
	System.out.println("----------");
	System.out.println("editPwAction");
	

	// 인증 분기: 세션 변수 이름 - loginCustomer

	if(session.getAttribute("loginCustomer") != null) {
	// 로그인이 되지 않았을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/productList.jsp");
		return;
	}
%>
<%	
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
		response.sendRedirect("/shop/customer/customerOne.jsp?mail=" + mail);
	}
%>    