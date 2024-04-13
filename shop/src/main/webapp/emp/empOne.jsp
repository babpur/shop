<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%
	System.out.println("--------------------");
	System.out.println("empOne.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginCustomer
	
	if(session.getAttribute("loginCustomer") != null) {
		// 로그인이 되었을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/productList.jsp");
		return;
	}
%>

<%

String empId = request.getParameter("empId");

System.out.println(empId);

Class.forName("org.mariadb.jdbc.Driver");

Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null; 

conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");

String sql = "SELECT * FROM emp where emp_id=?";
stmt = conn.prepareStatement(sql);
stmt.setString(1, empId);
rs = stmt.executeQuery();


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header>
		<h1>직원 상세 정보</h1>
	</header>
	<main>
		<%
			while(rs.next()){
		%>	
				<div>
					empId: <%=empId %>
				</div>
				<div>
					grade: <%=rs.getString("grade") %>
				</div>
				<div>
					empName: <%=rs.getString("emp_name") %>
				</div>
				<div>
					empJob: <%=rs.getString("emp_job") %>
				</div>
				<div>
					hireDate: <%=rs.getString("hire_date") %>
				</div>
		<%
			}
		%>
	</main>
</body>
</html>