<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출처 검색페이지</title>
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
<!-- 출처 검색페이지-->
	
	<h1>출처 검색페이지</h1>
	<br><br><br>
	<a href="MainPage2.jsp">홈으로</a>
	<br><br>
	<h2>검색결과</h2>
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;

	   
	   String getSType = request.getParameter("setSType");
	   String getSTitle = request.getParameter("setSTitle");
	   Integer s_id;
	%>
	
	<% try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			String query = "select count(*) as cnt from source_basic where s_type='"+getSType+"' and s_title='"+getSTitle+"';";
			String queryGetSId= "select s_id from source_basic where s_type='"+getSType+"' and s_title='"+getSTitle+"';";
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			
			if(getSType=="")
			{
		%>	<script>
				alert('getStype이 비어있습니다. 다시시도하세요.')
				location.href="http://localhost:8081/DBclass/Manage_source.jsp";
			</script>
		<% 		//result.close();
				//stmt.close();
				//conn.close();
				return;
		 	}
			//Statement 생성
			stmt=conn.createStatement();
			//Query 실행
			result=stmt.executeQuery(query);
			result.next();
		
			if(result.getInt("cnt")<=0)
			{
			%>
			<script>
				alert('검색되는 출처가 없습니다.')
				location.href="http://localhost:8081/DBclass/Manage_source.jsp";
			</script>
			<%
				return;
			}
			
			result.close();
			stmt.close();
			
			//Statement 생성
			stmt=conn.createStatement();
			//Query 실행
			result=stmt.executeQuery(queryGetSId);
			result.next();
			s_id=result.getInt("s_id");
			result.close();
			stmt.close();
			
			if(getSType.equals("책"))
			{
			   	System.out.println("책으로들어옴");
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
				<table>
					<tr>
						<th>구분</th>
						<th>책이름</th>
						<th>책 저자</th>
						<th>책 출판사</th>
						<th>책 장르</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
					<tr>
						<td><%=getStype%></td>
						<td><%=getBName%></td>
						<td><%=getBWriter%></td>
						<td><%=getBPublisher%></td>
						<td><%=getBGenre%></td>
		    			<td><form name="modify" method="post" action="Modify_source1.jsp">
						<input type="hidden" name="setSId" value=<%=s_id%>>
						<input type="hidden" name="setStype" value=<%=getStype%>>
						<input type="submit" name="submit" value="수정">
						</form>
						</td>
						<td><form name="delete" method="post" action="Delete_source1.jsp">
							<input type="hidden" name="setSId" value=<%=s_id%>>
							<input type="submit" name="submit" value="삭제">
							</form>
						</td>
					</tr>
				</table>
				
				
		<% 		result.close();
				stmt.close();
				conn.close();
			}
			else if(getSType.equals("영화"))
			{
				System.out.println("영화로들어옴");
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
				
				<table>
					<tr>
						<th>구분</th>
						<th>영화 이름</th>
						<th>영화 감독</th>
						<th>영화 배우</th>
						<th>개봉 날짜</th>
						<th>영화 장르</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
					<tr>
						<td><%=getStype%></td>
						<td><%=getMName%></td>
						<td><%=getMDir%></td>
						<td><%=getMActor%></td>
						<td><%=getMDate%></td>
						<td><%=getMGenre%></td>
						<td><form name="modify" method="post" action="Modify_source1.jsp">
						<input type="hidden" name="setSId" value=<%=s_id%>>
						<input type="hidden" name="setStype" value=<%=getStype%>>
						<input type="submit" name="submit" value="수정">
						</form>
						</td>
						<td><form name="delete" method="post" action="Delete_source1.jsp">
							<input type="hidden" name="setSId" value=<%=s_id%>>
							<input type="submit" name="submit" value="삭제">
							</form>
						</td>
					</tr>
				</table>
				
			
				
				
		<% 		result.close();
				stmt.close();
				conn.close();
			}
			else if(getSType.equals("음악"))
			{
				System.out.println("음악으로들어옴");
				query="select * from source_basic as SRC_BASIC, source_music as SRC_MUSIC where SRC_BASIC.s_id='"+s_id+"'and SRC_MUSIC.source_id='"+s_id+"'";
				//Statement 생성
				stmt = conn.createStatement();
				System.out.println("Statement 생성");
				//Query 실행
				result=stmt.executeQuery(query);
				System.out.println("Query 실행");
				
				System.out.println("Result.next() 호출전");
				
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
				
				<table>
					<tr>
						<th>구분</th>
						<th>음악 이름</th>
						<th>가수 이름</th>
						<th> 장르 </th>
						<th>발매일</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
					<tr>
						<td><%=getStype%></td>
						<td><%=getMuName%></td>
						<td><%=getMuSinger%></td>
						<td><%=getMuGenre%></td>
						<td><%=getMuDate%></td>
						<td><form name="modify" method="post" action="Modify_source1.jsp">
							<input type="hidden" name="setSId" value=<%=s_id%>>
							<input type="hidden" name="setStype" value=<%=getStype%>>
							<input type="submit" name="submit" value="수정">
							</form>
							</td>
							<td><form name="delete" method="post" action="Delete_source1.jsp">
								<input type="hidden" name="setSId" value=<%=s_id%>>
								<input type="submit" name="submit" value="삭제">
								</form>
						</td>
					</tr>
				</table>
			
				
			
		<% 		result.close();
				stmt.close();
				conn.close();
			}
			else if(getSType.equals("인터넷"))
			{
				System.out.println("인터넷으로들어옴");
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
				
				<table>
					<tr>
						<th>출처 사이트명</th>
						<th>출처 link</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
					<tr>
						<td><%=getIName%></td>
						<td><%=getILink%></td>
						<td><form name="modify" method="post" action="Modify_source1.jsp">
							<input type="hidden" name="setSId" value=<%=s_id%>>
							<input type="hidden" name="setStype" value=<%=getStype%>>
							<input type="submit" name="submit" value="출처수정">
							</form>
						</td>
						<td><form name="delete" method="post" action="Delete_source1.jsp">
								<input type="hidden" name="setSId" value=<%=s_id%>>
								<input type="submit" name="submit" value="출처삭제">
							</form>
						</td>
					</tr>
				</table>
					
				
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