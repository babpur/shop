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
	<title>Insert title here</title>
	
	
</head>
<body>
	<header>상품 상세 정보</header>

	<table>
	
		<!--  -->
		<%
			for(HashMap<String, Object> p : productOne) {
		%>
	
				<tr>
					<td>productNo</td>
					<td><%="p.get(productNo)"%></td>
				</tr>
				<tr>
					<td>category</td>
					<td><%="p.get(category)" %></td>
				</tr>
				<tr>
					<td>empId</td>
					<td><%="p.get(empId)" %></td>
				</tr>
				<tr>
					<td>productTitle</td>
					<td><%="p.get(productTitle)" %></td>
				</tr>
				<tr>
					<td>productContent</td>
					<td><%="p.get(productContent)" %></td>
				</tr>
				<tr>
					<td>productPrice</td>
					<td><%="p.get(productPrice)" %></td>
				</tr>
				<tr>
					<td>productAmount</td>
					<td><%="p.get(productAmount)" %></td>
				</tr>
				<tr>
					<td>updateDate</td>
					<td><%="p.get(updateDate)" %></td>
				</tr>
				<tr>
					<td>createDate</td>
					<td><%="p.get(createDate)" %></td>
				</tr>
		<%		
			}
		%>
	</table>
</body>
</html>