<%@page import="shop.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	System.out.println("--------------------");
	System.out.println("addEmpAction.jsp");

	// 인증 분기: 세션 변수 이름 - loginEmp

	if(session.getAttribute("loginEmp") != null) {
	// 로그인 상태일 때 empLoginForm.jsp으로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>
<%

	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	String empName = request.getParameter("empName");
	String empJob = request.getParameter("empJob");
	String hireDate = request.getParameter("hireDate");

	System.out.println("empId: " + empId);
	System.out.println("empPw: " + empPw);
	System.out.println("empName: " + empName);
	System.out.println("empJob: " + empJob);
	System.out.println("hireDate: " + hireDate);
%>

<%
	int row = EmpDAO.insertEmp(empId, empPw, empName, empJob, hireDate);

	if(row == 0) {
		System.out.println("회원 가입 실패");
		response.sendRedirect("/shop/emp/addEmpForm.jsp");
	} else {
		System.out.println("회원 가입 성공");
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
	}
%>