<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출처 등록하기</title>
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
<!-- 출처등록  -->
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
	<h1>출처 등록페이지</h1>
	<br><br><br>
	<a href="MainPage2.jsp">뒤로가기</a>
	<br><br>
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
	 
	    String getscrtype=request.getParameter("sourcetype");
		if(getscrtype!=null)
			session.setAttribute("scrtype",getscrtype);
		
	%>
	
	<% try {
		    
			if(session.getAttribute("scrtype").equals("책"))
			{
			%>
				<form name="reg" method="post" action="Register_book.jsp">
					<table>
						<tr>
							<th>책이름</th>
							<th>책 저자</th>
							<th>책 출판사</th>
							<th>책 장르</th>
						</tr>
						<tr>
							<td><input type="text" value="" name="name"></td>
							<td><input type="text" value="" name="writer"></td>
							<td><input type="text" value="" name="publisher"></td>
							<td><select name="bookgenre">
						        <option>시집</option>
						        <option>소설</option>
						        <option>수필</option>
						        <option>잡지</option>
						        <option>만화</option>
			    				</select></td>
						</tr>
					</table>
					<input type="hidden" name="setScrtype" value="<%=session.getAttribute("scrtype")%>">
					<input type="submit" Id="BookDate" name="enroll_book" value="도서 출처 등록">
				</form>
			<%
			}
			
			
			else if(session.getAttribute("scrtype").equals("영화"))
			{
			%>
				
				<br><br>
				
				<form name="reg" method="post" action="Register_movie.jsp">
					<table>
						<tr>
							<th>영화 이름</th>
							<th>영화 감독</th>
							<th>영화 배우</th>
							<th>개봉 날짜</th>
							<th>영화 장르</th>
						</tr>
						<tr>
							<td><input type="text" value="" name="name"></td>
							<td><input type="text" value="" name="director"></td>
							<td><input type="text" value="" name="actor"></td>
							<td><input type="text" value="" name="date"></td>
							<td><input type="text" value="" name="genre"></td>
						</tr>
					</table>
					<input type="hidden" name="setScrtype" value="<%=session.getAttribute("scrtype")%>">
					<input type="submit" name="enroll_movie" value="영화 출처 등록">
				</form>
				
			<%
			}
			
			else if(session.getAttribute("scrtype").equals("음악"))
			{
			%>
			
				<br><br>
				
				<form name="reg" method="post" action="Register_music.jsp">
					<table>
						<tr>
							<th>음악 이름</th>
							<th>가수 이름</th>
							<th> 장르 </th>
							<th>발매일</th>
						</tr>
						<tr>
							<td><input type="text" value="" name="name"></td>
							<td><input type="text" value="" name="singer"></td>
							<td><input type="text" value="" name="genre"></td>
							<td><input type="text" value="" name="muDate"></td>
						</tr>
					</table>
					<input type="hidden" name="setScrtype" value="<%=session.getAttribute("scrtype")%>">
					<input type="submit" name="enroll_music" value="음악 출처 등록">
				</form>
			<%
			}
			
			else if(session.getAttribute("scrtype").equals("인터넷"))
			{
			%>	
				<br><br>
				
				<form name="reg" method="post" action="Register_Internet.jsp">
					<table>
						<tr>
							<th>출처 사이트명</th>
							<th>출처 link</th>
						</tr>
						<tr>
							<td><input type="text" value="" name="name"></td>
							<td><input type="text" value="" name="link" style="width:600px;"></td>
						</tr>
					</table>
					<input type="hidden" name="setScrtype" value="<%=session.getAttribute("scrtype")%>">
					<input type="submit" name="enroll_internet" value="인터넷 출처 등록">
				</form>
		   	<%
		   	}  
			else
			{
			%>  뭔가잘못됨
				<script>
				alert('잘못된접근입니다...출처 항목을 선택 후 진행하세요!');
				location.href="http://localhost:8081/DBclass/MyPage2.jsp";
				</script>
			<%	
			}
	}
	catch(Exception e) {
		e.printStackTrace();
	} finally {
	}
	%>			
	
	

</body>
</html>