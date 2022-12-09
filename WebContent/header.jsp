<style>
    body {
      margin: 0;
      font-family: Arial, Helvetica, sans-serif;
    }
    
    .example { background-color: #3d195f; } 

    .topnav {
      overflow: hidden;
      background-color: #333;
    }
    
    .topnav a {
      float: left;
      color: #f2f2f2;
      text-align: center;
      padding: 14px 16px;
      text-decoration: none;
      font-size: 17px;
    }
    
    .topnav a:hover {
      background-color: #ddd;
      color: black;
    }
    
    .topnav a.active {
      background-color: #04AA6D;
      color: white;
    }
    </style>
<H1 class ="example" align="center">
    <font class ="example" color="#3399FF">
       
        <div>
          <a href="index.jsp">
          <img style="max-width: 300px; height: auto;" src="logopurple.png"></a>
        </div>
        <div class="topnav">
          <a class="active" href=\"editCustomer.jsp\">Home</a>
          <a href=\"register.jsp\">News</a>
          <a href=\"login.jsp\">Login</a>
          <a href=\"listorder.jsp\">List all orders</a>
          <a href=\"customer.jsp\">customer</a>
          <a href=\"logout.jsp\">Log Out</a>
          <a href=\"admin.jsp\">Admin</a>
        </div>
    </font>
</H1>  
<%
// TODO: Display user name that is logged in (or nothing if not logged in)

String headUser = (String) session.getAttribute("authenticatedUser");

if(headUser!=null)
out.print("<h3 align=\"center\"> Signed in as: "+headUser+"</body><h3>");
%>    
<hr>
