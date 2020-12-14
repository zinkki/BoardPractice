<%@ page import="model.BoardBean" %>
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
		BoardDAO bdao = new BoardDAO();
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		//하나의 게시글을 리턴(boardUpdqte할때 썼던 메소드 getOneUpdateBoard()이거 재활용할거임) 
		BoardBean bean = bdao.getOneUpdateBoard(board_num);
	%>
	
	<h2 align="center">! DELETE !</h2>
	<form action="boardDeleteAction.jsp" method="post">
	<table border="1" align="center">
		<tr height="40">
			<td width="120" align="center">WRITER</td>
			<td width="180" align="center"><%=bean.getWriter() %></td>
			<td width="120" align="center">DATE</td>
			<td width="180" align="center"><%=bean.getReg_date()%></td>
		</tr>
		<tr height="40">
			<td width="120" align="center">TITLE</td>
			<td align="left" colspan="3"><%=bean.getSubject() %></td>
		</tr>
		<tr height="40">
			<td width="120" align="center">PASSWORD</td>
			<td align="left" colspan="3"><input type="password" name="password" size="60"></td>
		</tr>
		<tr height="40">
			<td align="center" colspan="4">
				<input type="hidden" name="board_num" value="<%=board_num %>">
				<input type="submit" value="DELETE"> &nbsp; &nbsp;
				<input type="button" onclick="location.href='boardList.jsp'" value="LIST">
			</td>
		</tr>
	</table>
	</form>

</body>
</html>