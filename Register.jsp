<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<link rel="stylesheet" href="CSSFile.css">
<style>
table{

	width: 500px;
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
</style>
</head>
<body>
<!-- 회원가입 버튼 누를시 text form에 ID,PWD,이름 입력 -->
	<h1>회원가입 페이지</h1>
	<%  String url = request.getHeader("referer"); 
		String user_id= request.getParameter("reg_ID");
		String user_pwd= request.getParameter("reg_PWD");
		String user_name= request.getParameter("reg_NAME");
	%>
	<a href="MainPage.jsp">뒤로가기</a>
	<br><br>
	<form name="form" method="post" action="Registerok.jsp">
		<table size="1">
			<tr>
				<th>가입Id</th>
				<th>가입 패스워드></th>
				<th>가입자 성함></th>
			<tr>
				<td><input type="text" size="15" name="reg_ID"></td>
				<td><input type="password" size="15" name="reg_PWD"></td>
				<td><input type="text" size="15" name="reg_NAME"></td>
			</tr>
			<input type="submit" name="submit" value="회원가입">
		</table>
	</form>
	
	
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		
		try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String query = "select count(*) as cnt from user where u_id ='"+1234+"'";
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			//Statement 생성
			stmt = conn.createStatement();
			//Query 실행
			result = stmt.executeQuery(query);
			result.next();
			if(result.getInt("cnt")>0){		
				System.out.println("DB내부 접속확인!");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		} finally {
			if ( result != null ) try{result.close();}catch(Exception e){}
		    if ( stmt != null ) try{stmt.close();}catch(Exception e){}
		    if ( conn != null ) try{conn.close();}catch(Exception e){}
			
		}%>				
</body>
</html>