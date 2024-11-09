<%@page import="java.sql.Connection"%>
<%@page import="hospital.group.db.DatabaseConnection" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>

<link href="${pageContext.request.contextPath}/assets/css/home.css" rel="stylesheet">

<%
 Connection con = null;
%>

<h2>Welcome to the Home Page!</h2>
<p>This is the main content for the home page.</p>

<div class="overview-container">
<div class="overViews">
<%
   try {
       con = DatabaseConnection.connect();
       Statement st = (Statement) con.createStatement();
       String query = "select count(*) from Patient";
       ResultSet rs = st.executeQuery(query);
       while (rs.next()) {
           int patient = rs.getInt(1);
%>

	<div class="outer-view">
		<div class="overview-data">
			<div>
				Patients
			</div>
			<div>
				<%= patient%>
			</div>
		</div>
	</div>
	 <%
        }
           con.close();
       } catch (Exception e) {
           e.printStackTrace();
       }
      %>
      
      
<%
   try {
       con = DatabaseConnection.connect();
       Statement st = (Statement) con.createStatement();
       String query = "select count(*) from User";
       ResultSet rs = st.executeQuery(query);
       while (rs.next()) {
           int user = rs.getInt(1);
%>

	<div class="outer-view">
		<div class="overview-data">
			<div>
				Users
			</div>
			<div>
				<%= user%>
			</div>
		</div>
	</div>
	 <%
        }
           con.close();
       } catch (Exception e) {
           e.printStackTrace();
       }
      %>
      
      </div>
</div>