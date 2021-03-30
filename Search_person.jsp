<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인물 검색결과</title>
<link rel="stylesheet" href="SmallTable.css">
</head>
<style>
body{
	font: 'NanumGothic';
	background-color:#a5f4f1;
}

p{
  color: red;
  font-family: courier;
  font-size: 130%;
  border:10px solid brown;
}
h1{

   font-size: 40px;
   text-align:center;
   color: #eb4655;
}
h2{
   color: red;
}
</style>
<body>
<!-- 인물 검색결과   -->
	<h1>인물 검색결과 페이지</h1>
	<br><br>
	<a href="MainPage2.jsp">뒤로가기</a>
	<br><br>
	<h2>검색 결과</h2>
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		String getPName= request.getParameter("Pname");
		String getPNation= request.getParameter("Pnation");
		String getPCategory= request.getParameter("Pcategory");
		String getPRealname=request.getParameter("Prealname");
		
		if((getPName.equals("")))
		{
			%>
			<script>
				alert('인물의 이름은 반드시 적은 후  다시 검색해주세요.');
				location.href="http://localhost:8081/DBclass/Manage_person.jsp";
			</script>
	<%		
		}
	%>
	
	
	<% try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String queryBasic = "Select * from person where p_name='"+getPName+"'"+" and p_category='"+getPCategory+"'";
			
			String queryNation=" and p_nation='"+getPNation+"'";
			String queryRealName=" and p_rname='"+getPRealname+"'";
			
			//전부 기입하여 검색
			if(!(getPName).equals("") && (!(getPNation).equals("")) && (!(getPCategory).equals(""))&& (!(getPRealname).equals("")) )
			{	
				queryBasic=queryBasic+queryNation+queryRealName+";";
			}
			//실명만 미기입하고 검색
			else if((!(getPNation).equals(""))&&(!(getPCategory).equals(""))&&((getPRealname).equals("")) )
			{
				queryBasic=queryBasic+queryNation+";";
			}
			//국적만 미기입하고 검색
			else if((getPNation).equals("")&&(!(getPRealname).equals("")))
			{
				queryBasic=queryBasic+queryRealName+";";
			}
			//이름,인물 카테고리를 통한 기본 검색만
			else
			{
				queryBasic=queryBasic+";";
			}
				
				
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			//Statement 생성
			stmt = conn.createStatement();
			//Query 실행
			result = stmt.executeQuery(queryBasic);
			%>
			<table>
			<tr>
				<th>이름</th>
				<th>국적</th>
				<th>카테고리</th>
				<th>실명</th>
				<th>인물 수정</th>
				<th>인물 삭제</th>
			</tr>
			<%
			while(result.next()) {
				Integer getPId = result.getInt("p_id");
				String getPerName= result.getString("p_name");
				String getPerNation= result.getString("p_nation");
				String getPerCate= result.getString("p_category");
				String getPerRName= result.getString("p_rname");
			%>
					<tr>
						<td><%=getPerName%></td>
						<td><%=getPerNation %></td>
						<td><%=getPerCate%></td>					
						<td><%=getPerRName%></td>
					
						<td><form name="modify" method="post" action="Modify_person1.jsp">
							<input type="hidden" name="setPId" value=<%=getPId%>>
							<input type="submit" name="submit" value="인물수정">
							</form>
						</td>
						<td><form name="delete" method="post" action="Delete_person1.jsp">
							<input type="hidden" name="setPId" value=<%=getPId%>>
							<input type="submit" name="submit" value="인물삭제">
							</form>
						</td>
					</tr>
			<%	}//while %>
			
			</table>
			<% 	result.close();	
				stmt.close();
				conn.close();
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