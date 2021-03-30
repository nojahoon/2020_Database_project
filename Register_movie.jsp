<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 출처 등록</title>
</head>
<body>
<!-- 영화 출처 등록  -->

	
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
	  
	   
	   String getMName=request.getParameter("name");	//영화이름
	   String getMDir=request.getParameter("director");  //감독이름
	   String getMActor=request.getParameter("actor");  //영화배우
	   String getMDate=request.getParameter("date");  //개봉날짜
	   String getMGenre=request.getParameter("genre");  //영화 장르
	   
	   String getStype=request.getParameter("setScrtype");
	   
	   Integer getSId=null;
	   
	   if((getMName=="") || (getMDir=="") || (getMActor=="") || (getMDate=="") || (getMGenre=="") || (getStype==""))
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
			String query = "select count(*) as cnt from source_basic where s_title='" +getMName+"'";
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
					alert('이미 있는 영화제목입니다...');
					location.href="http://localhost:8081/DBclass/MainPage2.jsp";
				</script>
				<%
				return;
			}
			else
			{
				
				try{
					
					stmt.close();
					//Source_basic Table에 삽입
					query="INSERT INTO Source_Basic(s_type,s_title) VALUES('"+getStype+"' , '"+getMName+"')";
					stmt =conn.createStatement();
					stmt.executeUpdate(query);
					stmt.close();
					
					
					//Source_basic의 auto-increment 형태로 삽입된 primary key s_id를 변수 getSID에 가져옴.
					query="select * from Source_Basic where s_title='"+getMName+"'";
					stmt=conn.createStatement();
					result=stmt.executeQuery(query);
					result.next();
						getSId=result.getInt("s_id");
					result.close();
					stmt.close();
					
					//Source_Movie Table에 삽입
					query="INSERT INTO Source_Movie(mo_director,mo_actor,mo_date,mo_genre,source_id) VALUES('"+getMDir+"' , '"+getMActor+"' , '" +getMDate+"', '" +getMGenre+"', '"+getSId+"')";
					stmt =conn.createStatement();
					stmt.executeUpdate(query);
					%>
					<script>
						alert('등록되었습니다..');
						location.href="http://localhost:8081/DBclass/MainPage2.jsp";
					</script>
					<%
					//stmt.close();
					
					session.removeAttribute("sourcetype");
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