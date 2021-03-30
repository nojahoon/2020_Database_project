<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인물 수정하기</title>
</head>
<body>
<!-- 인물 수정에 대한 변경사항 DB 연동 -->
	
	<% 
	   Connection conn = null;
	   Statement stmt = null;
	   ResultSet result = null;
	   Integer getPId = Integer.parseInt(request.getParameter("setPId"));
	   
	   String getPName= request.getParameter("name");
	   String getPNation= request.getParameter("nation");
	   String getPCate= request.getParameter("category");
	   String getPRName= request.getParameter("r_name");
	   
	   if(getPName==null || getPNation==null || getPCate==null || getPRName==null)
	   {
	   %>  
	   	   <script>
	   	   	alert('빈 항목이 존재합니다.수정이 되지않습니다.');
	   	 	location.href="http://localhost:8081/DBclass/MainPage2.jsp";
		   </script>
	   <%
	  		return;
	   }
		   
	%>
		
	<% try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String query = "";
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			//Statement 생성
			stmt = conn.createStatement();
			//Query 실행
			
		
			try{
				query="update person set p_name='"+getPName+"' ,p_nation='"+getPNation+"',p_category='"+getPCate+"',p_rname='"+getPRName+"' where p_id="+getPId;
				stmt =conn.createStatement();
				stmt.executeUpdate(query);
				
				
				%>
				<script>
					alert('인물이 수정되었습니다..');
					location.href="http://localhost:8081/DBclass/MainPage2.jsp";
				</script>
				<%
		
				stmt.close();
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
