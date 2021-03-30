<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Phrase Database</title>
<style>
table{

	width: 250px;
	border-collapse: collapse;
	column-gap: 40px;
}
td,th{
    border-bottom:1px solid black;
    text-align:center;
    padding:3px;
}
th {
    font-style: italic;
    /*font-style: bold;*/
    background-color:#7ec314;
    color:blue;
}
td{
    font-size: oblique;
    background-color:#d4ff00;
    color:black;
}
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
span{
	color:blue;
	font-style:italic;
	font-weight:bold;
}
button{
	background:gray;
}

</style>
</head>
<!-- 실질적으로 로그인 화면페이지 -->
<body>
	<h1>Welcome! Enjoying Database Homework!!</h1>
	
	<form name="form1" method="post" action="CheckingLogin.jsp">
		<table border="1" width=250">
			<tr>
				<td Width=120><span>Id:     <span></td>
				<td width=130><input type="text" size=15 name="setId"></td>
			</tr>
			<tr>
				<td width=120><span>Password: <span></td>
				<td width=130><input type="password" size=15 name="setPwd"></td>
			</tr>
			<tr>
				<td colspan=2 width=120>
					<input type="submit" name="submit" value="로그인!">
				</td>
			</tr>
			<tr>
				<td colspan=2 width=120>
					<a href="Register.jsp">회원가입</a>
				</td>
			</tr>
		</table>				
	</form>
	
<!-- 	<form name="form1" method="post" action="Register.jsp">
		<table border="1" width="130">
			<tr>
				<td width=120><input type="submit" name="submit" value="회원가입">
			</tr>
		</table>
	</form>
 -->	
	
	
</body>

</html>