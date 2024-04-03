<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!-- 공통 메뉴 페이지 -->
<%
	System.out.println("----------");
	System.out.println("empMenu.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		// 로그인이 되지 않았을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<!-- session -->	
<%
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
	String empName = null;
	if(loginEmp != null) {
	    // HashMap에서 empName 값 가져오기
	    empName = (String)loginEmp.get("empName");
	}
	
	System.out.println("empName: " + empName);
	
%>
<!-- include -->

<div>
	<a href="/shop/emp/empList.jsp">사원 관리</a>
	<!-- category CRUD -->
	<a href="/shop/emp/categoryList.jsp">카테고리 관리</a>
	<a href="/shop/emp/productList.jsp">상품 관리</a>
	<span>
		<a href="/shop/emp/empOne.jsp"><%=empName%> 님</a> 반갑습니다
	</span> 
</div>

