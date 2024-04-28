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
	int totalPrice = productPrice * totalAmount;
	String address = request.getParameter("address");
	
	System.out.println("mail: " + mail);
	System.out.println("productNo: " + productNo);
	System.out.println("productPrice: " + productPrice);
	System.out.println("totalAmount: " + totalAmount);
	System.out.println("address: " + address);
%>

	<!-- productList -> productOne -> 'addOrders' -->
<%	
	String msg = null;

	
	int row1 = OrdersDAO.insertOrders(mail, productNo, totalAmount, productPrice, address);
	int row2 = ProductDAO.updateProductAmount(productNo, totalAmount);
	
	// row1과 row2가 둘 다 실행된다면 상품 주문 성공
	if(row1 == 1 && row2 == 1) {
			System.out.println("상품 주문 성공");
			msg = URLEncoder.encode("상품 주문에 성공하였습니다.", "UTF-8");
			response.sendRedirect("/shop/customer/ordersListCustomer.jsp?mail=" + mail + "&" + "msg=" + msg);
			// 구매 성공 시 구매 목록으로 이동
		} else {
			System.out.println("상품 주문 실패");
			msg = URLEncoder.encode("상품 주문에 실패하였습니다.", "UTF-8");
			response.sendRedirect("/shop/customer/productOne.jsp?productNo="+ productNo + "msg= " + msg);
		}
%>