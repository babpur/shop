<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>

<%
	System.out.println("----------");
	System.out.println("empLoginAction.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") != null) {
		// 로그인이 되었을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>
<%
	// controller
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw"); 

	System.out.println("empId: " + empId);
	System.out.println("empPw: " + empPw);

	// model을 호출하는 코드
	HashMap<String, Object> loginEmp = EmpDAO.empLogin(empId, empPw);
	
	if(loginEmp == null){ // 로그인 실패
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("잘못된 접근입니다. \n ID와 비밀번호를 확인해 주세요", "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg=" + errMsg);
	} else {
		System.out.println("로그인 성공");
		session.setAttribute("loginEmp", loginEmp);
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>