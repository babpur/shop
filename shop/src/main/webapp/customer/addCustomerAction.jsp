<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="shop.dao.*" %>
<%
	System.out.println("--------------------");
	System.out.println("addCustomerAction.jsp");

	// 인증 분기: 세션 변수 이름 - loginCustomer

	if(session.getAttribute("loginCustomer") != null) {
	// 로그인이 되지 않았을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/productList.jsp");
		return;
	}
%>
<%

	String name = request.getParameter("name");
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");

	System.out.println("name: " + name);
	System.out.println("mail: " + mail);
	System.out.println("pw: " + pw);
	System.out.println("birth: " + birth);
	System.out.println("gender: " + gender);
%>

<%
	
	int row = CustomerDAO.insertCustomer(mail, pw, name, birth, gender);
	if(row == 1){
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");		
		System.out.println("회원 가입 성공");
	} else {
		response.sendRedirect("/shop/customer/addCustomerForm.jsp");
		System.out.println("회원 가입 실패");
	}
%>