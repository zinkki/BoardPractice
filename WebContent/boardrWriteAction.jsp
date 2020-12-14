<%@ page import = "model.BoardDAO" %>
<%@ page import = "model.BoardBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	 <!-- 게시글 작성한 데이터를 한번에 읽어드리는 방법!!!!가장중요하당. -->
	 <jsp:useBean id="boardbean" class="model.BoardBean">
	 	<jsp:setProperty name="boardbean" property="*" />
	 </jsp:useBean>
	 
	 <%
	 	//데이터베이스 쪽으로 빈클래스를 넘겨줌.
	 	BoardDAO bdao = new BoardDAO();
	 
	 	//데이터 저장 메소드 호출!
	 	bdao.insertBoard(boardbean);
	 	
	 	//게시글 저장후 전체 게시글리스트보기
	 	response.sendRedirect("boardList.jsp");
	 %>
	
</body>
</html>