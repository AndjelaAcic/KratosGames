<%@ include file="auth.jsp"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
</head>
<body>
	<%@ include file="header.jsp" %>
<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
getConnection();

// Write query to retrieve all order summary records

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
		String uid = "sa";
		String pw = "304#sa#pw";
	
		
		String userName = (String) session.getAttribute("authenticatedUser");

	if(userName != null)
	{
		try ( Connection con = DriverManager.getConnection(url, uid, pw);
	         ) 
	    {		
			PreparedStatement stmt = con.prepareStatement("SELECT orderId,customer.customerId, CONCAT(firstName,' ', lastName) AS cname, CONCAT('$', totalAmount) AS ta FROM ordersummary JOIN customer ON customer.customerId=ordersummary.customerId  WHERE userid = ?");
			stmt.setString(1,userName);
			out.print("<table border=\"1\">");
			ResultSet rst = stmt.executeQuery();
			
			while (rst.next())
			{	
				out.print("<tr><th>OrderId</th><th>CustomerId</th><th>Customer Name</th><th>Total Amount</th></tr>");
				int orderid = rst.getInt(1);
				PreparedStatement innerstmt=con.prepareStatement("SELECT productId,quantity,CONCAT('$',price) AS prop FROM orderproduct WHERE orderId=?");
				innerstmt.setInt(1,orderid);
				ResultSet innerrst = innerstmt.executeQuery();
				out.print("<tr>");
				for(int i=1;i<5;i++)
				{
					out.print("<td>"+rst.getString(i)+"</td>");
				}
				out.print("</tr>");
				
				out.print("<tr align=\"right\"><td colspan=\"4\"><table border=\"1\">");
				out.print("<tr><th>ProductId</th><th>Quantity</th><th>Price</th></tr>");
				
				while (innerrst.next())
				{
					out.print("<tr>");
					for(int i=1;i<4;i++)
					{
						out.print("<td>"+innerrst.getString(i)+"</td>");
					}
					out.print("</tr>");
			
				}
				out.print("</table></td></tr>");
				
			}
			out.print("</table>");
		}
		catch (SQLException ex)
		{
			out.println("SQLException: " + ex);
		}
	}
	else
	{
		out.print("Please authenticate user before proceeding!");
	}
	

// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
%>

</body>
</html>

