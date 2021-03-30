<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그아웃 페이지</title>
</head>
<body>
	<%
	session.removeAttribute("loginId");
	response.sendRedirect("http://localhost:8081/DBclass/MainPage.jsp");
	%>
</body>
</html>