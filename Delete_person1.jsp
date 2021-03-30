<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인물 삭제하기</title>
</head>
<body>
<!-- 인물삭제에 대한 변경사항 DB 연동 -->
	
	<% 
	   Connection conn = null;
	   Statement stmt = null;
	   ResultSet result = null;
	   Integer getPId = Integer.parseInt(request.getParameter("setPId"));
	   
		   
	%>
		
	<% try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String query = "";
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			
		
			try{
				query="select count(*) as cnt from phrase where p_id="+getPId;
				//Statement 생성
				stmt =conn.createStatement();
				//Query 실행
				result=stmt.executeQuery(query);
				result.next();
				if(result.getInt("cnt")>0)
				{
					%>
					<script>
						alert('해당 인물에 연결된 문구가 존재합니다. 삭제되지 않습니다.');
						location.href="http://localhost:8081/DBclass/MainPage2.jsp";
					</script>
					
		<% 	
					return;
				}
				result.close();
				stmt.close();
				
				
				query="delete from person where p_id="+getPId;
				//Statement 생성
				stmt =conn.createStatement();
				//Query 실행
				stmt.executeUpdate(query);
				
				%>
				<script>
					alert('인물이 삭제되었습니다..');
					location.href="http://localhost:8081/DBclass/MainPage2.jsp";
				</script>
				<%
				
			}catch(SQLException e){
				out.println("Insert Error: " + e.getMessage() + "<br>");
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
