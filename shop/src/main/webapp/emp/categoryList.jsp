<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!-- Controller Layer-->
<%
	System.out.println("----------");
	System.out.println("empList.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") == null) {
		// 로그인이 되지 않았을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>	
<!-- model -->
<%
	Class.forName("org.mariadb.jdbc.Driver");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");

	String sql = "SELECT category, create_date createDate FROM category";
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	
	
	ArrayList<HashMap<String, Object>> categoryList
		= new ArrayList<HashMap<String, Object>>();
	
	while(rs.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("category", rs.getString("category"));
		m.put("createDate", rs.getString("createDate"));
		categoryList.add(m); // 
	}
	
%>
<!-- view -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<div>카테고리 리스트</div>
	<table>
		<thead>
			<tr>
				<th>category</th>
				<th>create date</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(HashMap<String, Object> m : categoryList){
			%>
					<tr>
						<td><%=(String)(m.get("category"))%></td>
						<td><%=(String)(m.get("createDate"))%></td>
						<td><a href="/shop/emp/deleteCategoryAction.jsp?category=<%=(String)(m.get("category"))%>">삭제</a></td>
					</tr>
					
			<%		
				}
			%>
		</tbody>
	</table>
	
	<form method="post" action="/shop/emp/addCategoryAction.jsp"><br>
		<div>제품 카테고리 추가</div>
		category:
		<input type="text" name="addCategory">
		<button type="submit">추가</button>
	</form>
</body>
</html>