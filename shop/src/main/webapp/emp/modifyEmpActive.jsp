<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>
<!-- Controller Layer-->
<%
	System.out.println("----------");
	System.out.println("modifyEmpActive.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") == null) {
		// 로그인이 되지 않았을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>

<%
	// request 
	String empId = request.getParameter("empId");
	String active = request.getParameter("active");
	
	// 디버깅 코드
	System.out.println("empId: " + empId);
	System.out.println("active: " + active);

	int row = EmpDAO.updateEmpActive(empId, active);
	if(row > 0 ){
		System.out.println("ON / OFF 설정이 변경되었습니다.");
	} else {
		System.out.println("ON / OFF 설정이 변경되지 않았습니다.");
		
	}
	response.sendRedirect("/shop/emp/empList.jsp");
%>