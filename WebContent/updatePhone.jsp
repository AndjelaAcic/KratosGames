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
		String phonenum = request.getParameter("phonenum");
		String retStr = null;

		if(username == null || phonenum == null)
				{session.setAttribute("updatePhoneMessage","Please enter a valid phone number");return null;}
		if((username.length() == 0) || (phonenum.length() == 0))
		{session.setAttribute("updatePhoneMessage","Please enter a valid phone number");return null;}
		try{
						getConnection();
					
					// TODO: Check if userId and phonenum match some customer account. If so, set retStr to be the username.
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
					session.setAttribute("updatePhoneMessage","Username doesn't exist in database");
					return null;

				}
				else
				{
					//update phonenum
					String sqlUpdate = "UPDATE customer SET phonenum = ? WHERE userid = ?";
					PreparedStatement stmtUpdate = con.prepareStatement(sqlUpdate);
					stmtUpdate.setString(1,phonenum);
					stmtUpdate.setString(2,username);
					stmtUpdate.executeUpdate();

					retStr = "Successfully updated phone number!";

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
			session.setAttribute("updatePhoneMessage",retStr);
		}
		else
			session.setAttribute("updatePhoneMessage","Could not register to the system using that username/phonenum.");

		return username;
	}
%>

