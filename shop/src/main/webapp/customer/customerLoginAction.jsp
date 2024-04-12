<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*"%>
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
	String customerEmail = request.getParameter("customerEmail");
	String customerPw = request.getParameter("customerPw");
	
	System.out.println("customerEmail: " + customerEmail);
	System.out.println("customerPw: " + customerPw);
	
%>
<%
	/* 
		select mail, pw from customer where mail=?, pw=?
	*/
	String sql = "select * from customer where mail=? and pw=password(?)";
	
	Class.forName("org.mariadb.jdbc.Driver");
	
	Connection conn = null;
	
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");	

	PreparedStatement stmt = null;
	ResultSet rs = null;

	stmt = conn.prepareStatement(sql);
	stmt.setString(1, customerEmail);
	stmt.setString(2, customerPw);
	
	rs = stmt.executeQuery();
	System.out.println("stmt: " + stmt);
	
	if(rs.next()){
		System.out.println("로그인 성공");
		HashMap<String, Object> loginCustomer = new HashMap<String, Object>();
		loginCustomer.put("customerEmail", rs.getString("mail"));
		loginCustomer.put("customerName", rs.getString("name"));
		loginCustomer.put("customerBirth", rs.getString("birth"));
		loginCustomer.put("customerGender", rs.getString("gender"));
		
		session.setAttribute("loginCustomer", loginCustomer);
		
		HashMap<String, Object> m = (HashMap<String, Object>)session.getAttribute("loginCustomer");
		System.out.println((String)(m.get("customerEmail")));
		System.out.println((String)(m.get("customerName")));
		System.out.println((String)(m.get("customerBirth")));
		System.out.println((String)(m.get("customerGender")));
		
		response.sendRedirect("/shop/customer/productList.jsp");
	} else {
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("잘못된 접근입니다. \n ID와 비밀번호를 확인해 주세요", "utf-8");
		response.sendRedirect("/shop/customer/customerLoginForm.jsp?errMsg=" + errMsg);
		return;
	}
%>