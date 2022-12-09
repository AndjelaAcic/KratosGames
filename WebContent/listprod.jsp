<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
</head>
<body>
	<%@ include file="header.jsp" %>



<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset"  value="Reset"> (Leave blank for all products)
</form>


<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
getConnection();
// Print out the ResultSet
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
		String uid = "sa";
		String pw = "304#sa#pw";
		try ( Connection con = DriverManager.getConnection(url, uid, pw);
	          Statement stmt = con.createStatement();) 
	    {		
			
				ResultSet rst,categoryrst;
			if(request.getParameter("productName")!=null) 
			{
				String s =request.getParameter("productName").toString();
				out.print("<h3>Products containing '"+s+"'</h3>");
				s=s.toLowerCase().trim();

				s="%"+s+"%";
				PreparedStatement innerstmt=con.prepareStatement("SELECT productId,productName,CONCAT('$',productPrice) AS pp, categoryId	FROM product WHERE LOWER(productName) LIKE ? ");
				innerstmt.setString(1,s);
				 rst = innerstmt.executeQuery();

				 
			
			}
			else
			{
			 rst = stmt.executeQuery("SELECT productId,productName,CONCAT('$',productPrice),  categoryId AS pp 	FROM product");
			}
			//LAB 10: adding category filter

			PreparedStatement categorystmt = con.prepareStatement("SELECT categoryId, categoryName FROM category");
			categoryrst = categorystmt.executeQuery();



			out.print("<h2>Search for products by category:</h2>");
			out.print("<h3>Select option \"All\" to show products from all categories!</h3>");
			out.print("<form method=\"get\" action=\"listprod.jsp\">");
			out.print("<input type=\"checkbox\" id=\"allCats\" name=\"allCats\" value=\"All\" checked>");
				out.print("<label for=\"allCats\"> "+ "All" +"</label><br>");

			HashMap<String,String> allCategories = new HashMap<>();
			while(categoryrst.next())
			{
				out.print("<input type=\"checkbox\" id="+"cat"+categoryrst.getString(1)+" name="+"cat"+ categoryrst.getString(1)+" value="+categoryrst.getString(2)+">");
				out.print("<label for="+ "cat"+ categoryrst.getString(1)+"> "+ categoryrst.getString(2)+"</label><br>");
				allCategories.put("cat"+categoryrst.getString(1),categoryrst.getString(2));
			}
			out.print("<br><input type=\"submit\" value=\"Filter\"></form>");
			
			out.print("<table class=\"styled-table\">  <thead>");
			out.print("<tr><th></th><th>Product Name</th><th>Category</th><th>Price</th></tr></thead>");
			

			//listing selected filters
			Map<String, String[]> parameters = request.getParameterMap();
			int countCat=0;
			out.print("\tCurrently showing categories: ");
			if(!parameters.containsKey("allCats"))
				for(String parameter : parameters.keySet()) {

					if(allCategories.containsKey(parameter))
						{out.print(allCategories.get(parameter)+" | ");countCat++;}
					/*if(parameter.toLowerCase().startsWith("question")) {
						String[] values = parameters.get(parameter);
						//your code here
					}*/
				}
			if(countCat==0) out.print("All");

			out.print("<h2>All products:</h2><tbody>");
			while (rst.next())
			{	
					//show if no categories are selected or it fits the category 
					if(countCat==0 || parameters.containsKey("cat"+rst.getString(4)))
					{	
						
						out.print("<tr>");
						
						String link = "addcart.jsp?id="+rst.getString(1)+"&name="+rst.getString(2)+"&price="+Double.parseDouble(rst.getString(3).substring(1));
						link =link.replace(" ","+");
						
						//link.replace("'","%27");
						out.print("<td><a href="+link+">Add to Cart</a></td>");
						String linkprod ="product.jsp?id="+rst.getString(1); 

						
						out.print("<td><a href =" +linkprod+ ">"+rst.getString(2)+"</a></td>");
						out.print("<td>"+allCategories.get("cat"+rst.getString(4))+"</td>");
						for(int i=3;i<4;i++)
						{
							out.print("<td>"+rst.getString(i)+"</td>");
						}
						out.print("</tr>");
					}
			}
			out.print("</tbody></table>");
		}
		catch (SQLException ex)
		{
			out.println("SQLException: " + ex);
		}
// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>