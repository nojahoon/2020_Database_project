<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인물등록하기</title>
<link rel="stylesheet" href="CSSFile_Register.css">
<style>
body{
	font: 'NanumGothic';
	background-color:#a5f4f1;
}

p{
  color: red;
  font-family: courier;
  font-size: 130%;
  border:10px solid brown;
}
h1{

   font-size: 40px;
   text-align:center;
   color: #eb4655;
}
h2{
   color: red;
}
</style>
</head>
<body>
<!-- 인물 등록  -->

	
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
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
		
	
	<h1>인물 등록페이지</h1>
	<br><br>
	<br><br>
	
	<a href="MainPage2.jsp">뒤로가기</a>
	<br><br>
	<br><br>
	
	<form name="reg" method="post" action="Register_person1.jsp">
			<table>
				<tr>
					<th>인물 이름</th>
					<th>인물 국적</th>
					<th>인물 카테고리</th>
					<th>인물 실명</th>
				</tr>
				<tr>
					<td><input type="text" value="" name="name"></td>
					<td><input type="text" value="" name="nation"></td>
					<td>
						<select name="category">
					        <option>일반인</option>
					        <option>연예인</option>
					        <option>가상인물</option>
					        <option>미상</option>
			   			</select>
				    </td>					
					<td><input type="text" value="" name="r_name"></td>
				</tr>
			</table>	
		<input type="submit" name="enroll_p" value="인물등록">
	</form>

</body>
</html>