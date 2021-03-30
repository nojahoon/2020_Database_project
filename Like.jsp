<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문구 좋아요페이지</title>
</head>
<body>
<!-- 문구에 대한 좋아요로 인한 변경사항 DB 연동 -->
	
	<% 
		Connection conn = null;
		Statement stmt = null;
		//ResultSet result = null;
		
		String u_id=(String)session.getAttribute("loginId");
	    Integer ph_id=Integer.parseInt(request.getParameter("setPh_Id"));	//수정할 phrase id정보
	  
	   
	 %>  
	
	<% try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			//원래 좋아요 버튼을 누를때마다 문구의 테이블의  ph_like +1
			String query = "UPDATE phrase SET ph_like=ph_like+1 WHERE ph_id="+ph_id;
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			//Statement 생성
			stmt = conn.createStatement();
			//Query 실행
			stmt.executeUpdate(query);
			
			
			stmt.close();
			
			//문구를 좋아하였을때 해당 문구를 등록한 사용자의 점수 u_score도 +1
			query="UPDATE user set u_score=u_score+1 where u_id='"+u_id+"'";
			stmt=conn.createStatement();
			stmt.executeUpdate(query);
		
			%>
				<script>
					alert('해당 문구를 좋아요하였습니다!');
					location.href="http://localhost:8081/DBclass/MainPage2.jsp";
				</script>
			<%
		
				//result.close();
			stmt.close();
			conn.close();
				
		}catch(SQLException e){
			out.println("Insert Error: " + e.getMessage() + "<br>");
			
			
		}
		catch(Exception e) {
			e.printStackTrace();
		} finally {
			/* if ( result != null ) try{result.close();}catch(Exception e){}*/ // resultset 불필요함. 좋아요 수만 +1 update만하기때문에.
		    if ( stmt != null ) try{stmt.close();}catch(Exception e){}
		    if ( conn != null ) try{conn.close();}catch(Exception e){}
			
		}%>				
</body>
</html>