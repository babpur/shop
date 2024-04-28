<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*"%>    
<%@ page import="java.util.*"%>
<%@ page import="java.net.*" %>
<%
	System.out.println("--------------------");
	System.out.println("/customer/updateStateAction.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginCustomer
	
	if(session.getAttribute("loginCustomer") == null) {
		// 로그인이 되었을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		return;
	}
%>
<%
	String mail = request.getParameter("mail");

	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String newState = request.getParameter("newState");
	
	System.out.println(mail);
	
	System.out.println(ordersNo);
	System.out.println(newState);
	
	String msg = null;
	
	int row = OrdersDAO.updateStateOrder(ordersNo, newState);
	
	if(row == 1){
		System.out.println("배송 상태 수정 완료");
		msg = URLEncoder.encode("배송 상태 수정에 성공하였습니다.", "UTF-8");
		response.sendRedirect("/shop/customer/ordersListCustomer.jsp?mail=" + mail + "&" + "msg=" + msg);
	} else {
		System.out.println("배송 상태 수정 실패");
		msg = URLEncoder.encode("배송 상태 수정에 실패하였습니다.", "UTF-8");
		response.sendRedirect("/shop/customer/ordersListCustomer.jsp?mail=" + mail + "&" + "msg=" + msg);
		
	}
%>