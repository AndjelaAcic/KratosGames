<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);

	try
	{
		authenticatedUser = validateRegister(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null)
		response.sendRedirect("editCustomer.jsp");		// Successful login
	else
		response.sendRedirect("editCustomer.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	String validateRegister(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = (String) session.getAttribute("authenticatedUser");
		String email = request.getParameter("email");
		String retStr = null;

		if(username == null || email == null)
				{session.setAttribute("updateEmailMessage","Please enter a valid email");return null;}
		if((username.length() == 0) || (email.length() == 0))
		{session.setAttribute("updateEmailMessage","Please enter a valid email");return null;}
		try{
						getConnection();
					
					// TODO: Check if userId and email match some customer account. If so, set retStr to be the username.
					String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
				String uid = "sa";
				String pw = "304#sa#pw";
				try ( Connection con = DriverManager.getConnection(url, uid, pw);
					Statement stmt = con.createStatement();) 
				{
						
					//get customer data
				String sqlcust = "SELECT * FROM customer WHERE userid = ?";
				PreparedStatement custstmt = con.prepareStatement(sqlcust);
				custstmt.setString(1,username);
				ResultSet rst1 = custstmt.executeQuery();
				if(rst1 == null || !rst1.isBeforeFirst())
				{
					session.setAttribute("updateEmailMessage","Username doesn't exist in database");
					return null;

				}
				else
				{
					//update email
					String sqlUpdate = "UPDATE customer SET email = ? WHERE userid = ?";
					PreparedStatement stmtUpdate = con.prepareStatement(sqlUpdate);
					stmtUpdate.setString(1,email);
					stmtUpdate.setString(2,username);
					stmtUpdate.executeUpdate();

					retStr = "Successfully updated email!";

				}

				
				} 
				catch (SQLException ex) {
					out.println(ex);
				}
			}
			catch(Exception ex)
			{
				out.print("Exception: "+ex);
			}
		
		if(retStr != null)
		{
			session.setAttribute("authenticatedUser",username);
			session.setAttribute("updateEmailMessage",retStr);
		}
		else
			session.setAttribute("updateEmailMessage","Could not register to the system using that username/email.");

		return username;
	}
%>

