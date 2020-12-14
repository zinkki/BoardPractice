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

	<%
	int board_num = Integer.parseInt(request.getParameter("board_num").trim()); //trim:공백제거 후 정수형으로바꿈 
	// 이걸 위에처럼 캐스팅해줘야됨 
	//String board_num = request.getParameter("board_num");
	
	//데이터베이스 접근
	BoardDAO bdao = new BoardDAO();
	//boardbean타입으로 하나의 게시글을 리턴
	BoardBean bean = bdao.getOneBoard(board_num);
	%>
	
	<h2 align="center">! BOARD INFORMATION !</h2>
	<table align="center" width="600" border="1">
	 <tr height="40">
		<td align="center" width="120">NUMBER</td>
		<td align="center" width="180"> <%=bean.getBoard_num()%></td>
		<td align="center" width="120">VIEW</td>
		<td align="center" width="180"> <%=bean.getReadcount() %></td>
	</tr>
	<tr height="40">
		<td align="center" width="120">WRITER</td>
		<td align="center" width="180"> <%=bean.getWriter() %></td>
		<td align="center" width="120">DATE</td>
		<td align="center" width="180"> <%=bean.getReg_date() %></td>
	</tr>
	<tr height="40">
		<td align="center" width="120">E-MAIL</td>
		<td align="center" colspan="3"><%=bean.getEmail() %></td>
	</tr>
	<tr height="40">
		<td align="center" width="120">TITLE</td>
		<td align="center" colspan="3"><%=bean.getSubject() %></td>
	</tr>
	<tr height="80">
		<td align="center" width="120">CONTENT</td>
		<td align="center" colspan="3"><%=bean.getContent()%></td>
	</tr>
	<tr height="40">
		<td align="center" colspan="4">
			<input type="button" value="reply" 
			onclick="location.href='boardReWriteForm.jsp?board_num=<%=bean.getBoard_num()%>&ref=<%=bean.getRef()%>&re_step=<%=bean.getRe_step()%>&re_level=<%=bean.getRe_level()%>'">
			<input type="button" value="update" onclick="location.href='boardUpdateForm.jsp?board_num=<%=bean.getBoard_num()%>'">
			<input type="button" value="delete" onclick="location.href='boardDeleteForm.jsp?board_num=<%=bean.getBoard_num()%>'">
			<input type="button" value="list" onclick="location.href='boardList.jsp'">
		</td>
	</tr>
	</table>
	
</body>
</html>