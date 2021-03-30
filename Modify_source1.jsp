<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출처 수정페이지 DB연동</title>
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
<!-- 출처 수정에 대한 변경사항 DB 연동 //이거 다 손봐야함-->
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
	<h1>출처 수정페이지</h1>
	<br><br><br>
	<a href="Manage_source.jsp">이전으로</a>
	<br><br>
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;

	   Integer s_id=Integer.parseInt(request.getParameter("setSId"));	//수정할 phrase id정보
	   
	   String getSType = request.getParameter("setStype");
	   
	%>
	
	<% try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String query = "";
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			if(getSType=="")
			{
				%><script>
					alert('getStype이 비어있습니다. 다시시도하세요.')
					location.href="http://localhost:8081/DBclass/MainPage2.jsp";
				</script>
		<% 		return;
		 	}				
			
			if(getSType.equals("책"))
			{
				query="select * from source_basic as SRC_BASIC, source_book as SRC_BOOK where SRC_BASIC.s_id='"+s_id+"'and SRC_BOOK.source_id='"+s_id+"'";
				//Statement 생성
				stmt = conn.createStatement();
				//Query 실행
				result=stmt.executeQuery(query);					
				result.next();
				
				String getBName=result.getString("s_title");	 //책 이름
			 	String getBWriter=result.getString("b_writer"); //책 저자
			    String getBPublisher=result.getString("b_publisher");   //출판사	   
			    String getBGenre=result.getString("b_genre");   //책종류 - 수필/시 등..  
			    String getStype=result.getString("s_type"); //출처 타입(책)	
					
			%>
				<form name="modify" method="post" action="Modify_book.jsp">
					<table>
						<tr>
							<th>책이름</th>
							<th>책 저자</th>
							<th>책 출판사</th>
							<th>책 장르</th>
						</tr>
						<tr>
							<td><input type="text" name="name" value="<%=getBName%>"></td>
							<td><input type="text" name="writer" value="<%=getBWriter%>"></td>
							<td><input type="text" name="publisher" value="<%=getBPublisher%>"></td>
							<td><select name="bookgenre">
						        <option>시집</option>
						        <option>소설</option>
						        <option>수필</option>
						        <option>잡지</option>
						        <option>만화</option>
			    				</select></td>
						</tr>
					</table>
					<input type="hidden" name="setScrtype" value="<%=getStype%>">
					<input type="hidden" name="setSId" value="<%=s_id%>">
					<input type="submit" name="modify_book" value="도서 출처 변경">
				</form>
		<% 		result.close();
				stmt.close();
				conn.close();
			}
			else if(getSType.equals("영화"))
			{
				query="select * from source_basic as SRC_BASIC, source_movie as SRC_MOVIE where SRC_BASIC.s_id='"+s_id+"'and SRC_MOVIE.source_id='"+s_id+"'";
				//Statement 생성
				stmt = conn.createStatement();
				//Query 실행
				result=stmt.executeQuery(query);					
				result.next();
			    String getMName=result.getString("s_title");	//영화이름
			    String getMDir=result.getString("mo_director");  //감독이름
			    String getMActor=result.getString("mo_actor");  //영화배우
			    String getMDate=result.getString("mo_date");  //개봉날짜
			    String getMGenre=result.getString("mo_genre");  //영화 장르
			    String getStype=result.getString("s_type"); //출처 타입(영화)	
			%>
				<form name="modify" method="post" action="Modify_movie.jsp">
					<table>
						<tr>
							<th>영화 이름</th>
							<th>영화 감독</th>
							<th>영화 배우</th>
							<th>개봉 날짜</th>
							<th>영화 장르</th>
						</tr>
						<tr>
							<td><input type="text" name="name" value="<%=getMName%>"></td>
							<td><input type="text" name="director" value="<%=getMDir%>"></td>
							<td><input type="text" name="actor" value="<%=getMActor%>"></td>
							<td><input type="text" name="date" value="<%=getMDate%>"></td>
							<td><input type="text" name="genre" value="<%=getMGenre%>"></td>
						</tr>
					</table>
					<input type="hidden" name="setScrtype" value="<%=getStype%>">
					<input type="hidden" name="setSId" value="<%=s_id%>">
					<input type="submit" name="modify_movie" value="영화 출처 변경">
				</form>
				
				
		<% 		result.close();
				stmt.close();
				conn.close();
			}
			else if(getSType.equals("음악"))
			{
				query="select * from source_basic as SRC_BASIC, source_music as SRC_MUSIC where SRC_BASIC.s_id='"+s_id+"'and SRC_MUSIC.source_id='"+s_id+"'";
				//Statement 생성
				stmt = conn.createStatement();
				
				//Query 실행
				result=stmt.executeQuery(query);
				
				
				String getMuName="";
				String getMuSinger="";
				String getMuGenre="";
				String getMuDate="";
				String getStype="";
				
				if(result.next())
				{
			        getMuName=result.getString("s_title");	 	//음악 이름
				    getMuSinger=result.getString("mu_singer"); //음악 가수
				    getMuGenre=result.getString("mu_genre");   //음악 장르
				    getMuDate=result.getString("mu_Date");   //발매 날짜
				    getStype=result.getString("s_type"); //출처 타입(음악)	
				}
				else
				{
			    System.out.println("Result.next()가 실행되지않았음.");
			    }
			%>
				<form name="modify" method="post" action="Modify_music.jsp">
					<table>
						<tr>
							<th>음악 이름</th>
							<th>가수 이름</th>
							<th> 장르 </th>
							<th>발매일</th>
						</tr>
						<tr>
							<td><input type="text" name="name" value="<%=getMuName%>"></td>
							<td><input type="text" name="singer" value="<%=getMuSinger%>"></td>
							<td><input type="text" name="genre" value="<%=getMuGenre%>"></td>
							<td><input type="text" name="mu_Date" value="<%=getMuDate%>"></td>
						</tr>
					</table>
					<input type="hidden" name="setScrtype" value="<%=getStype%>">
					<input type="hidden" name="setSId" value="<%=s_id%>">
					<input type="submit" name="enroll_music" value="음악 출처 변경">
				</form>
			
		<% 		result.close();
				stmt.close();
				conn.close();
			}
			else if(getSType.equals("인터넷"))
			{
				query="select * from source_basic as SRC_BASIC, source_internet as SRC_INTERNET where SRC_BASIC.s_id='"+s_id+"'and SRC_INTERNET.source_id='"+s_id+"'";
				//Statement 생성
				stmt = conn.createStatement();
				//Query 실행
				result=stmt.executeQuery(query);					
				result.next();
				
				String getIName=result.getString("s_title");	 //인터넷 이름
				String getILink=result.getString("in_link"); 		 //사이트 링크
				String getStype=result.getString("s_type"); //출처 타입(음악)	
		%>
				<form name="modify" method="post" action="Modify_internet.jsp">
					<table>
						<tr>
							<th>출처 사이트명</th>
							<th>출처 link</th>
						</tr>
						<tr>
							<td><input type="text" value="<%=getIName%>" name="name" ></td>
							<td><input type="text" value="<%=getILink%>" name="link" style="width:600px;"></td>
						</tr>
					</table>
					<input type="hidden" name="setScrtype" value="<%=getStype%>">
					<input type="hidden" name="setSId" value="<%=s_id%>">
					<input type="submit" name="enroll_internet" value="인터넷 출처 등록">
				</form>
		<% 		result.close();
		 		stmt.close();
		 		conn.close();
			}
			else
			{
			%>	
				<script>
					alert('잘못된 타입입니다. 다시 시도해주세요.');
					location.href="http://localhost:8081/DBclass/MainPage2.jsp";
				</script>
		<%  }
							
		}//try
		catch(Exception e) {
			e.printStackTrace();
		} finally {
			if ( result != null ) try{result.close();}catch(Exception e){}
		    if ( stmt != null ) try{stmt.close();}catch(Exception e){}
		    if ( conn != null ) try{conn.close();}catch(Exception e){}
			
		}	%>				
</body>
</html>