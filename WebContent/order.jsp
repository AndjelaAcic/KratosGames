<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
</head>
<body>
	<%@ include file="header.jsp" %>

<% 
// Get customer id
String custId = request.getParameter("customerId");
String passw = request.getParameter("pass");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");


///	NOTE MAKE ACTUAL VALIDATION
// Determine if valid customer id was entered
int cid =-1;
try
{
	cid =Integer.parseInt(custId);
	

	getConnection(); 
	String url1 = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
	String uid1= "sa";
	String pw1 = "304#sa#pw";

boolean flag = false, flagpass = false;
// Save order information to database
try ( Connection con1 = DriverManager.getConnection(url1, uid1, pw1);
	          Statement stmt1 = con.createStatement();) 
	{	
		//get customer data
		String sqlcust = "SELECT * FROM customer WHERE customerId = ?";
		PreparedStatement custstmt = con1.prepareStatement(sqlcust);
		custstmt.setInt(1,cid);
		ResultSet rst1 = custstmt.executeQuery();
		if(rst1 == null || !rst1.isBeforeFirst())
		{
			flag = true;
		}
		else
		{
			rst1.next();
			String actualpass = rst1.getString(12); //12th column in customer is password
			{
				if(!actualpass.equals(passw))
					flagpass =true;
			}
		}
	}
	catch(Exception ex)
	{
		flag = true;
		out.println(ex);
	}


	// Determine if there are products in the shopping cart
// If either are not true, display an error message
if(productList==null || productList.size() == 0)
{
	out.print("Error - empty cart");
}
else if(flag)
{
	out.print("Error - id not in database");
}
else if(flagpass)
{
	out.print("Error - password is incorrect");
}
else{
///display cart
out.println("<h1>Your Order Summary</h1>");
	out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Subtotal</th></tr>");

	double total =0;
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		
		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");

		out.print("<td align=\"center\">"+product.get(3)+"</td>");
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
		out.println("</tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");


// Make connection
getConnection(); 
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
String uid = "sa";
String pw = "304#sa#pw";


// Save order information to database
try ( Connection con = DriverManager.getConnection(url, uid, pw);
	          Statement stmt = con.createStatement();) 
	{	
		//get customer data
		String sqlcust = "SELECT * FROM customer WHERE customerId = ?";
		PreparedStatement custstmt = con.prepareStatement(sqlcust);
		custstmt.setInt(1,cid);
		ResultSet rst = custstmt.executeQuery();
		rst.next(); // move cursor to item
		
		String name = rst.getString(2)+" "+rst.getString(3); //customer Name
		String address = rst.getString(6);
		String city = rst.getString(7);
		String state = rst.getString(8);
		String postalCode = rst.getString(9);
		String country = rst.getString(10);
		
		//add to ordersummary

		String sql = "INSERT INTO ordersummary(orderDate,totalAmount, shiptoAddress, shiptoCity, shiptoState, shiptoPostalCode, shiptoCountry, customerId) VALUES (?,?,?,?,?,?,?,?)";
		PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
		
		//pstmt.setInt(1,orderId);
		pstmt.setDate(1, new java.sql.Date(System.currentTimeMillis()));
		pstmt.setDouble(2, total);
		pstmt.setString(3, address);
		pstmt.setString(4, city);
		pstmt.setString(5, state);
		pstmt.setString(6, postalCode);
		pstmt.setString(7, country);
		pstmt.setInt(8, cid);
		pstmt.executeUpdate();
		ResultSet keys = pstmt.getGeneratedKeys();
		keys.next();
		int orderId = keys.getInt(1);

		// add to orderproduct
	
		Iterator<Map.Entry<String, ArrayList<Object>>> iterator2 = productList.entrySet().iterator();
		while (iterator2.hasNext())
			{ 
				Map.Entry<String, ArrayList<Object>> entry = iterator2.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String productId = (String) product.get(0);
				String price = (String) product.get(2);
				double pr = Double.parseDouble(price);
				int qty = ( (Integer)product.get(3)).intValue();
				
				String innersql = "INSERT INTO orderproduct VALUES (?,?,?,?)";
				PreparedStatement innerstmt = con.prepareStatement(innersql);
				innerstmt.setInt(1,orderId);
				innerstmt.setInt(2,Integer.parseInt(productId));
				innerstmt.setInt(3,qty);
				innerstmt.setDouble(4,pr);
				innerstmt.executeUpdate();
			}

		out.print("<h1>Order completed. Will be shipped soon...</h1>");
		out.print("<h1>Your order reference number is: "+orderId+"</h1>");
		out.print("<h1>Shipping to customer:"+cid+" Name: "+name+"</h1>");

		//reset cart
		productList = new HashMap<>();
		session.setAttribute("productList", productList);
	}
catch (SQLException ex)
	{
			out.println("SQLException: " + ex);
	}
}
}
catch(Exception ex)
{
	out.print("Invalid customer id");
}



	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/

// Insert each item into OrderProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary

// Clear cart if order placed successfully
%>
</BODY>
</HTML>

