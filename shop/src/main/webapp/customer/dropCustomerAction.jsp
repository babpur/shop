<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	System.out.println("--------------------");
	System.out.println("dropCustomerAction.jsp");
	
	if(session.getAttribute("loginCustomer") == null) {
		// �α����� �Ǿ��� �� productList.jsp�� �����̷�Ʈ�ϰڴ�.
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		return;
	}
%>

<%
	// customerOne -> dropCustomerAction     

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>