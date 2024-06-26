<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="shop.dao.*" %>
<%
	System.out.println("--------------------");
	System.out.println("/customer/productList.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginCustomer
	
	if(session.getAttribute("loginCustomer") == null) {
		// 로그인이 되었을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		return;
	}
%>
<%
	// 현재 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 한 페이지에 보여질 상품 개수
	int rowPerPage = 5;
	
	int startRow = (currentPage -1) * rowPerPage;
	
	String category = request.getParameter("category");
	System.out.println("category:" + category);
	
	Connection conn = DBHelper.getConnection();
	// 전체 상품 
	String sql = "SELECT count(*) cnt FROM product ";
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	stmt = conn.prepareStatement(sql);

	System.out.println("stmt: " + stmt);
	
	rs = stmt.executeQuery();
	
	int totalRow = 0;
	
	if(rs.next()){
		totalRow = rs.getInt("cnt");
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
ArrayList<HashMap<String, Object>> subMenuList = ProductDAO.selectSubMenuList();

ArrayList<HashMap<String, Object>> productList = ProductDAO.selectProductCustomerList(startRow, rowPerPage);

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
	</style>
</head>
<body>
	<!-- main menu -->
	<div><jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include></div>
	
	<!-- sub menu: 카테고리별 상품 리스트 -->
	<div>
		<a href="/shop/customer/productList.jsp">전체 상품</a>
		<%
			for(HashMap s : subMenuList){
		%>
				<a href="/shop/customer/productList.jsp?category=<%=(s.get("category"))%>">
					<%=(s.get("category"))%>
					(<%=(s.get("cnt"))%>)
				</a>		
		<%		
				
			}
		%>
	</div>
	<header>
		<h1>상품 리스트</h1>
	</header>
	<main>
		<div class="d-flex flex-row flex-wrap justify-content-center">
			<%
				for(HashMap<String, Object> p : productList){
			%>
					<div class="card-container">
						<div class="card" style="width: 23rem;">
							<h6 class="card-title m-3"><%=(p.get("productNo")) + "_" + (p.get("category"))%></h6>
							<%
								if((p.get("imagePath")) == null ){
							%>
									<img src='/shop/upload/default.jpg' class="card-img-top p-2" alt="...">
							<%		
									
								} else {
							%>
									<img src='<%=request.getContextPath()%>/upload/<%=(String)(p.get("imagePath"))%>' class="card-img-top p-2" alt="...">
							<%		
								}
							%>
							<div class="card-body">
								<p class="card-text"><%=(p.get("productTitle"))%></p>
								<p class="card-text">
									제품 소개: 
										<%
											String productContent = (String)(p.get("productContent")); 
											if(productContent.length() > 20){
										%>
												<br>								
												<%=productContent.substring(0, 20)%><span>...</span>
										<%		
											} else {
										%>
												<%=productContent%>								
										<%
										
											}
										%>
								</p>
								<p class="card-text">남은 수량: <%=(p.get("productAmount"))%></p>
								<p class="card-text">금액: <%=(p.get("productPrice"))%></p>
								<a href="/shop/customer/productOne.jsp?productNo=<%=p.get("productNo")%>&productPrice=<%=p.get("productPrice") %>" class="btn btn-outline-secondary">제품 상세 보기</a>
							</div>
						</div>
					</div>
			<%		
				}
			%>
						
		</div>
		
		<!-- 페이징 -->
		<nav aria-label="Page navigation"><br>
			<ul class="pagination justify-content-center ">
				<%
					if (currentPage > 1) {
				%>
						<li class="page-item">
							<a class="page-link btn btn-secondary" href="/shop/customer/productList.jsp?currentPage=1&category=<%=category%>">처음</a>
						</li>
						<li class="page-item">	 
							<a class="page-link btn btn-secondary" href="/shop/customer/productList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">이전</a>
						</li>
				<%
					} else {
				%>	
						<li class="page-item disabled">
							<a class="page-link btn btn-secondary" href="/shop/customer/productList.jsp?currentPage=1&category=<%=category%>">처음</a>
						</li>
						<li class="page-item disabled">
							<a class="page-link btn btn-secondary" href="/shop/customer/productList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">이전</a>
						</li>
				<%		
					}
				
					if(currentPage < lastPage) {
				%>
						<li class="page-item">
							<a class="page-link btn btn-secondary" href="/shop/customer/productList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">다음</a>
						</li>
						<li class="page-item">
							<a class="page-link btn btn-secondary" href="/shop/customer/productList.jsp?currentPage=<%=lastPage%>&category=<%=category%>">마지막</a>
						</li>
				<%		
					} else {
				%>
						<li class="page-item disabled">
							<a class="page-link btn btn-secondary" href="/shop/customer/productList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">다음</a>
						</li>
						<li class="page-item disabled">
							<a class="page-link btn btn-secondary" href="/shop/customer/productList.jsp?currentPage=<%=lastPage%>&category=<%=category%>">마지막</a>
						</li>
				<%		
					}
				%>
			</ul>
		</nav>
	</main>
</body>
</html>