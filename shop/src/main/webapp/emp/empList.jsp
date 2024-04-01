<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	System.out.println("----------");
	System.out.println("empList.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") == null) {
		// 로그인이 되지 않았을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	/*
		select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate active from emp order by active asc, hire_date desc;
	*/

	Class.forName("org.mariadb.jdbc.Driver");
	
	String sql = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by active asc, hire_date desc;";
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	ResultSet rs = null;
	System.out.println("stmt: " + stmt);
	stmt = conn.prepareStatement(sql);
	
	rs = stmt.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<!-- bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<!-- bootstrap -->
	<style>
	* {
	/* 고령딸기체 */	
	    font-family: 'GoryeongStrawberry';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-01@1.0/GoryeongStrawberry.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
	}
	
	main {
		text-align: center;
	}
	h1 {
		text-align: center;
		margin-bottom: 30px;
		font-size: 70px;
	}
	thead {
		font-size: 30px;
	}
	tbody {
		font-size: 20px;
	}
	.form-container {
		justify-content: center;
	}
	.table-content {
		width: 80%;
		height: 70%;
		text-align: center;
		margin: auto;
		align-items: center;
	}
	</style>
</head>
<body>
	
	
	
	
	
	
	
	<aside> <!-- 네비게이션바로 수정 -->
		<a>여기</a><br>
		<a>여기</a><br>
		<a>여기</a><br>
		<a>여기</a><br>
	</aside>
	<head>
		<h1>직원 명단</h1>
	</head>
	<main>
		<!-- empId, empName, empJob, hireDate from emp order by active asc hire_date desc; -->
		<table class="table table-hover table-content">
			<thead>
				<tr>
					<td>ID</td>
					<td>이름</td>
					<td>직급</td>
					<td>고용일</td>
					<td>계정 활성화</td>
				</tr>
			</thead>
			<tbody>
				<%
					while(rs.next()){
				%>
						<tr>
							<td><%=rs.getString("empId")%></td>
							<td><%=rs.getString("empName")%></td>
							<td><%=rs.getString("empJob")%></td>
							<td><%=rs.getString("hireDate")%></td>
							<td><%=rs.getString("active")%></td>
						</tr>
				<%		
					}
				%>
			</tbody>
		</table>
	</main>
</body>
</html>