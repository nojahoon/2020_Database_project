<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색결과 페이지</title>
<link rel="stylesheet" href="CSSFile.css">
</head>
<body>
<!-- 실제로 사용하지는 않는 부분 / 코드 기본형식 복사용도   -->
	
	<% 
		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
	   String getId= (String)session.getAttribute("loginId");
	   
	   String getSource=request.getParameter("sourcetype");	//출처타입 - 책,영화,음악,인터넷
	   String getCategory=request.getParameter("category");		//유형 - 명언,처세,금전,인생
	   String getName=request.getParameter("Pname");				//인물이름
	   String getTitle=request.getParameter("title");			//출처제목
	   String getContent=request.getParameter("content");	//문구내용
	   
	   if(session.getAttribute("loginId")!=null)
		{
		%>
			환영합니다! <%=session.getAttribute("loginId")%>님!
	<%  }
		else
		{
		%>	<script>
				alert('잘못된 접근입니다!');
				location.href="http://localhost:8081/DBclass/MainPage.jsp";
			</script>
		<% 
		
		}
	%>
		
		
		<button type ="button" onclick="location.href='http://localhost:8081/DBclass/LogoutPage.jsp'"> 로그아웃 </button>
		<h1>Welcome! Enjoying Database Homework!!</h1>

	    
	    <br><br><br>
	    <!-- 인물-출처-문구  수정/등록/삭제 기능(문구의 수정과 삭제는 따로 문구를 한줄씩 출력하는란에 포함시킴) -->
		<div>
		<table>
			<tr>
				<th><a href="Register_person.jsp"><button type="button">인물등록</button></a></th>
				<th><form name="form1" method="post" action="Register_source.jsp">
				 	 <select name="sourcetype">
				        <option>책</option>
				        <option>영화</option>
				        <option>음악</option>
				        <option>인터넷</option>
			    	</select>
					<input type="submit" name="enroll_scr" value="출처등록">
				</form></th>
				<th><form name="form1" method="post" action="Register_phrase.jsp">
					<input type="submit" name="enroll_ph" value="문구등록">
				</form></th>
				<th><a href="Modify_person.jsp"><button type="button">인물수정</button></a></th>
				<th><a href="Delete_person.jsp"><button type="button">인물삭제</button></a></th>
				<th><a href="Modify_source.jsp"><button type="button">출처수정</button></a></th>
				<th><a href="Delete_source.jsp"><button type="button">출처삭제</button></a></th>
			</tr>
		</table>
		</div>
		
		 <br><br>
		 
		<br><br>
		<a href="MainPage2.jsp">뒤로가기</a>
		<br><br>
		<h2>검색 결과</h2>
		 <!-- Search 하는 부분 -->
	    <%-- <form name="search" method="post" action="Searching.jsp">
		 	<span>출처<select name="sourcetype">
			     <option>책</option>
			     <option>영화</option>
			     <option>음악</option>
			     <option>인터넷</option>
		    	</select></span>
	    	<span>  유형<select name="category">
			     <option>명언</option>
			     <option>처세</option>
			     <option>금전</option>
			     <option>인생</option>
		    	</select></span>
		    <span>인물이름<input type="text" name="name" value="<%=getName%>">
		    </span>
		    
		    <span>출처제목<input type="text" name="title" value="<%=getTitle%>"></span>
		    <span>   내용검색
		    	<input type="text" name="content" value="<%=getContent%>">
		    	</span>
			<input type="submit" name="search_ph" value="검색">
		</form> --%>
		
		
		
		
		<br><br>
	
	<% try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			//기본골격 query (조인상태)
			String queryBasic = "SELECT ph_id,ph_category,s_type,p_name,s_title,ph_content,ph_description FROM phrase AS PH, person AS PE, source_basic AS SCR WHERE PH.p_id=PE.p_id AND PH.s_id=SCR.s_id";
			//query문에 결합되는 출처 테마와 유형
			String searchSelected = " And PH.ph_category='"+getCategory+"' And SCR.s_type = '"+getSource+"'";
			//query문에 결합되는 문구내용
			String queryContent=" And PH.ph_content like '"+"%"+getContent+"%'";
			//query문에 결합되는 출처제목  
			String queryTitle=" And SCR.s_title='"+getTitle+"'";
			//query문에 결합되는 출처인물이름
			String queryName=" And PE.p_name='"+getName+"'";
			//String query = "SELECT ph_id,ph_category,s_type,p_name,s_title,ph_content,ph_description FROM phrase AS PH, person AS PE, source_basic AS SCR WHERE PH.p_id=PE.p_id AND PH.s_id=SCR.s_id;";
			
			//이름,제목,내용 다 기입하여 검색한경우
			if( (!(getContent.equals("")) ) && (!(getTitle.equals(""))) && (!(getName.equals(""))) )
				queryBasic=queryBasic+searchSelected+queryTitle+queryContent+queryName+";";
			//이름,제목만 기업하여 검색한경우
			else if(!(getTitle.equals(""))&& (!getName.equals("")) &&(getContent.equals("")))
				queryBasic=queryBasic+searchSelected+queryTitle+queryName+";";
			//내용,이름만 기입하여 검색한 경우
			else if(!(getContent.equals(""))&& (!getName.equals(""))&& (getTitle.equals("")))
				queryBasic=queryBasic+searchSelected+queryContent+queryName+";";
			//제목,내용만 기입하여 검색한 경우
			else if(!(getContent.equals(""))&& (!(getTitle.equals(""))) && ((getName.equals(""))) )
				queryBasic=queryBasic+searchSelected+queryContent+queryTitle+";";
			//이름만 기입하여 검색한 경우
			else if(!(getName.equals(""))&& ((getTitle.equals(""))) && (getContent.equals("")))
				queryBasic=queryBasic+searchSelected+queryName+";";
			//제목만 기입하여 검색한 경우
			else if(!(getTitle.equals("")) && ((getName.equals(""))) && (getContent.equals("")))
				queryBasic=queryBasic+searchSelected+queryTitle+";";
			//내용만 기입하여 검색한 경우
			else if(!(getContent.equals(""))&& ((getTitle.equals(""))) && (getName.equals("")))
				queryBasic=queryBasic+searchSelected+queryContent+";";
			//이름,제목,내용 모두 기입하지 않아 출처 테마와 유형에 대해서만 검색진행
			else
				queryBasic=queryBasic+searchSelected+";";
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			//Statement 생성
			stmt = conn.createStatement();
			//Query 실행
			result = stmt.executeQuery(queryBasic);
			
			%>
			<!--검색결과를 거친 phrase 정보를 읽어서 한줄씩 table에 출력 -->
			<table>
					<tr>
						<th>분야</th>
						<th>출처 종류</th>
						<th>인물</th>
						<th>제목</th>
						<th>내용</th>
						<th>설명</th>
						<th>좋아요</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
			<%
			while(result.next()) {
				Integer getPh_Id=result.getInt("ph_id");	//Like,수정,삭제시 해당 phrase id정보를 넘겨 처리할생각
				
				String getPh_category = result.getString("ph_category");	//분야(연애/처세/인생/금전) - (Phrase table)
				String getSource_type = result.getString("s_type");	//출처종류	 - (Source_basic table)
				String getP_name = result.getString("p_name");				//인물	- (Person table)
				String getSource_basic = result.getString("s_title");	//제목	- (Source_basic table)
				String getPh_content = result.getString("ph_content");		//내용	- (Phrase table)
				String getPh_description = result.getString("ph_description");	//설명	- (Phrase table)
			%>
					<tr>
						<td><%=getPh_category%></td>	
						<td><%=getSource_type%></td>
						<td><%=getP_name%></td>
						<td><%=getSource_basic%></td>
						<td><%=getPh_content%></td>
						<td><%=getPh_description%></td>
						
						<td>
							<a href="Like.jsp?setPh_id=<%=getPh_Id%>"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile29.uf.tistory.com%2Fimage%2F2275AE4055E8082C25AA57" width="30" height="20"></a>
						</td>
							
						<td><form name="form1" method="post" action="Modify_phrase.jsp">
							<input type="hidden" name=setPh_Id value=<%=getPh_Id%>>
							<input type="submit" name="submit" value="수정">
							</form>
						</td>
						
						<td><form name="form1" method="post" action="Delete_phrase.jsp">
							<input type="hidden" name=setPh_Id value=<%=getPh_Id%>>
							<input type="submit" name="submit" value="삭제">
							</form>
						</td>
					</tr>
	<%		} //while %>
	
			<!-- Table 끝나는부분-->
			</table>
			
	<% 	}	//try
		catch(Exception e) {
			e.printStackTrace();
		} finally {
			if ( result != null ) try{result.close();}catch(Exception e){}
		    if ( stmt != null ) try{stmt.close();}catch(Exception e){}
		    if ( conn != null ) try{conn.close();}catch(Exception e){}
			
		}%>
	<br>
	<br>
    <hr>
        <div>Support Phrase Database Project!</div>
        <div style="text-align : center;">If you need any help, Contact with us. nojahoon@naver.com </div>
        
</body>
</html>