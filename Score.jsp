<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 점수확인 페이지</title>
<link rel="stylesheet" href="CSSFile.css">
</head>
<body>
<!-- 사용자의 점수확인 페이지   -->
<%
	if(session.getAttribute("loginId")!=null)
	{
	%>
		환영합니다! <%=session.getAttribute("loginId")%>님!
<%  }
	else
	{
	%>	<script>
			alert('잘못된 접근입니다!');
			location.href="http://localhost:8081/DBclass/MainPage2.jsp";
		</script>
	<%
	}
%>
	
	
	<button type ="button" onclick="location.href='http://localhost:8081/DBclass/LogoutPage.jsp'"> 로그아웃 </button>
	<button type ="button" onclick="location.href='http://localhost:8081/DBclass/Score.jsp'"> 내점수보기 </button>	
	<h1> 사용자 점수확인 페이지</h1>
	<a href="MainPage2.jsp">뒤로가기</a>
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		String getUId=(String)session.getAttribute("loginId");
	   
	  
	   
	%>
	<% try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String query = "select u_score from user where u_id='"+getUId+"';";
			Integer rank=1;
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			//Statement 생성
			stmt = conn.createStatement();
			//Query 실행
			result = stmt.executeQuery(query);
			
			if(result.next())
			{
				Integer getScore=result.getInt("u_score");
				%>
				<br><br>
				
				<div>회원님의 점수는 <%=getScore%> 점입니다!</div>
				<br><br>
				<% 
			}
			else
			{
				%>
				<script>
					alert('Login session이 잘 동작하고있지않음!! 프로그램 이상한상태!');
					location.href="http://localhost:8081/DBclass/MainPage2.jsp";
				</script>
			<% 	
			}
			stmt.close();
			
			query="select * from user order by u_score DESC;";
			stmt=conn.createStatement();
			result=stmt.executeQuery(query);
			
			%>
			
			<!-- 유저들의 랭킹을 보여주는 테이블 시작되는 곳 -->
			<table>
			<tr>
				<th>순위</th>
				<th>유저 ID</th>
				<th>이름</th>
				<th>점수</th>
			</tr>
			<%
			//테이블의 내용으로 검색결과를 td로 넣어줌.
			while(result.next())
			{
				String getId=result.getString("u_id");
				String getUName=result.getString("u_name");
				Integer getScore=result.getInt("u_score");	
			%>
			<tr>
				<td><%=rank%></td>
				<td><a href="Search_phrase_byId.jsp?setUId=<%=getId%>"><%=getId%></a></td>
				<td><%=getUName%></td>
				<td><%=getScore%></td>
			</tr>
				<%
				rank=rank+1;
			}
			%>
			<!-- while문이 끝나고 table 태그를 닫아줌. -->
			</table>
			<%
			
			stmt.close();
		
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