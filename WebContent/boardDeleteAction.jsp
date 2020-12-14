<%@ page import="model.BoardDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String pass = request.getParameter("password");
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		BoardDAO bdao = new BoardDAO();
		String password = bdao.getPass(board_num);
		
		//기존 패스워드값과 boardDeleteForm.jsp에서 작성한 패스워드를 비교한다
		if(pass.equals(password)){
			//패스워드가 같다면! boardDAO에 deleteBoard()>>글삭제메소드 생성후 호출하기!
			bdao.deleteBoard(board_num); 
			
			response.sendRedirect("boardList.jsp");
		} else {
	%>	
		<script>
		alert("PASSWORD IS INCORRECT!");
		histry.go(-1);
		</script>
		
	<%
	}
	%>
</body>
</html>