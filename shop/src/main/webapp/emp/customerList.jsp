<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*"%>
<%@ page import="java.util.*"%> 
<%@ page import="java.sql.*" %>
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
	// 고객 리스트 페이징
	// 현재 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 한 페이지에 보여질 상품 개수
	int rowPerPage = 5;
	
	int startRow = (currentPage -1) * rowPerPage;
	
	Connection conn = DBHelper.getConnection();
	
	// 전체 상품 
	String sql = "SELECT count(*) cnt FROM customer";
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
<%
	ArrayList<HashMap<String, Object>> list = CustomerDAO.selectCustomerList(startRow, rowPerPage);
	
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
	<div><jsp:include page="/emp/inc/empMenu.jsp"></jsp:include></div>
	
	<header><h1>고객 리스트</h1></header>
	
	<main class="bg-light">
		<table class="table table-hover shadow rounded">
			<tr>
				<td>메일</td>
				<td>고객명</td>
				<td>생일</td>
				<td>성별</td>
				<td>회원 가입 일자</td>
			</tr>
			<%
				for(HashMap<String, Object> l : list){
			%>
					<tr>
						<td><%=l.get("mail") %></td>
						<td><%=l.get("name") %></td>
						<td><%=l.get("birth") %></td>
						<td><%=l.get("gender") %></td>
						<td><%=l.get("createDate") %></td>
					</tr>
			<%		
				}
			%>
		</table>
	</main>
</body>
</html>