<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃 페이지</title>
</head>
<body>
	<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet result = null;
	String getId= request.getParameter("setId");
	String getPwd= request.getParameter("setPwd");
	
		try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String query="select count(*) as cnt from user" + " where u_id='"+ getId +"'and u_pwd=HEX(AES_ENCRYPT('"+getPwd+"', SHA2('password',512)));";
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			
			//Statement 생성
			stmt = conn.createStatement();
			result=stmt.executeQuery(query);
			result.next();
			
			if(result.getInt("cnt")>0)
			{
				session.setAttribute("loginId",getId);
		%>
				<script>
					alert('로그인 성공!');
					location.href="http://localhost:8081/DBclass/MainPage2.jsp";
				</script>
	<%  	}
			else
			{
	%>
				<script>
					alert('로그인에 실패하셨습니다.');
					location.href="http://localhost:8081/DBclass/MainPage.jsp";
				</script>
	<% 			
				System.out.println("로그인 실패!!");
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}finally{
			if ( result != null ) try{result.close();}catch(Exception e){}
		     if ( stmt != null ) try{stmt.close();}catch(Exception e){}
		     if ( conn != null ) try{conn.close();}catch(Exception e){}
		}
		%>
</body>
</html>