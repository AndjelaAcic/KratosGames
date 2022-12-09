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
		response.sendRedirect("test3.jsp");		// Successful login
	else
		response.sendRedirect("test3.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	String validateRegister(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String prodname = request.getParameter("prodname");
		String prodImagURL = request.getParameter("ImageURL");
		String price = request.getParameter("price");
		String desc = request.getParameter("description");
		String cat_id = request.getParameter("catID");
		String retStr = null;

		if(prodname == null || prodImagURL == null|| price == null|| desc == null|| cat_id == null)
				{session.setAttribute("updateAddreesMessage","Please enter a valid product!");return null;}
		if((prodname.length() == 0) || (prodImagURL.length() == 0)|| (price.length() == 0)|| (desc.length() == 0)||(cat_id.length() == 0))
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
						
					//adding
					String sqlUpdate = "UPDATE product SET productName =?, productImageURL =?, productPrice =?, productDesc =?, categoryId=? WHERE productName = ?";
					PreparedStatement stmtUpdate = con.prepareStatement(sqlUpdate);
					
                    stmtUpdate.setString(1,prodname);
					stmtUpdate.setString(2,prodImagURL);
					stmtUpdate.setDouble(3,Double.parseDouble(price));
					stmtUpdate.setString(4,desc);
					stmtUpdate.setInt(5,Integer.parseInt(cat_id));
                    stmtUpdate.setString(6,prodname);
					stmtUpdate.executeUpdate();
                    

					retStr = "Successfully updated!";
		
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

