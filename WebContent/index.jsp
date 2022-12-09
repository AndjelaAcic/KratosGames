<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
        <title>Kratos Games Main Page</title>
</head>
<body>
<h1 align="center">Welcome to Kratos Games</h1>

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

<%
// TODO: Display user name that is logged in (or nothing if not logged in)



if(userName!=null){
out.print("<h3 align=\"center\"> Recommended for "+userName+":</body><h3>");

        //32 to 156    
// all games user bought
out.print("<div align=\"center\">");
try ( Connection con = DriverManager.getConnection(url, uid, pw);
	          Statement stmt = con.createStatement();) 
	    {
                String sql1 = "SELECT orderproduct.productId FROM orderproduct INNER JOIN ordersummary ON ordersummary.orderId = orderproduct.orderId WHERE customerId = (SELECT customerId FROM customer WHERE userid = ?) ";
                PreparedStatement pstmt = con.prepareStatement(sql1);
                pstmt.setString(1, userName);
                ResultSet rst = pstmt.executeQuery();
                HashSet<Integer> hset = new HashSet<>();
                        HashSet<Integer> hset2 = new HashSet<>();
                ArrayList<Integer> itemstoshow = new ArrayList<>();
                        ArrayList<String> itemstoshowlink = new ArrayList<>();
                while(rst.next())
                {
                        hset.add(rst.getInt(1));
                    //    out.print(rst.getInt(1)+"<br>");
                }

                Random r = new Random();
                int low = 0;
                
                

                String sql2 = "SELECT * FROM product";
                PreparedStatement pstmt2 = con.prepareStatement(sql2);
                ResultSet rst2 = pstmt2.executeQuery();

             
                while(rst2.next())
                {
                       
                        int toaddid = rst2.getInt(1);
                        if(!hset.contains(toaddid))
                        {
                                itemstoshow.add(toaddid);
                                itemstoshowlink.add(rst2.getString(4));
                        }
                }
                int high = itemstoshow.size();
                while(hset2.size()!=5)
                {
                        
                      
                        int result = r.nextInt(high-low) + low;
                        hset2.add(result);
                        

                }
                for (Integer ele : hset2) {

                        String imgUrl = itemstoshowlink.get(ele);
                        if(imgUrl!=null)         
                       { String linkprod ="product.jsp?id="+itemstoshow.get(ele);
                        out.print("<a href =" +linkprod+ ">"+"<img style=\"max-width: 200px; height: auto; margin:0px 20px\" src="+imgUrl+">"+"</a>");
                        }
                    }


            }

            catch (SQLException ex)
            {
                    out.println("SQLException: " + ex);
            }
        }
        out.print("</div>");
%>
</body>
</html>


