<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공개범위 전체관리페이지</title>
<link rel="stylesheet" href="CSSFile.css">
</head>
<body>
<!-- 공개범위 전체관리페이지  -->
<%
	if(session.getAttribute("loginId")!=null)
	{
	%>
		환영합니다! <%=session.getAttribute("loginId")%>님!
<%  }
	else
	{
	%>	<script>
			alert('잘못된 접근입니다!');
			location.href="http://localhost:8081/DBclass/MainPage2.jsp";
		</script>
	<%
	}
%>
	
	
	<button type ="button" onclick="location.href='http://localhost:8081/DBclass/LogoutPage.jsp'"> 로그아웃 </button>
	<button type ="button" onclick="location.href='http://localhost:8081/DBclass/Score.jsp'"> 내점수보기 </button>	
	<h1>공개범위 전체관리페이지</h1>
	<br><br>
	<a href="MainPage2.jsp">뒤로가기</a>
	<br><br>
	
	<button type ="button" onclick="location.href='http://localhost:8081/DBclass/Manage_open_public.jsp'">내 문구 전체 Public </button>
	<button type ="button" onclick="location.href='http://localhost:8081/DBclass/Manage_open_private.jsp'">내 문구 전체 Private </button>
	<br>
	<br>
	
</body>
</html>
