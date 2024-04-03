<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8"); // 대문자 작성 권장

	System.out.println("----------");
	System.out.println("addProductAction.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") == null) {
		// 로그인이 되지 않았을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>	
<!-- Session 설정값 -->
<!-- 입력 시 emp의 emp_id값이 필요함. -->
<%
	String loginEmp = (String)(session.getAttribute("loginEmp"));
	System.out.println("loginEmp" + loginEmp);

%>
<!-- Model Layer -->
<%
	String category = request.getParameter("category");
	String productTitle = request.getParameter("productTitle");
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	int productAmount = Integer.parseInt(request.getParameter("productAmount"));
	String productContent = request.getParameter("productContent");
	
	System.out.println("category: " + category);
	System.out.println("productTitle: " + productTitle);
	System.out.println("productPrice: " + productPrice);
	System.out.println("productAmount: " + productAmount);
	System.out.println("productContent: " + productContent);

	Class.forName("org.mariadb.jdbc.Driver");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	

	String sql = "INSERT INTO product(category, emp_id, product_title, product_price, product_amount, product_content) VALUES(?, ?, ?, ?, ?, ?) where category = ?";	
	
	stmt = conn.prepareStatement(sql);
	
	stmt.setString(1, category);
	stmt.setString(2, emp_id);
	stmt.setString(3, productTitle);
	stmt.setInt(4, productPrice);
	stmt.setInt(5, productAmount);
	stmt.setString(6, productContent);
	stmt.setString(7, category);
	
	System.out.println("stmt: " + stmt);
	
	int row = 0;
	row = stmt.executeUpdate();
	

%>

<!-- Controller Layer -->
<%
	if(row == 1){
		System.out.println("제품 등록 성공");
		response.sendRedirect("/shop/emp/productList.jsp");
	} else {
		System.out.println("제품 등록 실패");
		response.sendRedirect("/shop/emp/addProductForm.jsp");
	}
%>
