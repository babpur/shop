<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>

<%
	System.out.println("--------------------");
	System.out.println("customerLoginAction.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginCustomer
	
	if(session.getAttribute("loginCustomer") != null) {
		// 로그인이 되었을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/productList.jsp");
		return;
	}
%>
<%	
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	
	System.out.println("mail: " + mail);
	System.out.println("pw: " + pw);
	
%>
<%
	HashMap<String, Object> loginCustomer = CustomerDAO.login(mail, pw);
	
	if(loginCustomer == null){ // 로그인 실패
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("잘못된 접근입니다. \n ID와 비밀번호를 확인해 주세요", "utf-8");
		response.sendRedirect("/shop/customer/customerLoginForm.jsp?errMsg=" + errMsg);
	} else {
		System.out.println("로그인 성공");
		session.setAttribute("loginCustomer", loginCustomer);
		System.out.println("loginCustomer: " + loginCustomer);
		response.sendRedirect("/shop/customer/productList.jsp");
		return;
	}
%>