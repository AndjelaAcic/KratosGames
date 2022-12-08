<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
	String productId = request.getParameter("orderId");
          
	// TODO: Check if valid order id
	Integer id = null;
	try{
		id = Integer.parseInt(productId);
	}
	catch(Exception ex)
	{
		out.print("error");
	}
	if(productId != null && id != null)
	{
		
		getConnection();
		String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
		String uid = "sa";
		String pw = "304#sa#pw";

		boolean allgood= true;
		try ( Connection con = DriverManager.getConnection(url, uid, pw);)
		{		
			Statement stmt = con.createStatement();

			con.setAutoCommit(false);// TODO: Start a transaction (turn-off auto-commit)

			// TODO: Retrieve all items in order with given id
			String sql = "SELECT * FROM orderproduct WHERE orderId = ?";
			PreparedStatement pstmt=con.prepareStatement(sql);
			pstmt.setInt(1,id);
			ResultSet rst = pstmt.executeQuery();
			con.commit();	

			//have to be from same warehouse so store in list
			
			while(rst.next())
			{
				Integer prodId = Integer.parseInt(rst.getString(2));
				Integer prodQty = Integer.parseInt(rst.getString(3));
				
				String sql2 = "SELECT quantity FROM productinventory WHERE prodId = ? AND warehouseId =1 ";
				PreparedStatement pstmt2=con.prepareStatement(sql2);
				pstmt2.setInt(1,id);
				ResultSet rst2 = pstmt2.executeQuery();
				
				rst2.next();
				con.commit();
				Integer qtyindb = Integer.parseInt(rst2.getString(1));
			
				if(qtyindb>=prodQty)
				{
					int updateqty  =qtyindb-prodQty;
					String sql3 = "UPDATE productinventory SET quantity=? WHERE prodId = ? AMD warehouseId=1";
					PreparedStatement pstmt3=con.prepareStatement(sql3);
					pstmt3.setInt(2,id);
					pstmt3.setInt(1,updateqty);
					pstmt3.executeUpdate();
					con.commit();
					out.print("Ordered product: "+prodId+ "Qty:"+prodQty+"Previous inventory:"+qtyindb+"New inventory:"+updateqty);

				}
				else
				{
					out.print("Not enough qty for product "+prodId);
					allgood = false;
					break;
				}
				
				
				
			}

			
			if(allgood)
			{
				// Commit this transaction
				String sql4 = "INSERT INTO shipment(shipmentDate,warehouseId) VALUES (?,1)";
				PreparedStatement pstmt4 = con.prepareStatement(sql4, Statement.RETURN_GENERATED_KEYS);	
				pstmt4.setDate(1, new java.sql.Date(System.currentTimeMillis()));
				pstmt4.executeUpdate();
				out.print("Shipment successfully processed!");
				con.commit();
			}
			

						
		}
		catch (SQLException ex) {
			System.err.println("SQLException: " + ex); }
	}
	else 
		out.print("Invalid id");
	

	
	// TODO: Retrieve all items in order with given id
	// TODO: Create a new shipment record.
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on

	

%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
