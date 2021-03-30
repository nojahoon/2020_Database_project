<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 회원가입 ID 중복조건 확인 및  DB연동 Register -->
	
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		String user_id= request.getParameter("reg_ID");
		String user_pwd= request.getParameter("reg_PWD");
		String user_name= request.getParameter("reg_NAME");
		
	%>
	
	
	<% try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String query = "select count(*) as cnt from user where u_id ='" + user_id + "'";
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			//Statement 생성
			stmt = conn.createStatement();
			//Query 실행
			result = stmt.executeQuery(query);
			result.next();
			
			if(result.getInt("cnt")>0)
			{				
			%>
			<script>
				alert('중복된 아이디입니다.');
				location.href="http://localhost:8081/DBclass/Register.jsp";
			</script>
			<%

			}
			else
			{
				//삽입한부분
				query="insert into user values('"+user_id+"' ,HEX(AES_ENCRYPT('"+user_pwd+"', SHA2('password',512))),'"+user_name+"','0','0')";
				stmt.executeUpdate(query);
				%>
				
				<script>
					alert('등록되었습니다..');
					location.href="http://localhost:8081/DBclass/MainPage.jsp";
				</script>
				
				<%			
 			}//if-else
		}//try
		catch(Exception e) {
			e.printStackTrace();
		} finally {
			if ( result != null ) try{result.close();}catch(Exception e){}
		    if ( stmt != null ) try{stmt.close();}catch(Exception e){}
		    if ( conn != null ) try{conn.close();}catch(Exception e){}
			
		}%>							
</body>
</html>