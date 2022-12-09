<%@ include file="auth.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Edit Screen</title>
</head>
<body>
	<%@ include file="header.jsp" %>
<div style="margin:0 auto;text-align:center;display:inline">

<h3>Delete product</h3>

<%
// Print prior error login message if present
if (session.getAttribute("updatePassMessage") != null)
	{
		out.println("<p>"+session.getAttribute("updatePassMessage").toString()+"</p>");
	session.removeAttribute("updatePassMessage");
}
else if (session.getAttribute("updateEmailMessage") != null)
	{
		out.println("<p>"+session.getAttribute("updateEmailMessage").toString()+"</p>");
	session.removeAttribute("updateEmailMessage");
}
else if (session.getAttribute("updatePhoneMessage") != null)
	{
		out.println("<p>"+session.getAttribute("updatePhoneMessage").toString()+"</p>");
	session.removeAttribute("updatePhoneMessage");
}
else if (session.getAttribute("updateAddreesMessage") != null)
	{
		out.println("<p>"+session.getAttribute("updateAddreesMessage").toString()+"</p>");
	session.removeAttribute("updateAddreesMessage");
}


%>

<br>


<form name="MyForm3" method=post action="deleteprod.jsp">

	<table style="display:inline">
		<tr>
			<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product Name:</font></div></td>
			<td><input type="text" name="productname"  size=50 maxlength=50></td>
		</tr>
	</table>
	<br>
	<br>
	<input class="submit" type="submit" name="Submit2" value="Delete product">
</form>

</div>

</body>
</html>

