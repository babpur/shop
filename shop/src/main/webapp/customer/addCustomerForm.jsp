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
</head>
<body>
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