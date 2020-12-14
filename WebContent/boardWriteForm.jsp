<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2 align="center">! WRITE ON THE BOARD !</h2>
	<form action="boardrWriteAction.jsp" method="post">
		<table align="center" width="600" border="1">
			<tr height="40">
				<td align="center" width="150">WRITER : </td>
				<td width="450"><input type="text" size="60" name="writer"></td>
			</tr>
			<tr height="40">
				<td align="center" width="150"> TITLE : </td>
				<td width="450"><input type="text" size="60" name="subject"></td>
			</tr>
			<tr height="40">
				<td align="center" width="150"> E-Mail : </td>
				<td width="450"><input type="text" size="60" name="email"></td>
			</tr>
			<tr height="40">
				<td align="center" width="150"> PASS : </td>
				<td width="450"><input type="password" size="60" name="password"></td>
			</tr>
			<tr height="40">
				<td align="center" width="150"> CONTENTS : </td>
				<td width="450"><textarea row="10" cols="60" name="content"></textarea></td>
			</tr>
			<tr height="40">
				<td align="center" colspan="2">
					<input type="reset" value="RESET"> &nbsp;&nbsp;
					<input type="submit" value="WRITE"> &nbsp;&nbsp;
					<button onclick="location.href='boardList.jsp'">LIST</button>
		</table>
	</form>
</body>
</html>