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


<!-- 출처 관리페이지   -->
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
	<h1>출처 관리 페이지</h1>
	<br><br>
	<a href="MainPage2.jsp">뒤로가기</a>
	<br><br>
	
	<form name="search" method="post" action="Search_source.jsp">
	    <span>출처 종류<select name="setSType">
		     <option>책</option>
		     <option>영화</option>
		     <option>음악</option>
		     <option>인터넷</option>
	    	</select></span>
	    <span>출처 제목<input type="text" name="setSTitle" value=""></span>
		<input type="submit" name="search_scr" value="출처 검색">
	</form>
	<br>
	<br>
	
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		
		try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String query = "select * from source_basic;";
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
						<th>출처종류</th>
						<th>출처제목</th>
						<th>출처수정</th>
						<th>출처삭제</th>
					</tr>
			<%
			while(result.next())
			{  	
				Integer getSId = result.getInt("s_id");
				String getSType=result.getString("s_type");
				String getSTitle=result.getString("s_title");
			%>
					<tr>
						<td><%=getSType%></td>	
						<td><%=getSTitle%></td>
						<td><form name="form1" method="post" action="Modify_source1.jsp">
							<input type="hidden" name=setStype value=<%=getSType%>> 
							<input type="hidden" name=setSId value=<%=getSId%>>
							<input type="submit" name="submit" value="출처수정">
							</form>
						</td>
						<td><form name="form1" method="post" action="Delete_source1.jsp">
							<input type="hidden" name=setStype value=<%=getSType%>> 
							<input type="hidden" name=setSId value=<%=getSId%>>
							<input type="submit" name="submit" value="출처삭제">
							</form>
						</td>
					</tr>
		<%	}//while %>
			</table>
			
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
