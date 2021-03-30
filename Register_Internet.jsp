<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인터넷 출처 등록</title>
</head>
<body>
<!-- 인터넷 출처 등록  -->

	
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
	   
	   String getIName=request.getParameter("name");	 //인터넷 이름
	   String getILink=request.getParameter("link"); 		 //사이트 링크
	   
	   String getItype=request.getParameter("setScrtype"); //출처 타입(인터넷)
	   
	   Integer getSId=null;
	   
	   if((getIName=="") || (getILink=="") || (getItype==""))
	   {
	   %>  
	   	   <script>
	   	   	alert('빈 항목이 존재합니다.다시 시도해주세요.');
	   	 	location.href="http://localhost:8081/DBclass/MainPage2.jsp";
		   </script>
	  <%   return;
	   }
	   
	   try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String query = "select count(*) as cnt from source_basic where s_title='" +getIName+"'";
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
					alert('이미 있는 인터넷 홈페이지 출처입니다...');
					location.href="http://localhost:8081/DBclass/MainPage2.jsp";
				</script>
				<%
				return;	
			}
			else
			{
				
				try{
					//Source_basic Table에 삽입
					query="INSERT INTO Source_Basic(s_type,s_title) VALUES('"+getItype+"' , '"+getIName+"')";
					stmt =conn.createStatement();
					stmt.executeUpdate(query);
					stmt.close();
					
					//Source_basic의 auto-increment 형태로 삽입된 primary key s_id를 변수 getSID에 가져옴.
					query="select * from Source_Basic where s_title='"+getIName+"'";
					stmt=conn.createStatement();
					result=stmt.executeQuery(query);
					if(result.next())
						getSId=result.getInt("s_id");
					stmt.close();

					//Source_Internet Table에 삽입
					query="INSERT INTO Source_Internet(in_link,source_id) VALUES('"+getILink+"','"+getSId+"')";
					stmt =conn.createStatement();
					stmt.executeUpdate(query);
					%>
					<script>
						alert('등록되었습니다..');
						location.href="http://localhost:8081/DBclass/MainPage2.jsp";
					</script>
					<%
					stmt.close();
					session.removeAttribute("scrtype");
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