<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "shop.dao.*" %>
<%@ page import = "java.net.*" %>
<%
	System.out.println("--------------------");
	System.out.println("dropCustomerAction.jsp");
	
	if(session.getAttribute("loginCustomer") == null) {
		// 로그인이 되었을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		return;
	}
%>

<%
	// customerOne -> dropCustomerAction     
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	
	String errorMsg = null;
	if(pw == null || pw.isEmpty()){
		errorMsg = "비밀번호를 입력해 주세요.";
	}
			
	int row = CustomerDAO.deleteCustomer(mail, pw);
	if(row == 1) {
		// 회원 탈퇴 이후 세션 종료 -> 로그인 폼으로 리다이렉트
		System.out.println("회원 탈퇴 완료");
		session.invalidate();	
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
	} else {
		System.out.println("회원 탈퇴 실패");
		errorMsg = URLEncoder.encode( errorMsg, "utf-8");
		response.sendRedirect("/shop/customer/customerOne.jsp?mail=" + mail + "&" + "errorMsg=" + errorMsg);
		return;
	}
%>