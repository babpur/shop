<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("--------------------");
	System.out.println("customerLoginForm.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginCustomer
	
	if(session.getAttribute("loginCustomer") != null) {
		// 로그인이 되었을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/productList.jsp");
		return;
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
	main {
		text-align: center;
		padding: 10px;
		height: 80vh;
	}
	head {
	}
	h1 {
		text-align: center;
		margin-bottom: 30px;
		font-size: 70px;
		margin-top: 30px;
	}
	thead {
		font-size: 30px;
	}
	tbody {
		font-size: 20px;
	}
	.form-container {
		justify-content: center;
		padding: 30px;
	}
	.table-content {
		text-align: center;
		margin: auto;
		align-items: center;
		background-color: #FFFFFF;
		width: 25%;
		padding: 20px;
	}
	table {
		font-size: 40px;
	}
	button {
		width: 40%;
		font-size: 30px;
	}
	.shop-logo {
		height: 50px;
		width: 50px;
	}
	.commBar {
		height: 50px;
		background-color: navy;
		display: flex;
		font-size: 20px;
	}			
	.button-size {
		width: 50%;
	}	
	</style>
</head>
<body>
	<div class="commBar bg-dark bg-gradient">
		 <a href="/shop/customer/customerLoginForm.jsp">
			<img class="shop-logo" src="/shop/img/shopLogo1.png">
		</a>
	</div>
	<header>
		<h1>로그인</h1>
	</header>
	<main>
		<div class="formContainer">
			<form method="post" action="/shop/customer/customerLoginAction.jsp">
				<div class="loginInputForm">
					<table class="table table-hover table-content shadow rounded">
						<tr>
							<th>
								<label for="mail" >E-MAIL</label>
							</th>
							<td>
								<input type="text" name="mail" id="mail" placeholder="아이디를 입력해 주세요">
							</td>
						</tr>
						<tr>
							<th>
								<label for="pw">PW</label>
							</th>
							<td>
								<input type="password" name="pw" placeholder="비밀번호를 입력해 주세요">
							</td>
						</tr>
						
						<tr>
							<td colspan="2">
								<button type="submit" class="btn btn-secondary button-size">로그인</button>
								&nbsp;
								<a class="btn btn-outline-secondary" href="/shop/customer/addCustomerForm.jsp">
									회원 가입
								</a>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
		<button type="button" onclick="location.href='/shop/emp/empLoginForm.jsp'">직원 로그인 전환</button>
	</main>
</body>
</html>