<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>

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
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw"); 

	System.out.println("empId: " + empId);
	System.out.println("empPw: " + empPw);
	
	/* 
		select emp_id empId from emp where active='ON' and emp_id = ? and emp_pw = password(?)
	*/
	String sql = "select emp_id empId from emp where active='ON' and emp_id = ? and emp_pw = password(?)";
	
	Class.forName("org.mariadb.jdbc.Driver");
	
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, empId);
	stmt.setString(2, empPw);
	rs = stmt.executeQuery();
	
	System.out.println("stmt: " + stmt);
	// 실패 empLoginForm.jsp
	// 성공 empList.jsp
	
	if(rs.next()){
		System.out.println("로그인 성공");
		response.sendRedirect("./empList.jsp");
		session.setAttribute("loginEmp", rs.getString("empId"));
	} else {
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("잘못된 접근입니다. \n ID와 비밀번호를 확인해 주세요", "utf-8");
		response.sendRedirect("/shop/emp/empLoginAction.jsp?errMsg=" + errMsg);
		return;
	}
%>