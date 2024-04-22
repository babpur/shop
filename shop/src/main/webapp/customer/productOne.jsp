<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<%
	System.out.println("--------------------");
	System.out.println("/customer/productOne.jsp");
	
	// 고객 login 인증 분기
	
	if(session.getAttribute("loginCustomer") == null) {
		// 로그인이 되었을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		return;
	}
	
%>
<%
	HashMap<String, Object> loginCustomer = (HashMap<String, Object>)session.getAttribute("loginCustomer");
	String mail = null;
	if(loginCustomer != null) {
	    // HashMap에서 customerName 값 가져오기
		mail = (String)loginCustomer.get("mail");
	}
	
	System.out.println("mail: " + mail);
%>

<%
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	
	System.out.println("productNo: " + productNo);
	
	ArrayList<HashMap<String, Object>> productOne = ProductDAO.selectProductOneByCustomer(productNo);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<body>
	<div><jsp:include page="/emp/inc/empMenu.jsp"></jsp:include></div>
	<header>
		<h1>상품 상세 정보</h1>
	</header>
	<a href="/shop/customer/productList.jsp">뒤로 가기</a>
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
						<td>createDate</td>
						<td><%=p.get("createDate")%></td>
					</tr>
			<%		
				}
			%>
		</table>
		
		<h2>상품 주문하기</h2>
		<form method="post" action="/shop/customer/addOrders.jsp?">
		<table>
			<tr>
				<td>
					<input type="hidden" value="<%=mail%>">
				</td>
				<td>
					<input type="hidden" value="<%=mail%>">
				</td>
			</tr>
		
			<tr>
				<td>
					<label>주문 수량</label>
				</td>
				<td>
					<input type="number" name="ordersAmount">
				</td>
			</tr>
			<tr>
				<td>
					<label>
						배송지 입력
					</label>
				</td>
				<td>
					<input type="number" name="ordersAmount">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">상품 주문하기</a>
				</td>		
			</tr>
		</table>
		</form>


		<form method="post" action="/shop/customer/addComment.jsp">
		<h2>상품 구매 후기</h2>
		<table class="table table-hover">
			<tr>
				<td><input type="hidden" value='<%=productNo%>'></td>
				<td><%=mail%></td>
				<td>
					<textarea rows="5" cols="30" name="content"></textarea>
				</td>
				<td>
					상품 구매 후기
					<select name="score">
						<!-- test -->
						<!-- 까먹지 말고 반복문으로 바꾸기 -->
						<option value="">=== 선택 ===
						<option value="1">1
						<option value="2">2
						<option value="3">3
						<option value="4">4
						<option value="5">5
						<option value="6">6
						<option value="7">7
						<option value="8">8
						<option value="9">9
						<option value="10">10
					</select>
					<button type="submit">댓글 등록</button>
					<button type="button" oneclick="/shop/customer/productOne.jsp?productNo<%=productNo%>&">후기 삭제</button>
				</td>
			</tr>
		</table>
		</form>
	</main>
</body>
</html>
</body>
</html>