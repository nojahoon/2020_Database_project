<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 전체 문구 Private화</title>
</head>
<body>
<!--나의 전체 문구 Private화 -->

	
	<% 
	   Connection conn = null;
	   Statement stmt = null;
	   //ResultSet result = null;
	
			    
	   String getUId=(String)session.getAttribute("loginId");
	   
	   try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String query="UPDATE phrase set ph_isopen=0 WHERE u_id='"+getUId+"';";
			conn=DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			stmt =conn.createStatement();
			stmt.executeUpdate(query);
			
			//result.close();
			stmt.close();
			conn.close();
			%>
			<script>
				alert('나의 문구 전체가 Private으로 변경되었습니다.');
				location.href="http://localhost:8081/DBclass/Manage_phrase.jsp";
			</script>
			<% 
			}catch(SQLException e){
				out.println("Insert Error: " + e.getMessage() + "<br>");
			}finally {
			//if ( result != null ) try{result.close();}catch(Exception e){}
		    if ( stmt != null ) try{stmt.close();}catch(Exception e){}
		    if ( conn != null ) try{conn.close();}catch(Exception e){}
			
		}%>				
	

</body>
</html>