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
		ResultSet result = null;
	
	   String getBName=request.getParameter("name");	 //책 이름
	   String getBWriter=request.getParameter("writer"); //책 저자
	   String getBPublisher=request.getParameter("publisher");   //출판사	   
	   String getBGenre=request.getParameter("bookgenre");   //책종류 - 수필/시 등..  
	   String getStype=request.getParameter("setScrtype"); //출처 타입(책)
	   
	   Integer getSId=null;
	   
	   if((getBName=="") || (getBWriter=="") || (getBPublisher=="") || (getBGenre==""))
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
			String query = "select count(*) as cnt from source_basic where s_title='" +getBName+"' and s_type='"+getStype+"'";
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
					alert('이미 있는 책제목입니다...');
					location.href="http://localhost:8081/DBclass/Register_source.jsp";
				</script>
				<%
				return;
			}
			else
			{
				
				try{
					//위에서 안닫아줘서 닫아줘야함
					stmt.close();
					
					//Source_basic Table에 삽입
					query="INSERT INTO Source_Basic(s_type,s_title) VALUES('"+getStype+"' , '"+getBName+"')";
					stmt =conn.createStatement();
					stmt.executeUpdate(query);
					stmt.close();
					
					//Source_basic의 auto-increment 형태로 삽입된 primary key s_id를 변수 getSID에 가져옴.
					query="select * from Source_Basic where s_title='"+getBName+"'";
					stmt=conn.createStatement();
					result=stmt.executeQuery(query);
					//s_id primary key 받아오기위해 column 하나 읽음
					result.next();
					getSId=result.getInt("s_id");
					stmt.close();
					
					//Source_Book Table에 위에서 구한 s_id를 source_id로 삽입
					query="INSERT INTO Source_Book(b_writer,b_publisher,b_genre,source_id) VALUES('"+getBWriter+"' , '"+getBPublisher+"' , '" +getBGenre+"','"+getSId+"')";
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