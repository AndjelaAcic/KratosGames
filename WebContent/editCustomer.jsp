<%@ include file="auth.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Edit Screen</title>
</head>
<body>
	<%@ include file="header.jsp" %>
<div style="margin:0 auto;text-align:center;display:inline">

<h3>Edit your information</h3>

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


<form name="MyForm2" method=post action="updatePassword.jsp">

	<table style="display:inline">
	<tr>
		<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
		<td><input type="password" name="password" size=50 maxlength="50"></td>
	</tr>
</table>
<br>
	<br>
	<input class="submit" type="submit" name="Submit2" value="Update Password">
</form>
<br>
	<br>
<form name="MyForm3" method=post action="updateAddress.jsp">

	<table style="display:inline">
		<tr>
			<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Address:</font></div></td>
			<td><input type="text" name="address"  size=50 maxlength=50></td>
		</tr>
		<tr>
			<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">City:</font></div></td>
			<td><input type="text" name="city"  size=50 maxlength=50></td>
		</tr>
		<tr>
			<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">State:</font></div></td>
			<td><input type="text" name="state"  size=50 maxlength=50></td>
		</tr>
		<tr>
			<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Postal Code:</font></div></td>
			<td><input type="text" name="postalCode"  size=50 maxlength=50></td>
		</tr>
		<tr>
			<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Country:</font></div></td>
			<td><input type="text" name="country"  size=50 maxlength=50></td>
		</tr>
	</table>
	<br>
	<br>
	<input class="submit" type="submit" name="Submit2" value="Update Address">
</form>
<br>
	<br>
<form name="MyForm4" method=post action="updateEmail.jsp">

	<table style="display:inline">
		<tr>
			<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
			<td><input type="text" name="email"  size=50 maxlength=50></td>
		</tr>
</table>
<br>
	<br>
	<input class="submit" type="submit" name="Submit2" value="Update Email">
</form>
<br>
	<br>
<form name="MyForm4" method=post action="updatePhone.jsp">

	<table style="display:inline">
		<tr>
			<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Phone Number:</font></div></td>
			<td><input type="text" name="phonenum"  size=50 maxlength=50></td>
		</tr>
</table>
<br>
	<br>
	<input class="submit" type="submit" name="Submit2" value="Update Phone number">
</form>


</div>

</body>
</html>

