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
<!-- 출처삭제에 대한 변경사항 DB 연동 -->
	
	<% 
	   Connection conn = null;
	   Statement stmt = null;
	   ResultSet result = null;
	   Integer getSId = Integer.parseInt(request.getParameter("setSId"));
	   
		   
	%>
		
	<% try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String query = "";
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			
		
			try{
				query="select count(*) as cnt from phrase where s_id="+getSId;
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
				
				query="select * from source_basic where s_id="+getSId;
				stmt=conn.createStatement();
				result=stmt.executeQuery(query);
				result.next();
				
				stmt.close();
				
				//Source_Basic 테이블에 연결된 Source_Book,Source_Basic,Source_Music,Source_Internet 에서 해당내용 삭제
				
				stmt=conn.createStatement();
				if(result.getString("s_type").equals("음악"))
				{
					query="delete from source_music where source_id="+getSId;
				}
				else if(result.getString("s_type").equals("책"))
				{
					query="delete from source_book where source_id="+getSId;
				}
				
				else if(result.getString("s_type").equals("인터넷"))
				{
					query="delete from source_internet where source_id="+getSId;
				}
				
				else if(result.getString("s_type").equals("영화"))
				{
					query="delete from source_movie where source_id="+getSId;
				}
				else
				{
					%>
					<script>
						alert('정상적으로 작동하지 않습니다. 관리자는 출처타입이 책/인터넷/영화/음악외에 다른요소를 추가했는지 확인하세요.');
						location.href="http://localhost:8081/DBclass/MainPage2.jsp";
					</script>
				<%	return;
				}
				stmt=conn.createStatement();
				stmt.executeUpdate(query);
				stmt.close();
				
				//Source_Baisc 테이블에서 해당내용 삭제
				query="delete from source_basic where s_id="+getSId;
				//Statement 생성
				stmt =conn.createStatement();
				//Query 실행
				stmt.executeUpdate(query);
				stmt.close();
				%>
				<script>
					alert('출처가 정상적으로 삭제되었습니다..');
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
