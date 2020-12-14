<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2 align="center">WRITE REPLY</h2>
	
<%
	//게시글읽기(boardInfo.jsp)에서 답변쓰기(reply)를 클릭하면 넘겨주는 데이터들을 받아줌!
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	int ref = Integer.parseInt(request.getParameter("ref"));
	int re_step = Integer.parseInt(request.getParameter("re_step"));
	int re_level = Integer.parseInt(request.getParameter("re_level"));
%>

	<form action="boardReWriteAction.jsp" method="post">
	<table align="center" width="600" border="1">
		<tr height="40" align="center">
			<td align="center" width="150">WRITER</td> 
			<td align="center" width="450"><input type="text" name="writer" size="60"></td>
		</tr>
		<tr height="40" align="center">
			<td align="center" width="150">TITLE</td> 
			<td align="center" width="450"><input type="text" name="subject" value="[Re]"size="60"></td>
		</tr>
		<tr height="40" align="center">
			<td align="center" width="150">E-MAIL</td> 
			<td align="center" width="450"><input type="text" name="email" size="60"></td>
		</tr>
		<tr height="40" align="center">
			<td align="center" width="150">PASSWORD</td> 
			<td align="center" width="450"><input type="password" name="password" size="60"></td>
		</tr>
		<tr height="40" align="center">
			<td align="center" width="150">CONTENT</td> 
			<td align="center" width="450"><input type="text" name="content" size="60"></td>
		</tr>
		<!-- form에서 사용자로부터 입력받지 않고 데이터를 넘겨보겠음 -->
		<tr height="40">
			<td align="center" colspan="2">
			<input type="hidden" name="ref" value="<%=ref %>">
			<input type="hidden" name="re_step" value="<%=re_step %>">
			<input type="hidden" name="re_level" value="<%=re_level %>">
			<input type="submit" value="Reply Complete"> &nbsp;&nbsp;
			<input type="reset" value="Cancel">&nbsp;&nbsp;
			<input type="button" value="LIST" onclick="location.href='boardList.jsp'"></td>
		</tr>
	</table>
	</form>
</body>
</html>