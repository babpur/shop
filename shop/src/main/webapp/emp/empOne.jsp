<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="shop.dao.*" %>
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

ArrayList<HashMap<String, Object>> empOne = EmpDAO.selectEmpOne(empId);


%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
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
	h1 {
		text-align: center;
		margin-bottom: 30px;
		font-size: 70px;
		margin-top: 30px;
	}
	main {
		text-align: center;
		padding: 30px;
		
	}
	th {
		font-size: 30px;
	}
	td {
		font-size: 20px;
		text-align: left;
		margin-left: 30px;
	}
	</style>
</head>
<body>
	<!-- main menu -->
	<div><jsp:include page="/emp/inc/empMenu.jsp"></jsp:include></div>
	<header>
		<h1>직원 상세 정보</h1>
	</header>
	<main class=bg-light>
		<table class="table table-hover shadow rounded">
		<%
			for(HashMap<String, Object> emp : empOne){
				
		%>	
				<tr>
					<td>
						직원 ID
					</td>
					<td>
						<%=emp.get("empId")%>
					</td>
				</tr>
				<tr>
					<td>
						등급
					</td>
					<td>
						<%=emp.get("grade") %>
					</td>
				</tr>		
				<tr>
					<td>
						직원 이름
					</td>
					<td>
						<%=emp.get("empName") %>
					</td>
				</tr>
				<tr>
					<td>
						담당 업무
					</td>
					<td>
						<%=emp.get("empJob") %>
					</td>
				</tr>
				<tr>
					<td>
						고용일
					</td>
					<td>
						<%=emp.get("hireDate") %>
					</td>
				</tr>		
		<%
			}
		%>
		</table>
	</main>
</body>
</html>