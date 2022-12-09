<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>
	<%@ include file="header.jsp" %>
<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");

	if(userName != null)
	{
		//retrive customer info

		getConnection();
		String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
		String uid = "sa";
		String pw = "304#sa#pw";
		out.print("<h2>Customer profile</h2>");
		out.print("<table class=\"styled-table\">");
		try ( Connection con = DriverManager.getConnection(url, uid, pw);
	          Statement stmt = con.createStatement();) 
	    {
			String sql = "SELECT * FROM customer WHERE userId = ?";
			PreparedStatement pstmt=con.prepareStatement(sql);
			pstmt.setString(1,userName);
			ResultSet rst1 = pstmt.executeQuery();
			if(rst1 == null || !rst1.isBeforeFirst())
		{
			out.print("Username doesn't exit in the databse");
		}
		else
		{
			rst1.next();
			out.print("<tr><th>Id</th><td>"+rst1.getString(1)+"</td></tr>");
			out.print("<tr><th>First Name</th><td>"+rst1.getString(2)+"</td></tr>");
			out.print("<tr><th>Last Name</th><td>"+rst1.getString(3)+"</td></tr>");
			out.print("<tr><th>Email</th><td>"+rst1.getString(4)+"</td></tr>");
			out.print("<tr><th>Phone</th><td>"+rst1.getString(5)+"</td></tr>");
			out.print("<tr><th>Address</th><td>"+rst1.getString(6)+"</td></tr>");
			out.print("<tr><th>City</th><td>"+rst1.getString(7)+"</td></tr>");
			out.print("<tr><th>State</th><td>"+rst1.getString(8)+"</td></tr>");
			out.print("<tr><th>Postal Code</th><td>"+rst1.getString(9)+"</td></tr>");
			out.print("<tr><th>Country</th><td>"+rst1.getString(10)+"</td></tr>");
			out.print("<tr><th>User Id</th><td>"+rst1.getString(11)+"</td></tr>");
		}
			
			
			
		}
		catch (SQLException ex)
		{
			out.println("SQLException: " + ex);
		}
		out.print("</table>");



	}
	else
	{
		out.print("User is not authenticated!");
	}
%>



</body>
</html>

