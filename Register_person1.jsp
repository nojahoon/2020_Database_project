<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인물 등록하기</title>
</head>
<body>
<!-- 인물 중복검사 및 DB 연동 등록 -->
	
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
	  
	   
	   String getname= request.getParameter("name");
	   String getnation= request.getParameter("nation");
	   String getcate= request.getParameter("category");
	   String getrname= request.getParameter("r_name");
	   
	   if(getname=="" || getnation=="" || getcate=="" || getrname=="")
	   {
	   %>  
	   	   <script>
	   	   	alert('빈 항목이 존재합니다.다시 시도해주세요.');
	   	 	location.href="http://localhost:8081/DBclass/Register_person.jsp";
		   </script>
	  <%   
	   	return;
	   }
	%>
	
	
	
	<% try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String query = "select count(*) as cnt from person where p_name='" +getname+"'";
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
					alert('이미 있는 인물의 이름입니다...');
					location.href="http://localhost:8081/DBclass/Register_person.jsp";
				</script>
				<%
				System.out.println("cnt>0");
			}
			else
			{
				
				try{
					
					stmt.close();
					
					query="INSERT INTO person(p_name,p_nation,p_category,p_rname) VALUES('"+getname+"' , '"+getnation+"' , '"+getcate+"' , '" +getrname+"')";
					stmt =conn.createStatement();
					stmt.executeUpdate(query);
					
					//out.println("Insert ok! <br>");
					%>
					<script>
						alert('등록되었습니다..');
						location.href="http://localhost:8081/DBclass/MainPage2.jsp";
					</script>
					<%
					result.close();
					stmt.close();
					conn.close();
				}catch(SQLException e){
					out.println("Insert Error: " + e.getMessage() + "<br>");
				}
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