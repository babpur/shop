<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="shop.dao.*" %>
<%@ page import="java.net.*" %>
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
	// addCustomerForm -> addCustomerAction
	
	String name = request.getParameter("name");
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	
	// 디버깅
	System.out.println("name: " + name);
	System.out.println("mail: " + mail);
	System.out.println("pw: " + pw);
	System.out.println("birth: " + birth);
	System.out.println("gender: " + gender);
	
	String errorMsg = null;
	if(name == null || name.isEmpty() 
			|| mail == null || mail.isEmpty()
			|| pw == null || pw.isEmpty()
			|| birth == null || birth.isEmpty()
			|| gender == null || gender.isEmpty()) {
		errorMsg = "내용을 입력해 주세요";
	}
%>

<%
	
	int row = CustomerDAO.insertCustomer(mail, pw, name, birth, gender);
	System.out.println("row: " + row);
	if(row == 1){
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");		
		System.out.println("회원 가입 성공");
	} else {
		errorMsg = URLEncoder.encode( errorMsg, "utf-8");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp+errorMsg=" + errorMsg);
		System.out.println("회원 가입 실패");
	}
%>