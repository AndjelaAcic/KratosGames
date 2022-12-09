<style>
.styled-table {
    border-collapse: collapse;
    margin: 25px ;
    font-size: 0.9em;
    font-family: sans-serif;
    min-width: 400px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
}

.styled-table thead tr {
    background-color: #1d82be;
    color: #ffffff;
    text-align: left;
}

.styled-table th,
.styled-table td {
    padding: 12px 15px;
}

.styled-table tbody tr {
    border-bottom: 1px solid #dddddd;
}

.styled-table tbody tr:nth-of-type(even) {
    background-color: #f3f3f3;
}

.styled-table tbody tr:nth-of-type(odd) {
    background-color:#cfeffb;
}

.styled-table tbody tr:last-of-type {
    border-bottom: 2px solid #cfeffb;
}

.styled-table tbody tr.active-row {
    font-weight: bold;
    color: #009879;
}

    body {
      margin: 0;
      font-family: Arial, Helvetica, sans-serif;
      background-color: #ebd7d0;
    }
    
    .example { background-color: #3d195f; } 

    .topnav {
      overflow: hidden;
      background-color: #10aee9;
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
      background-color: #d648bc;
      color: black;
    }
    
    .topnav a.active {
      background-color: #324e92;
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
          <a class="active" href="index.jsp">Home</a>
          <a href="register.jsp">Register</a>
          <a href="login.jsp">Login</a>
          <a href="editCustomer.jsp">Edit information</a>
          <a href="listprod.jsp">Begin Shopping</a>
          <a href="listprodForReview.jsp">Review Products</a>
          <a href="listorder.jsp">List orders</a>
          <a href="customer.jsp">Customer Info</a>
      
          <a href="admin.jsp">Admin</a>
          <a href="logout.jsp">Log Out</a>
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
