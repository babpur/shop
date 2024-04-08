<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	System.out.println("--------------------");
	System.out.println("addCustomerForm.jsp");
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
</head>
<body>
	<div class="commBar bg-dark bg-gradient">
		 <a href="/shop/customer/customerLoginForm.jsp">
			<img class="shop-logo" src="/shop/img/shopLogo1.png">
		</a>
	</div>
	<header>
		<h1>회원 가입</h1>
	</header>
	<main>
		<form method="post" action="addCustomerAction.jsp">
			<table>
				<tr>
					<td>
						<label for="customerName">이름</label>
					</td>
					<td>
						<input type="text" id="customerName" name="customerName">
					</td>
				</tr>
				<tr>
					<td>
						<label for="customerEmail">E-Mail</label>
					</td>
					<td>
						<input type="email" id="customerEmail" name="customerEmail" placeholder="로그인 ID입니다.">
					</td>
				</tr>
				<tr>
					<td>
						<label for="customerPw">비밀번호</label>
					</td>
					<td>
						<input type="password" id="customerPw" name="customerPw">
					</td>
				</tr>
				<tr>
					<td>
						<label for="customerBirth">생년월일</label>
					</td>
					<td>
						<input type="date" id="customerBirth" name="customerBirth">
					</td>
				</tr>
				<tr>
					<td>
						<label for="customerGender">성별</label>
					</td>
					<td>
						<input type="radio" id="customerGender" name="customerGender" value="남"> 남
						<input type="radio" id="customerGender" name="customerGender" value="여"> 여
					</td>
				</tr>
			</table>
		<button type="submit">회원 가입</button>
		</form>
	</main>
</body>
</html>