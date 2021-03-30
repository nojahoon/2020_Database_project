<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출처 수정페이지</title>
<link rel="stylesheet" href="SmallTable.css">
</head>
<body>
<!-- 인물 수정페이지   -->
	
	<h1>인물 수정 페이지</h1>
	<br><br>
	<a href="MainPage2.jsp">뒤로가기</a>
	<br><br>
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		
		try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String query = "select * from person;";
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			//Statement 생성
			stmt = conn.createStatement();
			//Query 실행
			result = stmt.executeQuery(query);
		%>
			<!-- 출처 테이블(Source_basic) 출력 후 해당 출처에 대해 수정/삭제할 수 있는 버튼을 생성 -->
			<table>
					<tr>
						<th>인물 이름</th>
						<th>인물 국적</th>
						<th>인물 카테고리</th>
						<th>인물 실명</th>
						<th>인물 수정</th>
					</tr>
			<%
			while(result.next())
			{  	
				Integer getPId = result.getInt("p_id");
				String getPName= result.getString("p_name");
				String getPNation= result.getString("p_nation");
				String getPCate= result.getString("p_category");
				String getPRName= result.getString("p_rname");
			%>
					<tr>
						<td><%=getPName%></td>
						<td><%=getPNation %></td>
						<td><%=getPCate%></td>					
						<td><%=getPRName%></td>
					
						<td><form name="modify" method="post" action="Modify_person1.jsp">
							<input type="hidden" name="setPId" value=<%=getPId%>>
							<input type="submit" name="submit" value="인물수정">
							</form>
						</td>
					</tr>
		<%	}//while %>
			
			</table>
			
		<%	stmt.close();
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
