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
		response.sendRedirect("delete_file.jsp");		// Successful login
	else
		response.sendRedirect("delete_file.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	String validateRegister(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String prodname = request.getParameter("productname");
		String retStr=null;

		if(prodname == null)
				{session.setAttribute("updateAddreesMessage","Please enter a valid product!");return null;}
		if((prodname.length() == 0))
		{session.setAttribute("updateAddreesMessage","Please enter a valid product!");return null;}
		try{
						getConnection();
					
					// TODO: Check if userId and phonenum match some customer account. If so, set retStr to be the username.
					String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
				String uid = "sa";
				String pw = "304#sa#pw";
				try ( Connection con = DriverManager.getConnection(url, uid, pw);
					Statement stmt = con.createStatement();) 
				{
						
					//delete
					String sqlUpdate = "DELETE FROM product where productName = ?";
					PreparedStatement stmtUpdate = con.prepareStatement(sqlUpdate);
					
                    stmtUpdate.setString(1,prodname);
                    stmtUpdate.executeUpdate();

			
                    

					retStr = "Successfully deleted product!";
		
				} 
				catch (SQLException ex) {
					out.println(ex);
                    retStr = ex.toString();
				}
			}
			catch(Exception ex)
			{
				out.print("Exception: "+ex);
                retStr = "Invalid entry!";
			}
		
		if(retStr != null)
		{
			session.setAttribute("updateAddreesMessage",retStr);
		}
		else
			session.setAttribute("updateAddreesMessage","Sorry!");

		return prodname;
	}
%>

