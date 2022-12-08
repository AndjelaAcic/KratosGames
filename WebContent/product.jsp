<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product

String productId = request.getParameter("id");

if(productId!=null)
{

    //make db connection
    getConnection();
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
	String uid = "sa";
	String pw = "304#sa#pw";
	try ( Connection con = DriverManager.getConnection(url, uid, pw);
	          Statement stmt = con.createStatement();) 
	    {
            String sql = "SELECT productName, productPrice, productImageURL, productImage, productDesc FROM product WHERE productId = ?";
            PreparedStatement pstmt =con.prepareStatement(sql);
            pstmt.setInt(1,Integer.parseInt(productId));
            ResultSet rst = pstmt.executeQuery();
            rst.next();
            out.print("<h2>"+rst.getString(1)+"</h2>");
            


            //display image with url if it exists
            String imgUrl = rst.getString(3);
            if(imgUrl!=null)         
           out.print("<img src="+imgUrl+">");
            
           String img = rst.getString(4);
           if(img!=null)
           { String imgLink = "displayImage.jsp?id="+productId;
            out.print("<img src="+imgLink +">");}

            out.print("<h2>Price: $"+rst.getString(2)+"</h2>");
            out.print("<h2>Id: "+productId+"</h2>");
            out.print("<b>Description: </b><p>"+rst.getString(5) +"</p>");

            String link = "addcart.jsp?id="+productId+"&name="+rst.getString(1)+"&price="+rst.getString(2);
			link =link.replace(" ","+");
					
					//link.replace("'","%27");
					out.print("<td><a href="+link+">Add to Cart</a></td>");
           
            


        }
        catch (SQLException ex)
		{
			out.println("SQLException: " + ex);
		}

    
    
}
else
{
    out.print("Error - no product id passed");
}
out.print("<h2><a href=\"listprod.jsp\">Continue Shopping</a></h2>");


// TODO: If there is a productImageURL, display using IMG tag
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping
%>

</body>
</html>

