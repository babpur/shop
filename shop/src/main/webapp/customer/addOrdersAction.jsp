<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*"%>
<%@ page import="java.net.*" %>

    
<%
	System.out.println("--------------------");
	System.out.println("/customer/addOrdersAction.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginCustomer
	
	if(session.getAttribute("loginCustomer") == null) {
		// 로그인이 되었을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		return;
	}
%>    
<%
	String mail = request.getParameter("mail");
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	int totalAmount = Integer.parseInt(request.getParameter("totalAmount"));
	String address = request.getParameter("address");
	
	System.out.println("mail: " + mail);
	System.out.println("productNo: " + productNo);
	System.out.println("productPrice: " + productPrice);
	System.out.println("totalAmount: " + totalAmount);
	System.out.println("address: " + address);
%>

	<!-- productList -> productOne -> 'addOrders' -->
<%
	int row = OrdersDAO.insertOrders(mail, productNo, totalAmount, productPrice, address);

	if(row == 1) {
		int amount = 0;
		int updateAmountRow = ProductDAO.updateProductAmount(productNo, amount);
		if(updateAmountRow == 1) {
			amount = totalAmount;
			response.sendRedirect("/shop/customer/orderListCustomer.jsp?mail=" + mail + "&productNo=" + productNo + "&amount=" + amount + "&productPrice=" + productPrice + "&address=" + URLEncoder.encode(address, "UTF-8"));
			System.out.println("상품 수량 업데이트 성공");
			// 구매 성공 시 구매 목록으로 이동
		} else {
			response.sendRedirect("/shop/customer/productOne.jsp?mail=" + mail);
			System.out.println("상품 수량 업데이트 실패");
			// 수량 업데이트 변동 없으면 주문 실패.
		}
		
	} else {
		// 구매 실패 시 상품 상세 정보
		response.sendRedirect("/shop/customer/productOne.jsp?mail=" + mail);
	}
%>