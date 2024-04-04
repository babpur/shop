<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!-- Controller Layer-->
<%
	System.out.println("----------");
	System.out.println("addCategoryAction.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") == null) {
		// 로그인이 되지 않았을 때 empList.jsp로 리다이렉트하겠다.
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
	Class.forName("org.mariadb.jdbc.Driver");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");

	String sql = "insert into category(category) values(?)";
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, addCategory);
	
	System.out.println("stmt: " + stmt);

	int row = 0;
	row = stmt.executeUpdate();
	
%>
<%
	if(row == 1) {
		System.out.println("카테고리 추가 성공");
	} else {
		System.out.println("카테고리 추가 실패");
	}
	response.sendRedirect("/shop/emp/categoryList.jsp");
%>


