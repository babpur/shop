<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!-- Controller Layer-->
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
	// DB
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");

%>

<%
	// request 분석
	// 현재 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 한 페이지에 출력할 직원 리스트
	int rowPerPage = 10;
	
	// 시작 페이지 = (현재 페이지 -1) * 한 페이지에 출력할 직원 리스트 
	int startRow = (currentPage-1) * rowPerPage;
	
	// 전체 직원의 수
	String sql1 = "SELECT count(*) cnt FROM emp";
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null; 
	stmt1 = conn.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	
	int totalRow = 0;
	
	if(rs1.next()){
		totalRow = rs1.getInt("cnt");
	}
	
	// 마지막 페이지 계산하기 = 전체 회원수 / 한 페이지에서 보이는 인원수
	int lastPage = totalRow / rowPerPage;
	
	// 인원이 딱 맞게 나누어 떨어지지 않을 때 마지막 페이지 + 1 해 준다. 
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage +1 ;
	}
	
	System.out.println("lastPage: " + lastPage);
	System.out.println("totalRow: " + totalRow);
	System.out.println("rowPerPage: " + rowPerPage);
	System.out.println("startRow: " + startRow);
	System.out.println("rowPerPage: " + rowPerPage);
	
%>

<!-- Model Layer -->
<%
	// 모델: 특수한 형태의 데이터 (RDBMS: mariadb)
	// -> API 사용하여 (JDBC API) 자료 구조(ResultSet) 취득
	// -> 일반화된 자료 구조로(ArrayList<HashMap> 변경 -> 모델 취득

	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	/*
		select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate active from emp order by active asc, hire_date desc;
	*/
	String sql2 = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by hire_date desc limit ?, ?;";

	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, startRow);
	stmt2.setInt(2, rowPerPage);
	
	System.out.println("stmt2: " + stmt2);
	
	rs2 = stmt2.executeQuery(); 
	// JDBC API에 종속된 자료 구조 모델 ResultSet-> 기본 API 자료 구조로 변경(ArrayList)
	ArrayList<HashMap<String, Object>> list // Object: 모든 타입의 부모
		= new ArrayList<HashMap<String, Object>>();
	
	// ResultSet -> ArrayList<HashMap<String, Object>>
	while(rs2.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("empId", rs2.getString("empId"));
		m.put("empName", rs2.getString("empName"));
		m.put("empJob", rs2.getString("empJob"));
		m.put("hireDate", rs2.getString("hireDate"));
		m.put("active", rs2.getString("active"));
		list.add(m);
	}
	
	// JDBC API 사용이 끝났다면 DB 자원들을 반납
%>

<!-- View Layer -->
<!-- 모델: ArrayList<HashMap<String, Object>> 출력하는 Layer-->
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
	@font-face {
		/* 고령딸기체 */	
	    font-family: 'GoryeongStrawberry';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-01@1.0/GoryeongStrawberry.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
	}
	a {
		text-decoration: none;
	}
	a:link {
		color: #000000;
	}
	a:visied {
		color: #000000;
	}
	a:hover {
		color: #000000;
	}
	a:active {
		color: #FFFFFF;
		background-color: #000000;
	}
	body {
		/* 고령딸기체 전체 적용 */	
	    font-family: 'GoryeongStrawberry';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-01@1.0/GoryeongStrawberry.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
	    
	    /* https://kor.pngtree.com/back/down?id=MTE1NzkyMA==&type=1&time=1712045765&token=YzUyZTdlMThlZmE0N2MxY2YxMDQ5NTI4OGE4OWRhYjA=&t=0 */
	    background-image: url("/shop/img/backgroundLoginForm.png");
	    background-position: center;
		background-repeat: no-repeat;
		background-size: cover;
		height: 100vh;
	}
	
	main {
		text-align: center;
		padding: 10px;
	}
	head {
	}
	h1 {
		text-align: center;
		margin-bottom: 30px;
		font-size: 70px;
		margin-top: 30px;
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
		width: 50%;
		height: 70%;
		text-align: center;
		margin: auto;
		align-items: center;
	}
	</style>
</head>
<body>
	<!-- empMenu.jsp include: 주체(서버) vs redirect: 주체(클라이언트) -->
	<!-- 주체가 클라이언트가 아니기 때문에 sendRedirect처럼 경로가 /shop/.... 아님 -->
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	<head>
		<h1>사원 목록</h1>
	</head>
	<main class="bg-light">
		<table class="table table-hover shadow rounded">
		<thead>
			<tr>
				<th>empId</th>
				<th>empName</th>
				<th>empJob</th>
				<th>hireDate</th>
				<th>active</th>
			</tr>
		</thead>
		<tbody>	
			<%
				for(HashMap<String, Object> m : list) {
			%>
					<tr>
						<td><%=(String)(m.get("empId"))%></td>
						<td><%=(String)(m.get("empName"))%></td>
						<td><%=(String)(m.get("empJob"))%></td>
						<td><%=(String)(m.get("hireDate"))%></td>
						<td>
							<%
								HashMap<String, Object> sm = (HashMap<String, Object>)session.getAttribute("loginEmp");
								if((Integer) sm.get("grade") > 0) {
							%>	
								<a href="/shop/emp/modifyEmpActive.jsp?empId=<%=(String)(m.get("empId"))%>&active=<%=(String)(m.get("active"))%>">
									<%=(String)(m.get("active"))%>
									<!-- 스위치 역할을 함 -->
								</a>
							<%		
								}
							%> 
						</td>
					</tr>	
			<%		
				}
			%>
		</tbody>
		</table>
		<nav aria-label="Page navigation"><br>
			<ul class="pagination justify-content-center">
				<%
					if (currentPage > 1) {
				%>
						<li class="page-item">
							<a class="page-link btn btn-secondary" href="/shop/emp/empList.jsp?currentPage=1">처음</a>
						</li>
						<li class="page-item">	 
							<a class="page-link btn btn-secondary" href="/shop/emp/empList.jsp?currentPage=<%=currentPage - 1%>">이전</a>
						</li>
				<%
					} else {
				%>	
						<li class="page-item disabled">
							<a class="page-link btn btn-secondary" href="/shop/emp/empList.jsp?currentPage=1">처음</a>
						</li>
						<li class="page-item disabled">
							<a class="page-link btn btn-secondary" href="/shop/emp/empist.jsp?currentPage=<%=currentPage - 1%>">이전</a>
						</li>
				<%		
					}
				
					if(currentPage < lastPage) {
				%>
						<li class="page-item">
							<a class="page-link btn btn-secondary" href="/shop/emp/empList.jsp?currentPage=<%=currentPage + 1%>">다음</a>
						</li>
						<li class="page-item">
							<a class="page-link btn btn-secondary" href="/shop/emp/empList.jsp?currentPage=<%=lastPage+1%>">마지막</a>
						</li>
				<%		
					} else {
				%>
						<li class="page-item disabled">
							<a class="page-link btn btn-secondary" href="/shop/emp/empList.jsp?currentPage=<%=currentPage + 1%>">다음</a>
						</li>
						<li class="page-item disabled">
							<a class="page-link btn btn-secondary" href="/shop/emp/empList.jsp?currentPage=<%=lastPage%>">마지막</a>
						</li>
				<%		
					}
				%>
			</ul>
		</nav>
	</main>
</body>
</html>