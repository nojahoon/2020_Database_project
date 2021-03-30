<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>책 출처 등록</title>
</head>
<body>
<!-- 책 출처 등록  -->

	
	<% 
	   Connection conn = null;
	   Statement stmt = null;
		//ResultSet result = null;
	
	   String getMName=request.getParameter("name");	//영화이름
	   String getMDir=request.getParameter("director");  //감독이름
	   String getMActor=request.getParameter("actor");  //영화배우
	   String getMDate=request.getParameter("date");  //개봉날짜
	   String getMGenre=request.getParameter("genre");  //영화 장르
	   
	   String getStype=request.getParameter("setScrtype");
			    
	   Integer getSId=Integer.parseInt(request.getParameter("setSId"));
	   
	   if((getMName=="") || (getMDir=="") || (getMActor=="") || (getMDate=="")||(getMGenre==""))
	   {
	   %>  
	   	   <script>
	   	   	alert('빈 항목이 존재합니다.다시 시도해주세요.');
	   	 	location.href="http://localhost:8081/DBclass/MainPage2.jsp";
		   </script>
	  <%   return;
	   }
	  
	   if(getStype==null)
	   {
		  %><script>
	   	   	alert('출처 타입을 불러오지 못했습니다.다시 시도해주세요.');
	   	 	location.href="http://localhost:8081/DBclass/MainPage2.jsp";
		   </script>
		  <%
		   return;
	   }
	   try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String query="";
			conn=DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			
			//Source_basic Table에 출처 업데이트
			query="update Source_Basic set s_title='"+getMName+"' where s_id="+getSId;
			stmt =conn.createStatement();
			stmt.executeUpdate(query);
			stmt.close();
			
		
			
			//Source_Bove Table에 위에서 구한 s_id를 source_id로 삽입
			query="update Source_Movie set mo_director='"+getMDir+"' , mo_actor='"+getMActor+"',mo_date='"+getMDate+"' , mo_genre = '"+getMGenre+"'where source_id="+getSId;
			stmt =conn.createStatement();
			stmt.executeUpdate(query);
			%>
			<script>
				alert('수정되었습니다..');
				location.href="http://localhost:8081/DBclass/MainPage2.jsp";
			</script>
			<%
			stmt.close();
			
			}catch(SQLException e){
				out.println("Insert Error: " + e.getMessage() + "<br>");
			}finally {
			//if ( result != null ) try{result.close();}catch(Exception e){}
		    if ( stmt != null ) try{stmt.close();}catch(Exception e){}
		    if ( conn != null ) try{conn.close();}catch(Exception e){}
			
		}%>				
	

</body>
</html>