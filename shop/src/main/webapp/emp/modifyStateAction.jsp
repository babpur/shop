<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*"%>
<%
	System.out.println("----------");
	System.out.println("modifyStateAction.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") == null) {
		// 로그인이 되지 않았을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>    
<%
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String newState = request.getParameter("newState");

	System.out.println("ordersNo: " + ordersNo);
	System.out.println("newState: " + newState);
	
	int row = OrdersDAO.updateStateOrderEmp(ordersNo, newState);
	if(row == 1) {
		System.out.println("state 배송 중으로 변경 완료");
	} else {
		System.out.println("state 배송 중으로 변경 실패");
	}
	response.sendRedirect("/shop/emp/orderList.jsp");	
%>    