<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
</head>
<body>
	<%@ include file="header.jsp" %>
	<form name ="form1" method ="get" action = "showcart.jsp" >

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
String deleteId = request.getParameter("delete");
String minusId = request.getParameter("minus");
String plusId = request.getParameter("plus");
if (productList == null || productList.size()==0)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	out.println("<h1>Your Shopping Cart</h1>");
	out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Subtotal</th></tr>");

	//if delete option is checked, remove item from HashMap
	if(deleteId != null)
	{
		productList.remove(deleteId);
	}
	else if (plusId!= null)
	{
		int newnum = Integer.parseInt(productList.get(plusId).get(3).toString())+1;
		productList.get(plusId).set(3,newnum);
		
	}
	else if (minusId!= null)
	{
		int newnum = Integer.parseInt(productList.get(minusId).get(3).toString())-1;
		if(newnum==0) 
		{
			productList.remove(minusId);
		}
		else
		{
			productList.get(minusId).set(3,newnum);
		}
		
		
	}

	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		
		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");
		int pid1 = Integer.parseInt(product.get(0).toString());
		String linkminus = "\"showcart.jsp?minus="+pid1+"\"";
		String linkplus = "\"showcart.jsp?plus="+pid1+"\"";
		
		out.print("<td ><a href="+ linkminus+"><img src=\"minus.png\" ></a>&nbsp;"+product.get(3)+"&nbsp;<a href="+ linkplus+"><img src=\"plus.png\" ></a></td>");
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td>");
		int pid = Integer.parseInt(product.get(0).toString());
		String linkDelete = "\"showcart.jsp?delete="+pid+"\"";
		out.print("<td align=\"right\"> &nbsp;&nbsp;&nbsp;&nbsp;<a href =" + linkDelete+"> Remove from Cart</a></td></tr>");
		out.println("</tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");

	out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
}
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
</form>
</body>
</html> 

