<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	System.out.println("----------");
	System.out.println("addProductForm.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") == null) {
		// 로그인이 되지 않았을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>	
<%
	Class.forName("org.mariadb.jdbc.Driver");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null; 
	
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");

	String sql ="SELECT category from category";
	
	stmt = conn.prepareStatement(sql);
	
	System.out.println("stmt: " + stmt);
	
	rs = stmt.executeQuery();
	
	ArrayList<String> categoryList = 
			new ArrayList<String>();
	while(rs.next()){
		categoryList.add(rs.getString("category"));
	}
%>
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
	h1 {
		text-align: center;
		margin-bottom: 30px;
		font-size: 70px;
		margin-top: 30px;
	}
	main {
		text-align: center;
		padding: 30px;
		
	}
	th {
		font-size: 30px;
	}
	td {
		font-size: 20px;
		text-align: left;
		margin-left: 30px;
	}
	</style>
</head>
<body>
	<!-- main menu -->
	<div><jsp:include page="/emp/inc/empMenu.jsp"></jsp:include></div>
	<header>
		<h1>상품 등록</h1>
	</header>
	<main class="bg-light">
		<form method="post" action="/shop/emp/addProductAction.jsp"
				enctype="multipart/form-data">
			<table class="table table-hover shadow rounded">
				<tr>
					<th>카테고리</th>
					<td>
						<select name="category">
							<option value="">선택</option>
								<%
									for(String c : categoryList){
								%>
										<option value="<%=c%>"><%=c%></option>
								<%		
									}
								%>
							</select>
					</td>
				</tr>
				<!-- emp_id값은 세션 변수에서 바인딩 from action-->
				<tr>
					<th>제품명</th>
					<td>
						<input type="text" name="productTitle">
					</td>
				</tr>		
				<tr>
					<th>제품 이미지</th>
					<td>
						<input type="file" name="productImg">
					</td>
				</tr>
				<tr>
					<th>제품 가격</th>
					<td><input type="number" name="productPrice"></td>
				</tr>
				<tr>
					<th>제품 수량</th>
					<td><input type="number" name="productAmount"></td>
				</tr>
				<tr>
					<th>제품 정보</th>
					<td>
						<textarea type="text" row="5" cols="50" name="productContent"></textarea>
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<button type="submit" class="btn btn-secondary">상품 등록</button>
						<button type="reset" class="btn btn-secondary">초기화</button>
					</th>
				</tr>
			</table>
		</form>
	</main>
</body>
</html>