<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>    
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%
	System.out.println("--------------------");
	System.out.println("/emp/ordersList.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") == null) {
		// 로그인이 되었을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	Connection conn = DBHelper.getConnection();
	// order 페이징
%>
<%
	// 현재 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 한 페이지에 출력할 주문 리스트
	int rowPerPage = 10;
	
	// 시작 페이지 = (현재 페이지 -1) * 한 페이지에 출력할 주문 리스트 
	int startRow = (currentPage-1) * rowPerPage;
	
	// 전체 주문의 수
	String sql = "SELECT count(*) cnt FROM emp";
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	
	int totalRow = 0;
	
	if(rs.next()){
		totalRow = rs.getInt("cnt");
	}
	
	// 마지막 페이지 계산하기 = 전체 주문 수 / 한 페이지에서 보이는 주문 수
	int lastPage = totalRow / rowPerPage;
	
	// 나눈 값이 딱 맞게 나누어 떨어지지 않을 때 마지막 페이지 + 1 해 준다. 
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage +1 ;
	}
	
	System.out.println("lastPage: " + lastPage);
	System.out.println("totalRow: " + totalRow);
	System.out.println("rowPerPage: " + rowPerPage);
	System.out.println("startRow: " + startRow);
	System.out.println("rowPerPage: " + rowPerPage);

%>
<!-- empMenu -> orderListAll -->    
<%
	ArrayList<HashMap<String, Object>> list = OrdersDAO.selectOrdersListAll(startRow, rowPerPage);
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
	<header></header>
	
	<main class="bg-light">
		<table class="table table-hover shadow rounded">
			<tr>
				<td>주문 번호</td>
				<td>상품명</td>
				<td>주문 수량</td>
				<td>상품 가격</td>
				<td>주소</td>
				<td>주문 일자</td>
				<td>총 가격</td>
				<td>배송 상태</td>
			</tr>
				<%
					for(HashMap<String, Object> m : list){
				%>
						<tr>
							<td><%=m.get("ordersNo")%></td>
							<td><%=m.get("productNo")%>_<%=m.get("productTitle")%></td>
							<td><%=m.get("totalAmount")%></td>
							<td><%=m.get("totalPrice")%></td>
							<td><%=m.get("address") %></td>
							<td><%=m.get("createDate") %></td>
							<td><%=m.get("totalPrice")%></td>
							<td>
								<form method="post" action="modifyStateAction.jsp">
								<input type="hidden" value="<%=m.get("ordersNo")%>">
								<select name="newState"> 
									<option value="<%=m.get("state")%>" selected="selected">
										<%=m.get("state")%>
									</option>
									<option value="배송 중">
										배송 중
									</option>
								</select>
								<button type="submit"></button>
								</form>
							</td>
						</tr>
				<%		
					}
				%>
		</table>
	</main>
	
</body>
</html>