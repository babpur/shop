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
	<!-- bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<!-- bootstrap -->
	<style>
	@font-face {
		/* 고령딸기체 */	
	    font-family: 'GoryeongStrawberry';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-01@1.0/GoryeongStrawberry.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
	}
	a {
		text-decoration: none;
	}
	a:link {
		color: #000000;
	}
	a:visied {
		color: #000000;
	}
	a:hover {
		color: #FFFFFF;
	}
	a:active {
		color: #FFFFFF;
	}
	body {
		/* 고령딸기체 전체 적용 */	
	    font-family: 'GoryeongStrawberry';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-01@1.0/GoryeongStrawberry.woff2') format('woff2');
	    font-weight: normal;
	    font-style: normal;
	    
	    /* https://kor.pngtree.com/back/down?id=MTE1NzkyMA==&type=1&time=1712045765&token=YzUyZTdlMThlZmE0N2MxY2YxMDQ5NTI4OGE4OWRhYjA=&t=0 */
	    background-image: url("/shop/img/backgroundLoginForm.png");
	    background-position: center;
		background-repeat: no-repeat;
		background-size: cover;
		height: 100vh;
	}
	</style>
</head>
<body>
	<div><jsp:include page="/emp/inc/empMenu.jsp"></jsp:include></div>
	<main>
	<h1>카테고리 목록</h1>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>카테고리</th>
				<th>게시일</th>
				<th>&nbsp;</th>
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
		<label for="addCategory">제품 카테고리</label>
		<input type="text" name="addCategory" id="addCategory">
		<button type="submit">추가</button>
	</form>
	</main>
</body>
</html>