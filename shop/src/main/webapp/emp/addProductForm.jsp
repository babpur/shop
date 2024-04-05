<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	System.out.println("----------");
	System.out.println("addProductForm.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") == null) {
		// 로그인이 되지 않았을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>	
<%
	Class.forName("org.mariadb.jdbc.Driver");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");

	String sql ="SELECT category from category";
	
	stmt = conn.prepareStatement(sql);
	
	System.out.println("stmt: " + stmt);
	
	rs = stmt.executeQuery();
	
	ArrayList<String> categoryList = 
			new ArrayList<String>();
	while(rs.next()){
		categoryList.add(rs.getString("category"));
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<!-- main menu -->
	<div><jsp:include page="/emp/inc/empMenu.jsp"></jsp:include></div>
	<h1>상품 등록</h1>
	<form method="post" action="/shop/emp/addProductAction.jsp"
			enctype="multipart/form-data">
		<div>
			category :
			<select name="category">
				<option value="">선택</option>
				<%
					for(String c : categoryList){
				%>
						<option value="<%=c%>"><%=c%></option>
				<%		
					}
				%>
			</select>
		</div>
		<!-- emp_id값은 세션 변수에서 바인딩 from action-->
		<div>
			productTitle: 
			<input type="text" name="productTitle">
		</div>
		<div>
			productImage: 
			<input type="file" name="productImg">
		</div>
		<div>
			productPrice: 
			<input type="number" name="productPrice">
		</div>
		<div>
			productAmount: 
			<input type="number" name="productAmount">
		</div>
		<div>
			productContent 
			<textarea type="text" row="5" cols="50" name="productContent"></textarea>
		</div>
		<button type="submit">상품 등록</button>
	</form>
</body>
</html>