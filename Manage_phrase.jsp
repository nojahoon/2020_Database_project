<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" import="java.sql.*,java.net.*" %>
<%@ page session ="true"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 문구현황관리</title>
<link rel="stylesheet" href="CSSFile.css">
</head>

<!-- 내 문구만 한눈에 보며 현황관리 -->
<body>
	<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet result = null;
	String query="";
	String getUId= (String)session.getAttribute("loginId");
	
	if(session.getAttribute("loginId")!=null)
	{
	%>
		환영합니다! <%=session.getAttribute("loginId")%>님!
<%  }
	else
	{
	%>	<script>
			alert('잘못된 접근입니다!');
		</script>
	<% response.sendRedirect("http://localhost:8081/DBclass/MainPage.jsp");
	
	}
%>
	
	
	<button type ="button" onclick="location.href='http://localhost:8081/DBclass/LogoutPage.jsp'"> 로그아웃 </button>
	<button type ="button" onclick="location.href='http://localhost:8081/DBclass/Score.jsp'"> 내점수보기 </button>
	<h1>나의 문구 현황</h1>

    <a href="MainPage2.jsp">뒤로가기</a>
  
	
	
	<br><br>
	<h2>PUBLIC</h2>
	<% try {
			String jdbcDriver= "jdbc:mariadb://localhost:3306/phrase_db";
			String dbUser = "root";
			String dbPass = "비공개"; //캡쳐하기 위해 바꿈 , 원래 password는 아님
			query = "SELECT ph_id,ph_category,s_type,p_name,s_title,ph_content,ph_description FROM phrase AS PH, person AS PE, source_basic AS SCR WHERE PH.p_id=PE.p_id AND PH.s_id=SCR.s_id AND PH.ph_isopen=1 AND PH.u_id='"+getUId+"' order by PH.ph_like DESC;";
			//DB Connection 생성
			conn = DriverManager.getConnection(jdbcDriver,dbUser,dbPass);
			//Statement 생성
			stmt = conn.createStatement();
			//Query 실행
			result = stmt.executeQuery(query);
			
			
			%>
			<!--PUBLIC 설정 되어있는 phrase 정보를 읽어서 한줄씩 table에 출력 -->
			<table>
					<tr>
						<th>분야</th>
						<th>출처 종류</th>
						<th>인물</th>
						<th>출처제목</th>
						<th>내용</th>
						<th>설명</th>
						<th>좋아요</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
			<%
			while(result.next())
			{  	
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
							<a href="Like.jsp?setPh_Id=<%=getPh_Id%>"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile29.uf.tistory.com%2Fimage%2F2275AE4055E8082C25AA57" width="30" height="20"></a>
						</td>
							
						<td><form name="form1" method="post" action="Modify_phrase.jsp">
							<input type="hidden" name=setPh_Id value=<%=getPh_Id%>>
							<input type="hidden" name=setU_Id value=<%=getUId%>>
							<input type="submit" name="submit" value="수정">
							</form>
						</td>
						
						<td><form name="form1" method="post" action="Delete_phrase.jsp">
							<input type="hidden" name=setPh_Id value=<%=getPh_Id%>>
							<input type="hidden" name=setU_Id value=<%=getUId%>>
							<input type="submit" name="submit" value="삭제">
							</form>
						</td>
					</tr>
	<%		} //while %>
	
			<!-- PUBLIC 설정된 문구 Table 끝나는부분-->
			</table>
		
			
	<% 
	
			result.close();
			stmt.close();
			
			query="SELECT ph_id,ph_category,s_type,p_name,s_title,ph_content,ph_description FROM phrase AS PH, person AS PE, source_basic AS SCR WHERE PH.p_id=PE.p_id AND PH.s_id=SCR.s_id AND PH.ph_isopen=0 AND PH.u_id='"+getUId+"' ORDER by PH.ph_like DESC;";
			stmt=conn.createStatement();
			//result=stmt.executeQuery(query);
			result=stmt.executeQuery(query);
	%>
			<!-- 내 로그인 ID 계정의 PRIVATE 문구 테이블 시작되는부분 -->
			<h2>PRIVATE</h2>
			
			<table>
					<tr>
						<th>분야</th>
						<th>출처 종류</th>
						<th>인물</th>
						<th>출처제목</th>
						<th>내용</th>
						<th>설명</th>
						<th>좋아요</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
	<%	
			while(result.next())
			{  	
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
							<a href="Like.jsp?setPh_Id=<%=getPh_Id%>"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile29.uf.tistory.com%2Fimage%2F2275AE4055E8082C25AA57" width="30" height="20"></a>
						</td>
							
						<td><form name="form1" method="post" action="Modify_phrase.jsp">
							<input type="hidden" name=setPh_Id value=<%=getPh_Id%>>
							<input type="hidden" name=setU_Id value=<%=getUId%>>
							<input type="submit" name="submit" value="수정">
							</form>
						</td>
						
						<td><form name="form1" method="post" action="Delete_phrase.jsp">
							<input type="hidden" name=setPh_Id value=<%=getPh_Id%>>
							<input type="hidden" name=setU_Id value=<%=getUId%>>
							<input type="submit" name="submit" value="삭제">
							</form>
						</td>
					</tr>
	<%		} //while %>
			<!-- PRIVATE 부분 Table 끝나는부분-->
			</table>
	
	<% 		
			result.close();
			stmt.close();
			conn.close();
		} //try
		catch(Exception e) {
			e.printStackTrace();
		} finally {
			if ( result != null ) try{result.close();}catch(Exception e){}
		    if ( stmt != null ) try{stmt.close();}catch(Exception e){}
		    if ( conn != null ) try{conn.close();}catch(Exception e){}
		}
	%>				
   
    <br>
	<br>
    <hr>
        <div>Support Phrase Database Project!</div>
        <div style="text-align : center;">If you need any help, Contact with us. nojahoon@naver.com </div>
        
</body>

</html>