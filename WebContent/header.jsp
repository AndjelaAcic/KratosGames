<H1 align="center"><font face="cursive" color="#3399FF"><a href="index.jsp">Andela's Grocery</a></font></H1>  
<%
// TODO: Display user name that is logged in (or nothing if not logged in)

String headUser = (String) session.getAttribute("authenticatedUser");

if(headUser!=null)
out.print("<h3 align=\"center\"> Signed in as: "+headUser+"</body><h3>");
%>    
<hr>
