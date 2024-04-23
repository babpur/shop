<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>


<%
	System.out.println("--------------------");
	System.out.println("/customer/ordersList.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginCustomer
	
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
	System.out.println("loginCustomer: " + loginCustomer);
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
	
	Connection conn = DBHelper.getConnection();
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
<!-- customerOne -> ordersList--> 
<%
	
	ArrayList<HashMap<String, Object>> list = OrdersDAO.selectOrdersListCustomer(startRow, rowPerPage);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div><jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include></div>
	<header></header>
	
	<main>
		<table>
			<tr>
				<td>주문 번호</td>
				<td>상품명</td>
				<td>주문 수량</td>
				<td>상품 가격</td>
				<td>주소</td>
				<td>주문 일자</td>
				<td>배송 상태</td>
				<!-- <td>총 가격</td> -->
			</tr>
			
			<%
				for(HashMap<String, Object> m : list){
			%>
					<tr>
						<td><%=m.get("orderNo")%></td>
						<td><%=m.get("productNo")%>_<%=m.get("productTitle")%></td>
						<td><%=m.get("totalAmount")%></td>
						<td><%=m.get("totalPrice")%></td>
						<td><%=m.get("address") %></td>
						<td><%=m.get("createDate") %></td>
						<td><%=m.get("state")%></td>
						<%-- <td><%=m.get("totalPrice")%></td> --%>
					</tr>
			<%		
				}
			
			%>
		</table>
		
		<!-- 주문 목록에서 '배송 완료'된 상품의 후기 작성하기 -> productOne에서 댓글 확인 -->
		<form method="post" action="/shop/customer/addComment.jsp">
		<h2>상품 구매 후기</h2>
		<table class="table table-hover">
			<tr>
				
				
				<!-- 세션에서 메일 가져오기 -->
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
					<button type="submit">후기 등록</button>
				</td>
			</tr>
		</table>
		</form>
	
	</main>
</body>
</html>