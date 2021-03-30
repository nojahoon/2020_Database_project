<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인물 수정하기</title>
<link rel="stylesheet" href="CSSFile_Register.css">
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
<!-- 인물수정에 대한 변경사항 DB 연동 -->
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
	<h1>인물 수정 페이지</h1>
	<br><br>
	<a href="MainPage2.jsp">홈으로</a>
	<br><br>
	<% 
	   Connection conn = null;
	   Statement stmt = null;
	   ResultSet result = null;
	   Integer getPId = Integer.parseInt(request.getParameter("setPId"));
		   
	%>
	
	<% try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String query="select * from person where p_id="+getPId;
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			//Statement 생성
			stmt = conn.createStatement();
			//Query 실행
			result=stmt.executeQuery(query);
			
			if(result.next())
			{
			String getPName= result.getString("p_name");
			String getPNation= result.getString("p_nation");
			String getPCate= result.getString("p_category");
			String getPRName= result.getString("p_rname");
			
			%>
			<form name="modify" method="post" action="Modify_person2.jsp">
				<table>
				<tr>
					<th>인물 이름</th>
					<th>인물 국적</th>
					<th>인물 카테고리</th>
					<th>인물 실명</th>
				</tr>
				<tr>
					<td><input type="text" value="<%=getPName%>" name="name"></td>
					<td><input type="text" value="<%=getPNation%>" name="nation"></td>
					<td>
						<select name="category">
					        <option>일반인</option>
					        <option>연예인</option>
					        <option>가상인물</option>
					        <option>미상</option>
			   			</select>
				    </td>					
					<td><input type="text" value="<%=getPRName%>" name="r_name"></td>
				</tr>
				</table>
				<input type="hidden" name="setPId" value="<%=getPId%>">
				<input type="submit" name="modify_person" value="인물 수정">
			</form>
	<%		}
			else
			{
				%>
				<script>
					alert('검색결과를 찾을 수 없습니다....');
					location.href="http://localhost:8081/DBclass/Manage_source.jsp";
				</script>
				<%
			}
			result.close();
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