<%@ page import ="model.BoardDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 사용자데이터를 읽어드리는 빈클래스를 설정합니당 -->
	<jsp:useBean id="boardbean" class="model.BoardBean">
		<jsp:setProperty name="boardbean" property="*"/>
	</jsp:useBean>
	
	<%
		BoardDAO bdao = new BoardDAO();
		//해당게시글의 패스워드값을 얻어오는 getPass() 메소드를 BoardDAO클래스에 생성하고 호출해주깅
		String pass = bdao.getPass(boardbean.getBoard_num());
		
		//기존패스워드값과 update(글수정)시에 작성했던 패스워드값이 같은지 비교해야됨!
		if(pass.equals(boardbean.getPassword())) { //일치하면!
			//BoardDAO클래스에 데이터 수정하는 메소드 updateBoard()만들고 호출해주기 
			bdao.updateBoard(boardbean);
			//수정완려되면 전체게시글리스트로 가게하기
			response.sendRedirect("boardList.jsp");
		} else {//패스워드가 일치하지 않으면!!
	%>
		<script type="text/javascript">
		alert("PASSWORD IS INCORRECT!")
		history.go(-1);
		</script>
				
	<%
		}
	%>
	
	
</body>
</html>