<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문구 삭제페이지</title>
</head>
<body>
<!-- 문구 삭제페이지  -->
	
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		
		Integer getPhId= Integer.parseInt(request.getParameter("setPh_Id"));
		String getUId=request.getParameter("setU_Id");
		String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
		String dbUser = "root";
		String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
		String query = "";
		//DB Connection 생성
		conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
		
		//해당 문구를 등록한사람과 다른사람이 삭제를 시도할 경우 삭제권한 없음.
		if (!(getUId.equals(session.getAttribute("loginId"))))
		{
		%>
			<script>
				alert('문구의 주인이 아니십니다. 삭제권한이 없습니다!');
				location.href="http://localhost:8081/DBclass/MainPage2.jsp";
			</script>
		<%	return;
		}
	%>
	
	
	<% try {
			query = "DELETE FROM phrase where ph_id='"+getPhId+"'";
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			//Statement 생성
			stmt = conn.createStatement();
			//Query 실행
			stmt.executeUpdate(query);
			%>
			<script>
				alert('삭제되었습니다.');
				location.href="http://localhost:8081/DBclass/MainPage2.jsp";
			</script>
	<% 		
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