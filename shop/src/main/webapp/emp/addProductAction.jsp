<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %> 
<%@ page import="java.nio.file.*" %>
<%@ page import="shop.dao.*" %>
<%

	System.out.println("----------");
	System.out.println("addProductAction.jsp");
	
	request.setCharacterEncoding("UTF-8"); // 대문자 작성 권장
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") == null) {
		// 로그인이 되지 않았을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>	
<!-- Session 설정값 -->
<!-- 입력 시 emp의 emp_id값이 필요함. -->
<%
	// 로그인 세션에서  emp_id 가져오기 
	HashMap<String, Object> loginEmp = (HashMap<String, Object>)session.getAttribute("loginEmp");
    String empId = null;
    if(loginEmp != null) {
        // HashMap에서 empId 값 가져오기
        empId = (String)loginEmp.get("empId");
    }
    
    System.out.println("empId: " + empId);


%>
<!-- Model Layer -->
<%
	String category = request.getParameter("category");
	String productTitle = request.getParameter("productTitle");
	int productPrice = Integer.parseInt(request.getParameter("productPrice"));
	int productAmount = Integer.parseInt(request.getParameter("productAmount"));
	String productContent = request.getParameter("productContent");
	
	System.out.println("category: " + category);
	System.out.println("productTitle: " + productTitle);
	System.out.println("productPrice: " + productPrice);
	System.out.println("productAmount: " + productAmount);
	System.out.println("productContent: " + productContent);

	Part part = request.getPart("productImg");
	String originalName = part.getSubmittedFileName();
	
	// 원본 이름에서 확장자만 분리
	int dotIdx = originalName.lastIndexOf("."); // .의 위치를 찾는다.
	String ext = originalName.substring(dotIdx); // ~.jpg, ~.png 등
	
	// 랜덤 문자 생성
	UUID uuid = UUID.randomUUID(); // 절대 중복될 수 없는 문자가 생성됨
	
	String filename = uuid.toString().replace("-", ""); 
	// UUID를 문자열로 변경 uuid.toString()
	// -를 제외 .replace("-", "")
	
	filename = filename + ext;
	


	
	int row = ProductDAO.insertProduct(category, empId, productTitle, filename, productPrice, productAmount, productContent);
	
	if(row == 1){ // insert 성공 시 -> file upload  
		// part -> 1) is -> 2) os -> 3) 빈 파일
		// 1)
		InputStream is = part.getInputStream();
		// 3) + 2)
		String filePath = request.getServletContext().getRealPath("upload");
		File f = new File(filePath, filename); // os와 합쳐질 빈 파일
		OutputStream os = Files.newOutputStream(f.toPath()); // os + file 
		is.transferTo(os);
	
		os.close();
		is.close();
	}

%>

<!-- Controller Layer -->
<%
	if(row == 1){
		System.out.println("제품 등록 성공");
		response.sendRedirect("/shop/emp/productList.jsp");
	} else {
		System.out.println("제품 등록 실패");
		response.sendRedirect("/shop/emp/addProductForm.jsp");
	}
%>
