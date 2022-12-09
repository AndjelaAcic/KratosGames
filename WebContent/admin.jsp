<%@ include file="auth.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
  // Load the Visualization API and the corechart package.
  
  // Set a callback to run when the Google Visualization API is loaded.
  //google.charts.setOnLoadCallback(drawChart);
  // Callback that creates and populates a data table,
  // instantiates the pie chart, passes in the data and
  // draws it.
  
  
</script>
</head>
<body>

	<%@ include file="header.jsp" %>

<%
// TODO: Include files auth.jsp and jdbc.jsp
%>
<%
String userName = (String) session.getAttribute("authenticatedUser");
	if(userName != null)
	{
		//retrive customer info
		getConnection();
		String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
		String uid = "sa";
		String pw = "304#sa#pw";
		out.print("<h2>Things you can change</h2>");
		out.print("<br>");
		out.print("<a href=\"test1.jsp\"><h2>Add products</h2></a>");
		out.print("<h2><a href=\"delete_file.jsp\">Delete products</a></h2>");
		out.print("<h2><a href=\"test3.jsp\">Update products</a></h2>");
		out.print("<br>");
		out.print("<h2>Customer profile</h2>");
		out.print("<table border=\"1\"><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
		try ( Connection con = DriverManager.getConnection(url, uid, pw);
	          Statement stmt = con.createStatement();) 
	    {
			String sql = "SELECT  year(orderDate),month(orderDate),day(orderDate), CONCAT('$',SUM (totalAmount)) as amt FROM ordersummary GROUP BY year(orderDate),month(orderDate),day(orderDate)" ; 
			PreparedStatement pstmt=con.prepareStatement(sql);
			ResultSet rst1 = pstmt.executeQuery();
			ArrayList<String> listofDates = new ArrayList<>();
				ArrayList<Double> listofNums= new ArrayList<>();
			while(rst1.next())
            {
				String date =rst1.getString(1)+"-"+rst1.getString(2)+"-"+rst1.getString(3);
				String date1= rst1.getString(1);
				if(rst1.getString(2).length()!=2)
					date1+="0"+rst1.getString(2);
				else
					date1+=rst1.getString(2);
				if(rst1.getString(3).length()!=2)
					date1+="0"+rst1.getString(3);
				else
					date1+=rst1.getString(3);
				listofDates.add(date1);
				listofNums.add(Double.parseDouble(rst1.getString(4).substring(1)));
                out.print("<tr><td>"+date+"</td>");
                out.print("<td>"+rst1.getString(4)+"</td></tr>");
            }
			out.print("</table>");
			out.print("<h2>All registered customers: </h2>");
			out.print("<table border=\"1\"><tr><th>Customer Id</th><th>First Name</th><th>Last Name</th><th>Email</th><th>State</th><th>Phone Number:</th></tr>");
			String sql2 = "SELECT  customerId,firstName,lastName,email, state, phonenum FROM customer" ; 
			PreparedStatement pstmt2=con.prepareStatement(sql2);
			ResultSet rst2 = pstmt2.executeQuery();
			while(rst2.next())
			{
				out.print("<tr>");
				for(int i=1;i<=6;i++)
				{
					out.print("<td>"+ rst2.getString(i)+"</td>");
				}
				out.print("</tr>");
			}
			
			out.print("</table>");
			%>
			<div id="chart_div"></div>
		<script>
			function test(i){
        alert(i);
    }
			function drawChart(dates, sales) {
				sales = <% out.print(listofNums);%>;
				dates = <% out.print(listofDates);%>;
	var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
	
	// Create the data table.
	var data = new google.visualization.DataTable();
      data.addColumn('date', 'X');
      data.addColumn('number', 'Total Order Amount per Date');
	  for (let i = 0; i < dates.length; i++) {
        const str = String(dates[i]);
        const d = new Date(str.substring(0,4)+"-"+str.substring(4,6)+"-"+str.substring(6,8));
        data.addRow([d,sales[i]]);
      }
	  
    /*
		data.addRows([
			[0, 0],   [1, 10],  [2, 23],  [3, 17],  [4, 18],  [5, 9],
			[6, 11],  [7, 27],  [8, 33],  [9, 40],  [10, 32], [11, 35],
			[12, 30], [13, 40], [14, 42], [15, 47], [16, 44], [17, 48],
			[18, 52], [19, 54], [20, 42], [21, 55], [22, 56], [23, 57],
			[24, 60], [25, 50], [26, 52], [27, 51], [28, 49], [29, 53],
			[30, 55], [31, 60], [32, 61], [33, 59], [34, 62], [35, 65],
			[36, 62], [37, 58], [38, 55], [39, 61], [40, 64], [41, 65],
			[42, 63], [43, 66], [44, 67], [45, 69], [46, 69], [47, 70],
			[48, 72], [49, 68], [50, 66], [51, 65], [52, 67], [53, 70],
			[54, 71], [55, 72], [56, 73], [57, 75], [58, 70], [59, 68],
			[60, 64], [61, 60], [62, 65], [63, 67], [64, 68], [65, 69],
			[66, 70], [67, 72], [68, 75], [69, 80]
		]);*/
	  
      var options = {
        hAxis: {
          title: 'Date'
        },
        vAxis: {
          title: 'Total Order Amount($)'
        }
      };
      
      chart.draw(data, options);
  }
		google.charts.load('current', {'packages':['corechart']}).then(drawChart);
		</script>
		<%
			
		}
		catch (SQLException ex)
		{
			out.println("SQLException: " + ex);
		}
		
		
	}
	else
	{
		out.print("User is not authenticated!");
	}
	
%>

</body>
</html>
