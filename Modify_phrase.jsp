<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문구 수정 페이지</title>
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
<!-- 문구수정페이지   -->
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
	<h1>문구 수정 페이지</h1>
	<br><br>
	<a href="MainPage2.jsp">뒤로가기</a>
	<br><br>
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		Integer getPhId= Integer.parseInt(request.getParameter("setPh_Id"));	//modify 할 phrase ID정보를 가져옴.
		String getUId=request.getParameter("setU_Id");

		Integer getPId=null;//	변경하고자하는 인물정보의 ID
		Integer getSId=null; // 변경하고자하는 출처정보의 ID 
			
		String getPHContent = null; // 변경하고자하는 문구내용
		String getPHCategory = null; // 변경하고자하는 카테고리 (인생/)
		   
		String getPHDescription= null;
		Integer getPHIsopen= null;
		
		//해당 문구를 등록한사람과 다른사람이 수정을 시도할 경우 수정권한 없음.
		if (!(getUId.equals(session.getAttribute("loginId"))))
		{
		%>
			<script>
				alert('문구의 주인이 아니십니다. 수정권한이 없습니다!');
				location.href="http://localhost:8081/DBclass/MainPage2.jsp";
			</script>
		<%	return;
		}

	%>
		<form name="reg" method="post" action="Modify_phrase1.jsp">
		<!-- 문구내용 가져오는 테이블 시작하는부분 -->
		 <table>
			<tr>
				<th>문구 내용</th>
				<th>문구 카테고리</th>
				<th>문구 설명</th>
				<th>문구 공개여부</th>
			</tr>
	<% try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String query = "select * from phrase where ph_id='"+getPhId+"';";
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			//Statement 생성
			stmt = conn.createStatement();
			//Query 실행
			result = stmt.executeQuery(query);
			if(result.next())
			{ 
				getPHContent = result.getString("ph_content"); // 변경하고자하는 문구내용
				getPHDescription= result.getString("ph_description");
				
			%><!-- 문구 수정하는 부분 -->
				<tr>
					<td><input type="text" name="content" value="<%=getPHContent%>" style="width:800px;"></td>
					<td>
						<select name="category">
					        <option>명언</option>
					        <option>처세</option>
					        <option>인생</option>
					        <option>금전</option>
				        </select>
				    </td>					
					<td><input type="text" name="description" value="<%=getPHDescription%>">
					<td>
						<select name="isopen">
					        <option>PRIVATE</option>
					        <option>PUBLIC</option>
				        </select>
				    </td>
				</tr>
		</table>
		<!-- 문구변경 버튼 -->
		<input type="hidden" name="setPhId" value=<%=getPhId%>>
		<input type="submit" name="modify_ph" value="문구 변경">
		</form>
		
		
		<%	
			}	//if(result.next())
		}//try
		catch(Exception e) {
			e.printStackTrace();
		} finally {
			if ( result != null ) try{result.close();}catch(Exception e){}
		    if ( stmt != null ) try{stmt.close();}catch(Exception e){}
		    if ( conn != null ) try{conn.close();}catch(Exception e){}
		}
		 %>
</body>
</html>