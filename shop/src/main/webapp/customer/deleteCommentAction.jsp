<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*"%>    
<%
	System.out.println("--------------------");
	System.out.println("deleteCommentAction.jsp");

	// 인증 분기: 세션 변수 이름 - loginCustomer

	if(session.getAttribute("loginCustomer") != null) {
	// 로그인이 되지 않았을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/productList.jsp");
		return;
	}
 %>

<%
	String mail = request.getParameter("mail");
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	
	System.out.println("mail " + mail);
	System.out.println("productNo: " + productNo);
	System.out.println("ordersNo: " + ordersNo);
	
	int row = CommentDAO.deleteComment(ordersNo);
	
	if(row == 1) {
		System.out.println("후기 삭제 성공");
		response.sendRedirect("/shop/customer/productList.jsp");
	} else {
		System.out.println("후기 삭제 실패");
		response.sendRedirect("/shop/customer/productOne.jsp?productNo=" + productNo);
	}
%>
