<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*"%>
<%@ page import="java.net.*"%>
<!-- Controller Layer -->
<%
	System.out.println("--------------------");
	System.out.println("addCommentAction.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginCustomer
	
	if(session.getAttribute("loginCustomer") != null) {
	// 로그인이 되지 않았을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/productList.jsp");
		return;
	}
	
	// productOne -> addCommentAction으로 넘어온 값
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String content = request.getParameter("content");
	String scoreStr = request.getParameter("score");
	
	// 디버깅
	System.out.println("ordersNo: " + ordersNo);
	System.out.println("productNo: " + productNo);
	System.out.println("content: " + content);
	System.out.println("score: " + scoreStr);
	
	// 댓글 내용이 null이거나 공백일 경우, errorMsg를 반환
	String errorMsg = null;
	int score = 0;
	if(content == null || content.isEmpty() || scoreStr == null || scoreStr.isEmpty() ) {
		errorMsg = "내용을 입력해 주세요";
	}
	
	// score를 str로 받은 뒤 null이 아닐 경우 int로 강제 형 변환
	if(scoreStr != null) {
		score = Integer.parseInt(scoreStr);
	}
%>
<!-- Model Layer -->
<%
	int row = 0;
	if(content != null) {
		row = CommentDAO.insertComment(ordersNo, score, content);
		if(row == 1 ){
			System.out.println("후기 작성 성공");
		} else {
			System.out.println("후기 작성 실패");
			errorMsg = URLEncoder.encode( errorMsg, "utf-8");
			response.sendRedirect("/shop/customer/productList.jsp?productNo=" + productNo + "&" + "errorMsg=" + errorMsg);
		}
		response.sendRedirect("/shop/customer/productList.jsp?productNo=" + productNo);
	}
	response.sendRedirect("/shop/customer/productList.jsp?productNo=" + productNo);
%>    