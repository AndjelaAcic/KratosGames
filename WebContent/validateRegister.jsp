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
		response.sendRedirect("register.jsp");		// Successful login
	else
		response.sendRedirect("register.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	String validateRegister(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String phonenum = request.getParameter("phonenum");
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String postalCode = request.getParameter("postalCode");
		String country = request.getParameter("country");
		String retStr = null;
		Integer genId = null;

		if(username == null || password == null|| firstName == null || lastName == null || email == null|| phonenum == null || address == null|| city == null|| state == null|| postalCode == null|| country == null)
				{session.setAttribute("registerMessage","Please fill in all fields to register");return null;}
		if((username.length() == 0) || (password.length() == 0)|| (firstName.length() == 0) || (lastName.length() == 0)|| (email.length() == 0)|| (phonenum.length() == 0)|| (address.length() == 0)|| (city.length() == 0)|| (state.length() == 0)|| (postalCode.length() == 0)||(country.length() == 0))
		{session.setAttribute("registerMessage","Please fill in all fields to register");return null;}
		try{
						getConnection();
					
					// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
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
					//add new user to database
					String sqladd = "INSERT INTO customer(userid, password, firstName, lastName, email, phonenum,address,city,state,postalCode,country) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
					PreparedStatement stmtadd = con.prepareStatement(sqladd,  Statement.RETURN_GENERATED_KEYS);
					stmtadd.setString(1,username);
					stmtadd.setString(2,password);
					stmtadd.setString(3,firstName);
					stmtadd.setString(4,lastName);
					stmtadd.setString(5,email);
					stmtadd.setString(6,phonenum);
					stmtadd.setString(7,address);
					stmtadd.setString(8,city);
					stmtadd.setString(9,state);
					stmtadd.setString(10,postalCode);
					stmtadd.setString(11,country);
					stmtadd.executeUpdate();

					ResultSet keys = stmtadd.getGeneratedKeys();
					keys.next();
					int generatedUserId = keys.getInt(1);
					genId = generatedUserId; //user id for confirming checkout
					retStr = username;

				}
				else
				{
					//error user exists
					return null;
					
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
		{	session.removeAttribute("registerMessage");
			session.setAttribute("authenticatedUser",username);
			session.setAttribute("authenticatedUserId",genId);
		}
		else
			session.setAttribute("registerMessage","Could not register to the system using that username/password.");

		return retStr;
	}
%>

