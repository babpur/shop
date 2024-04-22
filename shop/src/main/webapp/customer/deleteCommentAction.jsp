<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*"%>    
<%
	System.out.println("--------------------");
	System.out.println("deleteCommentAction.jsp");
	
	String productNo = request.getParameter("productNo");
	System.out.println("productNo: " + productNo);
	
%>
<%
	int ordersNo = 0;
	int row = CommentDAO.deleteComment(ordersNo);
	if(row == 1) {
		System.out.println("후기 삭제 성공");
	} else {
		System.out.println("후기 삭제 실패");
	}
	response.sendRedirect("/shop/customer/productOne.jsp?productNo=" + productNo);
%>
