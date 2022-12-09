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
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String postalCode = request.getParameter("postalCode");
		String country = request.getParameter("country");
		String retStr = null;

		if(username == null || address == null|| city == null|| state == null|| postalCode == null|| country == null)
				{session.setAttribute("updateAddreesMessage","Please enter a valid address!");return null;}
		if((username.length() == 0) || (address.length() == 0)|| (city.length() == 0)|| (state.length() == 0)|| (postalCode.length() == 0)||(country.length() == 0))
		{session.setAttribute("updateAddreesMessage","Please enter a valid address!");return null;}
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
					session.setAttribute("updateAddreesMessage","Username doesn't exist in database");
					return null;

				}
				else
				{
					//update phonenum
					String sqlUpdate = "UPDATE customer SET address = ?, city =?, state =?, postalCode =?, country=? WHERE userid = ?";
					PreparedStatement stmtUpdate = con.prepareStatement(sqlUpdate);
					stmtUpdate.setString(1,address);
					stmtUpdate.setString(2,city);
					stmtUpdate.setString(3,state);
					stmtUpdate.setString(4,postalCode);
					stmtUpdate.setString(5,country);
					stmtUpdate.setString(6,username);
					stmtUpdate.executeUpdate();

					retStr = "Successfully updated address!";

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
			session.setAttribute("updateAddreesMessage",retStr);
		}
		else
			session.setAttribute("updateAddreesMessage","Could not register to the system using that username/phonenum.");

		return username;
	}
%>

