<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*"%>

<%
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String content = request.getParameter("content");
	int score = Integer.parseInt(request.getParameter("score"));
	
	int row = CommentDAO.insertComment(score, content);
	if(row == 1 ){
		System.out.println("후기 작성 성공");
	} else {
		System.out.println("후기 작성 실패");
	}
	response.sendRedirect("/shop/customer/productONe.jsp?productNo=" + productNo);
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>