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

%>


<%!
	String validateRegister(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		try{
						getConnection();
					
					// TODO: Check if userId and email match some customer account. If so, set retStr to be the username.
					String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
				String uid = "sa";
				String pw = "304#sa#pw";
				try ( Connection con = DriverManager.getConnection(url, uid, pw);
					Statement stmt = con.createStatement();) 
				{
					//insert categories

					
					String sqlct = "INSERT INTO category(categoryName) VALUES(?)";
					PreparedStatement stmtct = con.prepareStatement(sqlct);
					stmtct.setString(1,"Sandbox");
					stmtct.executeUpdate();

					stmtct.setString(1,"Real-time strategy (RTS)");
					stmtct.executeUpdate();

					stmtct.setString(1,"Shooters (FPS and TPS)");
					stmtct.executeUpdate();

					stmtct.setString(1,"Multiplayer online battle arena (MOBA)");
					stmtct.executeUpdate();

					stmtct.setString(1,"Role-playing");
					stmtct.executeUpdate();

					stmtct.setString(1,"Simulation and sports");
					stmtct.executeUpdate();

					stmtct.setString(1,"Puzzlers and party games");
					stmtct.executeUpdate();

					stmtct.setString(1,"Action-adventure");
					stmtct.executeUpdate();

					stmtct.setString(1,"Survival and horror");
					stmtct.executeUpdate();

					stmtct.setString(1,"Platformer");
					stmtct.executeUpdate();
					

				
				} 
				catch (SQLException ex) {
					out.println(ex);
				}
			}
			catch(Exception ex)
			{
				out.print("Exception: "+ex);
			}
		

		return null;
	}
%>

