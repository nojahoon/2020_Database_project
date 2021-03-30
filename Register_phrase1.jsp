<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문구 등록하기</title>
</head>
<body>
<!-- 문구 중복검사 및 DB 연동 등록 -->
	
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
	   String getUId=(String)session.getAttribute("loginId");
	   String getPId=request.getParameter("person");	//인물의 정보를 담는 primary key s_id radio 형식으로 받아옴
	   String getSId=request.getParameter("source");;	//출처의 정보를 담는 primary key s_id radio 형식으로 받아옴
		
	   String getPHContent = request.getParameter("content");
	   String getPHCategory = request.getParameter("category");
	   
	   String getPHDescription= request.getParameter("description");
	   String getPHIsopen= request.getParameter("isopen");
	   Integer isopen=null;
	   Integer p_id=null;
	   if(getPHIsopen.equals("PRIVATE"))
		   isopen=0;
	   if(getPHIsopen.equals("PUBLIC"))
		   isopen=1;
	   
	   if(getPId==null)
	   {
		   %>  
		   	   <script>
		   	   	alert('인물을 선택하지 않으셨습니다!');
		   	 	location.href="http://localhost:8081/DBclass/Register_phrase.jsp";
			   </script>
		   <%
		   return;
		}
	   if(getSId==null)
	   {
		   %>  
		   	   <script>
		   	   	alert('출처를 선택하지 않으셨습니다!');
		   	 	location.href="http://localhost:8081/DBclass/Register_phrase.jsp";
			   </script>
		   <%   
		  return;
		}
	   
	   if(getPHContent==null || getPHCategory==null || getPHDescription==null || getPHIsopen==null)
	   {
		   %>  
		   	   <script>
		   	   	alert('빈 항목이 존재합니다.다시 시도해주세요.');
		   	 	location.href="http://localhost:8081/DBclass/Register_phrase.jsp";
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
				//문구를 DB에 저장하는 부분
				query="INSERT INTO phrase(ph_content,ph_category,ph_description,ph_like,ph_isopen,u_id,p_id,s_id) VALUES('"+getPHContent+"' , '"+getPHCategory+"' , '" +getPHDescription+"','0' ,'" +isopen+"','"+getUId+"','"+getPId+"','"+getSId+"')";
				stmt =conn.createStatement();
				stmt.executeUpdate(query);
				
				stmt.close();
				
				//사용자 문구 등록시 사용자 점수+5
				query="UPDATE USER SET u_score=u_score+5 WHERE u_id='"+getUId+"'";
				stmt=conn.createStatement();
				stmt.executeUpdate(query);
				stmt.close();
				%>
				<script>
					alert('문구가 등록되었습니다..');
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