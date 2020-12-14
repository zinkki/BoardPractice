<%@ page import="model.BoardDAO" %>
<%@ page import="model.BoardBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 데이터를 한번에 받아오는 빈클래스를 사용하도록하겠읍니다! -->
	<jsp:useBean id="boardbean" class="model.BoardBean">
		<jsp:setProperty name="boardbean" property="*"/>
	</jsp:useBean>
	
<%	//데이터베이스 객체생성
	BoardDAO bdao = new BoardDAO();
	bdao.reWriteBoard(boardbean);   //BoardDAO에 reWriteBoard()라는 메소드만들기ㅋ.
	
	//답변데이터를 모두 저장한 후 전체 게시글보기를 설정
	response.sendRedirect("boardList.jsp");
	
%>
</body>
</html>