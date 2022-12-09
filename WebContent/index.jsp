<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
        <title>Ray's Grocery Main Page</title>
</head>
<body>
<h1 align="center">Welcome to Ray's Grocery</h1>

<h2 align="center"><a href="login.jsp">Login</a></h2>
<h2 align="center"><a href="register.jsp">Register</a></h2>
<h2 align="center"><a href="editCustomer.jsp">Edit information</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>
<h2 align="center"><a href="listprodForReview.jsp">Review Products</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

<%
// TODO: Display user name that is logged in (or nothing if not logged in)

String userName = (String) session.getAttribute("authenticatedUser");

if(userName!=null)
out.print("<h3 align=\"center\"> Signed in as: "+userName+"</body><h3>");
%>

<h2 align="center">Our best sellers:</h2>

<div align="center">

<%
// Make the connection
getConnection();
// Print out the ResultSet
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
		String uid = "sa";
		String pw = "304#sa#pw";
		try ( Connection con = DriverManager.getConnection(url, uid, pw);
	          Statement stmt = con.createStatement();) 
	    {

                String sql = "SELECT top 5 productId, SUM(quantity) FROM orderproduct GROUP BY productId ORDER BY SUM(quantity) DESC";
                PreparedStatement pstmt = con.prepareStatement(sql);
                ResultSet rst = pstmt.executeQuery();

                String names = "";
                while(rst.next())
                {
                        String sql2 = "SELECT * FROM product WHERE productId = ?";
                        PreparedStatement pstmt2 = con.prepareStatement(sql2);
                        pstmt2.setString(1, rst.getString(1));
                        ResultSet rst2 = pstmt2.executeQuery();

                        rst2.next();

                        String name = rst2.getString(2);
                        String imgUrl = rst2.getString(4);
                        if(imgUrl!=null)         
                       { String linkprod ="product.jsp?id="+rst2.getString(1); 
                        out.print("<a href =" +linkprod+ ">"+"<img style=\"max-width: 200px; height: auto; margin:0px 20px\" src="+imgUrl+">"+"</a>");
                }

						
			//names+="<a href =" +linkprod+ " style=\" margin:0px 10px\">"+rst2.getString(2)+"</a>"+"\t";
                       // out.print("<p>"+ rst.getString(1) + " "+rst.getString(2) +"</p>");
                }

               // out.print("<br>"+names);

            }
        
        catch (SQLException ex)
        {
                out.println("SQLException: " + ex);
        }

%>
</div>
</body>
</head>


