<!DOCTYPE html>
<html>
<head>
<title>Ray's Grocery CheckOut Line</title>
</head>
<body>
    <%@ include file="header.jsp" %>
<h1>Enter your customer id and password to complete the transaction:</h1>

<!-- changed for bonus
    <form method="get" action="order.jsp">
<input type="text" name="customerId" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>
-->
<form method="get" action="order.jsp">
<p>Customer id:</p><input type="text" name="customerId" size="50"><br><br>
<p>Password:</p><input type="password" name="pass" size="50"><br><br>
<input type="submit" value="Submit">&nbsp;<input type="reset" value="Reset">
</form>

</body>
</html>

