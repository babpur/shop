<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!-- 공통 메뉴 페이지 -->
<!-- include -->

<div>
	<a href="/shop/emp/empList.jsp">사원 관리</a>
	<!-- category CRUD -->
	<a href="/shop/emp/categoryList.jsp">카테고리 관리</a>
	<a href="/shop/emp/productList.jsp">상품 관리</a>
	<%-- <span>
		<a href="/shop/emp/empOne.jsp">
			<%=(loginMember.get("empName"))%> 님
		</a> 반갑습니다.
	</span> --%>
</div>

