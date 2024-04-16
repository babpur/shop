<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>

<!-- Controller Layer-->
<%
	System.out.println("----------");
	System.out.println("addCategoryAction.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") == null) {
		// 로그인이 되지 않았을 때 empLoginForm.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>	
<%
	// request
	String addCategory = request.getParameter("addCategory");
	
	System.out.println("addCategory:" + addCategory);
%>

<%
	String category = addCategory;

	int row = CategoryDAO.insertCategory(category);
%>
<%
	if(row == 1) {
		System.out.println("카테고리 추가 성공");
	} else {
		System.out.println("카테고리 추가 실패");
	}
	response.sendRedirect("/shop/emp/categoryList.jsp");
%>


