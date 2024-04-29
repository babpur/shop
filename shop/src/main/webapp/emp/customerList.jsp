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
<title>Insert title here</title>
</head>
<body>
	<header><h1>고객 리스트</h1></header>
	
	<main>
		<table>
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