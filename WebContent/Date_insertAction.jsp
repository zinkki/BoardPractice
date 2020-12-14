<%@ page import="date_insertExample.DateInsertDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="dbean" class="date_insertExample.DateBean">
		<jsp:setProperty name="dbean" property="*"/>
	</jsp:useBean>
<%
	DateInsertDAO didao = new DateInsertDAO();
	didao.insertDate(dbean);
	response.sendRedirect("Date.jsp");
%>
</body>
</html>