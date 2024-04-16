<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>

<!-- Controller Layer-->
<%
	System.out.println("----------");
	System.out.println("empList.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") == null) {
		// 로그인이 되지 않았을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>	
<%
	String category = request.getParameter("category");
	
	System.out.println(category);
%>

<%
	
	int row = CategoryDAO.deleteCategory(category);
	if(row == 1) {
		System.out.println("카테고리 삭제 성공");
		
	} else {
		System.out.println("카테고리 삭제 실패");
	}
	
	response.sendRedirect("/shop/emp/categoryList.jsp");
%>