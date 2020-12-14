<%@ page import ="model.BoardDAO" %>
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
	<h2 align="center">UPDATE BOARD</h2>
<%
	//해당게시글 번호를 통해 게시글을 수정하겟다11
	int board_num = Integer.parseInt(request.getParameter("board_num").trim());

	//하나의 게시글의 대한 정보를 리턴!하겠ㄷ다ㅏ
	BoardDAO bdao = new BoardDAO();
	BoardBean bean = bdao.getOneUpdateBoard(board_num);
%>
<form action="boardUpdateAction.jsp" method="post">
	<table align="center" width="600" border="1">
		<tr height="40">
			<td width="120" align="center">WRITER</td>
			<td width="180" align="center"><%=bean.getWriter() %></td>
			<td width="120" align="center">DATE</td>
			<td width="180" align="center"><%=bean.getReg_date() %></td>
		</tr>
		<tr height="40">
			<td width="120" align="center">TITLE</td>
			<td width="180" colspan="3">&nbsp; <input type="text" name="subject" value="<%=bean.getSubject() %>" size="60"></td>
		</tr>      
		<tr height="40">
			<td width="120" align="center">PASSWORD</td>
			<td width="480" colspan="3"> &nbsp; <input type="password" name="password" size="60"></td>
		</tr>
		<tr height="40">
			<td width="120" align="center">CONTENT</td>
			<td width="480" colspan="3"><textarea rows="10" cols="60" name="content" align="left"><%=bean.getContent() %></textarea></td>
		</tr>
		<tr height="40">
			<td colspan="4" align="center">
				<input type="hidden" name="board_num" value="<%=bean.getBoard_num() %>">
				<input type="submit" value="Update"> &nbsp; &nbsp;
				<input type="button" value="List" onclick="location.href='boardList.jsp'">
			</td>
		</tr>
	</table>
</form>
</body>
</html>