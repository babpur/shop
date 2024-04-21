<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*"%>

<!-- Controller Layer-->
<%
	System.out.println("----------");
	System.out.println("/emp/productOne.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") == null) {
		// 로그인이 되지 않았을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	int productNo = Integer.parseInt(request.getParameter("productNo"));

	System.out.println("productNo: " + productNo);
	
	ArrayList<HashMap<String, Object>> productOne = ProductDAO.selectProductOneByEmp(productNo);
%>
	
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>productList</title>
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
	}
	
	main {
		text-align: center;
		padding: 10px;
	}
	head {
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
	.card-container {
		margin: 10px;
		text-align: center;
	}
	.card-title {
		text-align: left;
		font-size: 25px;
	}
	.card {
		height: 70vh;
		font-size: 20px;
	}
	h1 {
		margin: 10px;
	}
	img {
		width: 200px;
		height: 500px;
	}
	</style>
	
	
</head>
<body>
	<div><jsp:include page="/emp/inc/empMenu.jsp"></jsp:include></div>
	<header>
		<h1>상품 상세 정보</h1>
	</header>
	
	<main class="bg-light">
		<table class="table table-hover shadow rounded">
		
			<!--  -->
			<%
				for(HashMap<String, Object> p : productOne) {
			%>
					<tr>
						<td rowspan="9">
							<%
								if((String)(p.get("imagePath")) == null ){
							%>
									<img src='/shop/upload/default.jpg' class="card-img-top p-2" alt="...">
							<%		
									
								} else {
							%>
									<img src='<%=request.getContextPath()%>/upload/<%=(String)(p.get("imagePath"))%>' class="card-img-top p-2" alt="...">
							<%		
								}
							%>
						</td>
						<td>productNo</td>
						<td><%=p.get("productNo")%></td>
					</tr>
					<tr>
						<td>category</td>
						<td><%=p.get("category")%></td>
					</tr>
					<tr>
						<td>empId</td>
						<td><%=p.get("empId")%></td>
					</tr>
					<tr>
						<td>productTitle</td>
						<td><%=p.get("productTitle")%></td>
					</tr>
					<tr>
						<td>productContent</td>
						<td><%=p.get("productContent")%></td>
					</tr>
					<tr>
						<td>productPrice</td>
						<td><%=p.get("productPrice")%></td>
					</tr>
					<tr>
						<td>productAmount</td>
						<td><%=p.get("productAmount")%></td>
					</tr>
					<tr>
						<td>updateDate</td>
						<td><%=p.get("updateDate")%></td>
					</tr>
					<tr>
						<td>createDate</td>
						<td><%=p.get("createDate")%></td>
					</tr>
			<%		
				}
			%>
		</table>
	</main>
</body>
</html>