<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문구 등록하기 </title>
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
<!-- 문구 등록  -->
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
	<h1>문구 등록페이지</h1>
	<br><br>
	<a href="MainPage2.jsp">뒤로가기</a>
	<br><br>
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
	 
		
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
			
		
			query="select * from person";
			stmt =conn.createStatement();
			
			result=stmt.executeQuery(query);
			
			
			%>
			
			<!-- form 시작부분 -->
			<!-- radio로 인물,출처를 선택하고 문구를 입력받는 큰 틀의 form -->
			<form name="reg" method="post" action="Register_phrase1.jsp">
			
			<!-- 인물 테이블 Showing -->
			<table border size="2">
				<!-- 테이블 출력 제목부분-->
	          <tr>
	              <th>인물 이름</th>
	              <th>인물 국가</th>
	              <th>인물 구분</th>
	              <th>인물 선택</th>
	          </tr>
	        <%
			while(result.next())
			{  String getPId=result.getString("p_id");
			   String getName=result.getString("p_name");
			   String getNation=result.getString("p_nation");
			   String getCategory=result.getString("p_category");
			%>
				<!-- 테이블 출력 제목부분-->
	          <tr>
	              <td><%=getName%></td>
	              <td><%=getNation%></td>
	              <td><%=getCategory%></td>
	              <td><input type="radio" name="person" value="<%=getPId%>"></td>
	          </tr>
		<% 	}  %>
			</table>	<!-- 인물 테이블 닫아줌 -->
			
		<% 
		 	stmt.close();	//첫번째 table에 대해서 보여줌을 마침
			
			query="select * from source_basic";
			stmt=conn.createStatement();
			result=stmt.executeQuery(query);
		%>
			<br><br>
			<!-- 출처 테이블 Showing -->
		  <table border size="2";>
		  		<!-- 테이블 출력 제목부분-->
		        <tr>
		            <th>출처 타입</th>
		            <th>출처 제목</th>
		            <th>출처 선택</th>
		        </tr>
			<% 
			while(result.next())
			{ 
				String getSId=result.getString("s_id");
				String getType=result.getString("s_type");
				String getTitle=result.getString("s_title");
			%>
				<!-- 테이블 출력 내용부분-->
				<tr>
		           <td><%=getType%></td>
		           <td><%=getTitle%></td>
		           <td><input type="radio" name="source" value="<%=getSId%>"></td>
		       </tr>
		<%   }   %>
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
			
		} %>
	
		
	  <br><br>
	  <!-- 문구 입력하는 부분 -->
			<table>
				<tr>
					<th>문구 내용</th>
					<th>문구 카테고리</th>
					<th>문구 설명</th>
					<th>문구 공개여부</th>
				</tr>
				<tr>
					<td><input type="text" value="" name="content" style="width:800px;"></td>
					<td>
						<select name="category">
					        <option>명언</option>
					        <option>처세</option>
					        <option>인생</option>
					        <option>금전</option>
				        </select>
				    </td>					
					<td><input type="text" value="" name="description">
					<td>
						<select name="isopen">
					        <option>PRIVATE</option>
					        <option>PUBLIC</option>
				        </select>
				    </td>
				</tr>
			</table>	
		
		<input type="submit" name="enroll_ph" value="문구 등록">
		
		<!-- 출처,인물에 대한 정보를 radio로 입력받고 문구에 대해서 입력하는 form이 최종적으로 끝나는 부분 -->
		</form>
	

</body>
</html>