<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="shop.dao. *" %>
<%
	System.out.println("----------");
	System.out.println("customerOne.jsp");
	
 	// 인증 분기: 세션 변수 이름 - loginCustomer
	if(session.getAttribute("loginCustomer") == null) {
		// 로그인이 되지 않았을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		return;
	} 
%>
<%
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	
	System.out.println("mail: " + mail);
	System.out.println("pw: " + pw);

	ArrayList<HashMap<String, Object>> customerOne = CustomerDAO.selectCustomerOne(mail);
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
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
		color: #000000;
	}
	a:active {
		color: #FFFFFF;
		background-color: #000000;
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
	}
	
	main {
		text-align: center;
		padding: 10px;
	}
	thead {
		font-size: 30px;
	}
	tbody {
		font-size: 20px;
	}
	.form-container {
		justify-content: center;
	}
	.table-content {
		width: 50%;
		height: 70%;
		text-align: center;
		margin: auto;
		align-items: center;
	}
	.card-container {
		margin: 10px;
		text-align: center;
	}
	.card-title {
		text-align: left;
		font-size: 25px;
	}
	.card {
		height: 70vh;
		font-size: 20px;
	}
	h1 {
		margin: 10px;
	}
	</style>
</head>
<body>
	<div><jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include></div>
	<header>
		<h1>회원 상세 정보</h1>
	</header>
	<main class="bg-light">
		<table class="table table-hover shadow rounded">
		<%
			for(HashMap<String, Object> m : customerOne){
			
		%>	
				<tr>
					<td>
						회원 ID
					</td>
					<td>
						<%=m.get("mail")%>
					</td>
				</tr>
				<tr>
					<td>
						회원 이름
					</td>
					<td>
						<%=m.get("name")%>
					</td>
				</tr>		
				<tr>
					<td>
						생년월일
					</td>
					<td>
						<%=m.get("birth")%>
					</td>
				</tr>
				<tr>
					<td>
						성별
					</td>
					<td>
						<%=m.get("gender")%>
					</td>
				</tr>
		<%
			}
		%>
		</table>
		
		<!-- 작업 완료 후 editPwForm.jsp 삭제 -->
		
		<!-- 크기 / 가운데 정렬 후 주석 삭제 -->
		<form method="post" action="/shop/customer/editPwAction.jsp">
		<table>
			<tr>
				<td>PW 수정</td>
			</tr>
			<tr>
				<td><input type="hidden" name="mail" value="<%=mail%>"></td>
			</tr>
			<tr>
				<td><input type="password" name="oldPw" placeholder="현재 pw를 입력해 주세요."></td>
			</tr>
			<tr>
				<td><input type="password" name="newPw" placeholder="변경하실 pw를 입력해 주세요."></td>
			</tr>
			<tr>
				<td>
					<button type="submit">PW 수정</button>
				</td>
			</tr>
		</table>
		</form>		
			
		<form method="post" action="/shop/customer/dropCustomerAction.jsp">
		<table>
			<tr>
				<td colspan="2">회원 탈퇴</td>
			</tr>
			<tr>
				<td>PW 확인</td>
			</tr>
			<tr>
				<td><input type="hidden" name="mail" value="<%=mail%>"></td>
			</tr>
			<tr>
				<td><input type="password" name="pw" placeholder="pw를 입력해 주세요."></td>
			</tr>
			<tr>
			</tr>
			<tr>
				<td>
					<button type="submit">회원 탈퇴</button>
				</td>
			</tr>
		</table>
		</form>		
	</main>
</body>
</html>