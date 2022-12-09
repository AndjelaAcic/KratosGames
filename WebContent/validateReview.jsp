<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ page import="java.util.*" %>
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
		response.sendRedirect("listprodForReview.jsp");		// Successful login
	else
		response.sendRedirect("listprodForReview.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	String validateRegister(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = (String) session.getAttribute("authenticatedUser");
		String prodId = (String) session.getAttribute("currectProductId"); 
		String reviewScore = request.getParameter("reviewScore");
		String comment = request.getParameter("comment");
		String retStr = null;

		if(username == null ||prodId==null|| reviewScore== null ||comment==null)
				{session.setAttribute("reviewProdMessage","Please enter a valid review");return null;}
		if((username.length() == 0) || (prodId.length() == 0)|| (reviewScore.length() == 0)|| (comment.length() == 0))
		{session.setAttribute("reviewProdMessage","Please enter a valid review");return null;}
		Integer idint = null, reviewInt;
		try{
			idint = Integer.parseInt(prodId);
			reviewInt = Integer.parseInt(reviewScore);
			if(reviewInt<1 || reviewInt>10)
				{
					session.setAttribute("reviewProdMessage","Error:Please enter a valid score (1-10) ");return null;
				}
		}
		catch(Exception ex)
		{
			session.setAttribute("reviewProdMessage","Error:Please enter a valid score (1-10) ");return null;
		}
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
					session.setAttribute("reviewProdMessage","Username doesn't exist in database");
					return null;

				}
				else
				{
					rst1.next();
					Integer cIDDB = rst1.getInt(1);
					//see if customer already has a review on this product
					String sqlCheck = "SELECT reviewId FROM review WHERE customerId = ? AND productId = ? ";
					PreparedStatement stmtCheck = con.prepareStatement(sqlCheck);
					stmtCheck.setInt(1,cIDDB);
					stmtCheck.setInt(2,idint);
					ResultSet rstCheck = stmtCheck.executeQuery();


					if(rstCheck == null || !rstCheck.isBeforeFirst())
					{
						//update phonenum
						String sqlInsert = "INSERT INTO  review(reviewRating, reviewDate, customerId, productId, reviewComment) VALUES(?,?,?,?,?)";
						PreparedStatement stmtInsert = con.prepareStatement(sqlInsert);
						stmtInsert.setInt(1,reviewInt);
						stmtInsert.setDate(2,new java.sql.Date(System.currentTimeMillis()));
						stmtInsert.setInt(3,cIDDB);
						stmtInsert.setInt(4,idint);
						stmtInsert.setString(5,comment);
						stmtInsert.executeUpdate();

						retStr = "Successfully reviewed product "+prodId+"!";

					}
					else
					{
						retStr = "Error: You have already reviewed product "+prodId+"!";
					}

				}

				
				} 
				catch (SQLException ex) {
					retStr =ex.toString();
				}
			}
			catch(Exception ex)
			{
				out.print("Exception: "+ex);
			}
		
		if(retStr != null)
		{
			//session.setAttribute("authenticatedUser",username);
			session.setAttribute("reviewProdMessage",retStr);
		}
		else
			session.setAttribute("reviewProdMessage","Could not submit review");

		return username;
	}
%>

