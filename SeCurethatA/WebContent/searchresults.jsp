<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
%>
<%@ page import="java.util.*" %>
<%@ page import="Database.Database" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SeCure that A|search results</title>
<link rel="stylesheet" type="text/css" href="searchresults.css" />
</head>
<body>
	<div id="header">
	
		<form name="myform" action="SearchServlet">
			<div id="search">
				<input id="search-button" type="submit" name="submit" value="Submit" />
				<input id="input" type="text" name="search-bar" placeholder=" Search...">
			</div>

			<div id="choice">
				<label class="radio"> 
					<input type="radio" name="radio-button" value="Professor" id="radio1">
					Professor 
				</label>
				
				<label class="radio"> 
					<input type="radio" name="radio-button" value="Course" id="radio2"> 
					Course
				</label>
			</div>

<%
	String n = (String)session.getAttribute("username");
	if(n!=null){ //someone logged in
%>
		<a href="LogoutServlet"><div id="right-button"> Sign out </div></a>
		<a href="Upload.jsp"><div id="left-button"> Upload GPA </div></a>
<%
	}else{
%>		
		<a href="RegisterPage.jsp"><div id="right-button"> Register </div></a>
		<a href="Homepage.jsp"><div id="left-button"> Homepage </div></a>
<%
	}
%>
		</form>
			
			
		<div class='clear-float'></div>

	</div>
	
	<!-- <div id="topbar">
		<form name="form" method="GET" action="BookServlet">
			<table>
				<tr>
					<td>
						<h1>SeCure that A!</h1>
					</td>
					<td><input id="searchbar" type="text" placeholder="Type..."
						name="searchbar"
					></td>

					<td>
						<button type="submit" id="submit">
							<img src="magnifying_glass.png" alt="Search" height="27"
								width="34"
							/>
						</button>
					</td>
					<td><input type="radio" name="searchtype" value="Professor" />Professor<br />
					</td>
					<td><input type="radio" name="searchtype" value="Course" />Course<br />
					</td>
				</tr>
			</table>
		</form>

		<br />
	</div> -->



	<div id="results">
<%
    String input = request.getParameter("search-bar");
%>	
		<h3 id="result-title">Results for "<%= input %>"</h3><hr/>
		
	
<%
		Database db = new Database();	
		String searchby = (String)request.getAttribute("resultsby");
		Vector<String> res = new Vector<String>();
		if(searchby==null){
			System.out.println("searchby is null");//for debug
		}
		else{System.out.println("searchby "+searchby);//for debug
		if(searchby.contentEquals("Course")){
			res = db.searchCourseByCourse(input);
		}
		else{
			res = db.searchCourseByProf(input);
		}}
		if(res.size()==0){
%>
<p>No results...try again!</p>
<%
		}
		else{
		for(int i=0; i<res.size(); i++){
			String coursename = res.elementAt(i);
			String coursedescription=db.getCourseTitle(coursename);
			double gpa = db.getGPA(coursename);
%>
		<div class="single-result">
			<div class="course-card">				
				<div class="course-id">
					<%-- <a href="DetailServlet?courseName=<%=coursename %>">
					<%=coursename %></a> --%>
					<a href="Detail.jsp?courseName=<%=coursename%>&courseDescription=<%=coursedescription%>">
					<%=coursename %></a>
				</div>
				
				<div class="course-title"><%=coursedescription%></div>
				<div class="course-discription">
					<p><%=coursedescription%></p>
				</div>
			</div>
			<div class="gpa">
				<div class="gpa-title">
					<strong>Overall</strong> <br />
					<h2 style="margin: 0; padding: 0;">GPA</h2>
				</div>
				<div class="gpa-number">
					<strong><%= db.getGPA(coursename)%></strong>
				</div>
			</div>
		</div>
<%
		}}
%>

<!-- below are placeholders -->

<!-- 		<div class="single-result">
			<div class="course-card">
				<div class="course-id">CSCI 201</div>
				<div class="course-title">Principle of Software Development</div>

				<div class="course-discription">
					<p>Object-oriented paradigm for programming-in-the-large in
						Java; writing sophisticated concurrent applications with animation
						and graphic user interfaces; using professional tools on team
						project.</p>
				</div>
			</div>
			<div class="gpa">
				<div class="gpa-title">
					<strong>Overall</strong> <br />
					<h2 style="margin: 0; padding: 0;">GPA</h2>
				</div>
				<div class="gpa-number">
					<strong>2.8</strong>
				</div>
			</div>
		</div> -->


	</div>


	<div id="sidebar">
		<h2 id="sidebar-title">Recommended</h2>
		
<%	
		Vector<String> recomm = new Vector<String>();
		if(searchby==null){
			System.out.println("searchby is null");//for debug
		}
		else{System.out.println("searchby "+searchby);//for debug
		if(searchby.contentEquals("Course")){
			recomm = db.getRecommendByCourse(input);
		}
		else{
			recomm = db.getRecommendByProf(input);
		}}		
		if(recomm.size()==0){
%>
		<p>Nothing to recommend</p>
<%
		}
		else{
		for(int i=0; i<recomm.size(); i++){
			String coursename = recomm.elementAt(i);
			String coursetitle = db.getCourseTitle(coursename);
%>
		<div class="recommend">
			<h3><%=coursename %></h3>
			<p><%=coursetitle%></p>
		</div>
<%
		}}
%>

		<!-- below are placeholders...needs to get from database -->

<!-- 	<div class="recommend">
			<h3>CSCI 270</h3>
			<p>Introduction to Algorithms and Theory of Computing</p>
		</div> -->

	</div>
	

</body>
</html>