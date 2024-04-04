<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!-- controller -->
<%
	System.out.println("----------");
	System.out.println("productList.jsp");
	
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
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
%>
<%
	// 현재 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	
	// 한 페이지에 보여질 상품 개수
	int rowPerPage = 20;
	
	int startRow = (currentPage -1) * rowPerPage;
	
	// 전체 상품 
	String sql1 = "SELECT count(*) cnt FROM product";
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null; 
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setInt(1, startRow);
	stmt1.setInt(2, rowPerPage);

	System.out.println("stmt1: " + stmt1);
	
	rs1 = stmt1.executeQuery();
	
	int totalRow = 0;
	
	if(rs1.next()){
		totalRow = rs1.getInt("cnt");
	}
	
	// 마지막 페이지 계산하기 = 전체 상품 수량 / 한 페이지에서 보일 상품의 수량
	int lastPage = totalRow / rowPerPage;
	
	// 수량이 딱 맞게 나누어 떨어지지 않을 때 마지막 페이지 + 1 해 준다. 
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage +1 ;
	}
	
	System.out.println("lastPage: " + lastPage);
	System.out.println("totalRow: " + totalRow);
	System.out.println("rowPerPage: " + rowPerPage);
	System.out.println("startRow: " + startRow);
	System.out.println("rowPerPage: " + rowPerPage);
	
	
%>
<!-- model -->
<%
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null; 

	String sql2 ="SELECT category, COUNT(*) cnt FROM product GROUP BY category ORDER BY category asc;";
	
	stmt2 = conn.prepareStatement(sql2);
	
	System.out.println("stmt2: " + stmt2);
	
	rs2 = stmt2.executeQuery();
	
	ArrayList<HashMap<String, Object>> categoryList = 
			new ArrayList<HashMap<String, Object>>();
	while(rs2.next()){
		HashMap<String, Object> m1 = new HashMap<String, Object>();
		m1.put("category", rs2.getString("category"));
		m1.put("cnt", rs2.getInt("cnt"));
		categoryList.add(m1);
	}

	String category = request.getParameter("category");
	System.out.println("category: " + category);

	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	
	String sql3 = null;

	/*
		null이면
		select * from product
		null이 아니면
		selecet * from product where category=?
	*/
	if(category == null){
		sql3 = "SELECT * FROM product ORDER BY product_no DESC LIMIT ?, ?";
		stmt3 = conn.prepareStatement(sql3);
		stmt3.setInt(1, startRow);
	    stmt3.setInt(2, rowPerPage);
	} else {
		sql3 = "SELECT * FROM product WHERE category= ? ORDER BY product_no DESC LIMIT ?, ?";
		stmt3 = conn.prepareStatement(sql3);
		stmt3.setString(1, category);
	    stmt3.setInt(2, startRow);
	    stmt3.setInt(3, rowPerPage);
	}
	System.out.println("stmt3: " + stmt3);
	
	rs3 = stmt3.executeQuery();
	
	ArrayList<HashMap<String, Object>> productList = 
			new ArrayList<HashMap<String, Object>>();
	while(rs3.next()){
		HashMap<String, Object> m2 = new HashMap<String, Object>();
		m2.put("product_no", rs3.getInt("product_no"));
		m2.put("category", rs3.getString("category"));
		m2.put("product_price", rs3.getInt("product_price"));
		m2.put("product_amount", rs3.getInt("product_amount"));
		m2.put("create_date", rs3.getString("create_date"));
		productList.add(m2);
	}

%>
<!-- view -->
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
	.navHead {
		color: #FFFFFF;
		font-size: 30px;
	}
	</style>
</head>
<body>
	<!-- main menu -->
	<div><jsp:include page="/emp/inc/empMenu.jsp"></jsp:include></div>
	
	<div>
		<a href="/shop/emp/addProductForm.jsp">상품 등록</a>
	</div>
	
	<!-- sub menu: 카테고리별 상품 리스트 -->
	<div>
		<a href="/shop/emp/productList.jsp">전체 상품</a>
		<%
			for(HashMap m1 : categoryList){
		%>
				<a href="/shop/emp/productList.jsp?category=<%=(String)(m1.get("category"))%>">
					<%=(String)(m1.get("category"))%>
					(<%=(Integer)(m1.get("cnt"))%>)
				</a>		
		<%		
				
			}
		%>
		
		<!-- 상품 리스트 -->
		
		
		
		<!-- 카드 bootstrap -->
		<!-- <div class="card" style="width: 18rem;">
		<img src="..." class="card-img-top" alt="...">
			<div class="card-body">
				<h6 class="card-title"></h6>
				<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
				<a href="#" class="btn btn-primary">Go somewhere</a>
			</div>
		</div> -->
		
		
		
		
		
		
		
		<table class="table table-hover shadow rounded">
		<thead>
			<tr>
				<th>product_no</th>
				<th>category</th>
				<th>product_price</th>
				<th>product_amount</th>
				<th>create_date</th>
			</tr>
		</thead>
		<tbody>	
			<%
				for(HashMap<String, Object> m2 : productList){
			%>
					<tr>
						<td><%=(Integer)(m2.get("product_no"))%></td>
						<td><%=(String)(m2.get("category"))%></td>
						<td><%=(Integer)(m2.get("product_price"))%></td>
						<td><%=(Integer)(m2.get("product_amount"))%></td>
						<td><%=(String)(m2.get("create_date"))%></td>
					</tr>
			<%		
				}
			%>
		</tbody>
		</table>
		<!-- 페이징 -->
		<nav aria-label="Page navigation"><br>
			<ul class="pagination justify-content-center">
				<%
					if (currentPage > 1) {
				%>
						<li class="page-item">
							<a class="page-link" href="/shop/emp/productList.jsp?currentPage=1">처음</a>
						</li>
						<li class="page-item">	 
							<a class="page-link" href="/shop/emp/productList.jsp?currentPage=<%=currentPage-1%>">이전</a>
						</li>
				<%
					} else {
				%>	
						<li class="page-item disabled">
							<a class="page-link" href="/shop/emp/productList.jsp?currentPage=1">처음</a>
						</li>
						<li class="page-item disabled">
							<a class="page-link" href="/shop/emp/productList.jsp?currentPage=<%=currentPage-1%>">이전</a>
						</li>
				<%		
					}
				
					if(currentPage < lastPage) {
				%>
						<li class="page-item">
							<a class="page-link" href="/shop/emp/productList.jsp?currentPage=<%=currentPage+1%>">다음</a>
						</li>
						<li class="page-item">
							<a class="page-link" href="/shop/emp/productList.jsp?currentPage=<%=lastPage%>">마지막</a>
						</li>
				<%		
					} else {
				%>
						<li class="page-item disabled">
							<a class="page-link" href="/shop/emp/productList.jsp?currentPage=<%=currentPage+1%>">다음</a>
						</li>
						<li class="page-item disabled">
							<a class="page-link" href="/shop/emp/productList.jsp?currentPage=<%=lastPage%>">마지막</a>
						</li>
				<%		
					}
				%>
			</ul>
		</nav>
	</div>
</body>
</html>