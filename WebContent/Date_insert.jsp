<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2 align="center">SYS DATE INSERT TEST!</h2>
<form action="Date_insertAction.jsp" method="post">
<table align="center" border="1">
	<tr height="40">
		<td width="30" align="center">WHAT : </td>
		<td width="40" align="center">
		<input type="text" size="20" name="what">
		</td>
	</tr>
	<tr height="40">
		<td width="30" align="center">NUM : </td>
		<td width="40" align="center">
		<input type="text" size="20" name="num">
		</td>
	</tr>
	<tr height="40">
		<td align="center" colspan="2">
		<input type="submit" value="submit">
		</td>
	</tr>
</table>
</form>
</body>
</html>