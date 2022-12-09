<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);

	try
	{
		authenticatedUser = validateRegister(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

%>


<%!
	String validateRegister(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		try{
						getConnection();
					
					// TODO: Check if userId and email match some customer account. If so, set retStr to be the username.
					String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";		
				String uid = "sa";
				String pw = "304#sa#pw";
				try ( Connection con = DriverManager.getConnection(url, uid, pw);
					Statement stmt = con.createStatement();) 
				{
					//insert categories

					String[] platforms = {"PC", "XBOX One","PS4","PS5", "NS"};
					String sqlct = "INSERT INTO product(productName,productPrice,productImageURL,productDesc,categoryId) VALUES(?,?,?,?,?)";
					PreparedStatement stmtct = con.prepareStatement(sqlct);
					
					
					
					for(int i=0;i<platforms.length;i++)
					{
						String gamename = "New World ("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,23);
						stmtct.setDouble(2,59.99);
						stmtct.setString(3,"https://shorturl.at/bBEP2");
						stmtct.setString(4,"Explore a thrilling, open-world MMO filled with danger and opportunity where youw ill forge a new destiny on the supernatural island of Aeternum. ");
						stmtct.executeUpdate();
					}

					for(int i=0;i<platforms.length;i++)
					{
						String gamename = "Cuphead ("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,28);
						stmtct.setDouble(2,49.99);
						stmtct.setString(3,"https://shorturl.at/louyK");
						stmtct.setString(4,"Cuphead is a run-and-gun video game developed and published by Studio MDHR. ");
						stmtct.executeUpdate();
					}

				/*	
				

				for(int i=0;i<platforms.length;i++)
					{
						String gamename = "Resident Evil 3 ("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,27);
						stmtct.setDouble(2,9.99);
						stmtct.setString(3,"https://shorturl.at/ahowX");
						stmtct.setString(4,"Resident Evil 3 is a 2020 survival horror game developed and published by Capcom. It is a remake of the 1999 game Resident Evil 3: Nemesis. ");
						stmtct.executeUpdate();
					}
				for(int i=0;i<platforms.length;i++)
				{
					String gamename = "NBA2K20 ("+platforms[i]+" version)";
					stmtct.setString(1,gamename);
					stmtct.setInt(5,24);
					stmtct.setDouble(2,12.00);
					stmtct.setString(3,"https://shorturl.at/fhrCS");
					stmtct.setString(4,"NBA2K has delivered authentic basketball video games with cutting edge gameplay for 20 years to become an integral part of basketball culture.");
					stmtct.executeUpdate();
				}

				for(int i=0;i<platforms.length;i++)
					{
						String gamename = "Little Nightmares 2 ("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,25);
						stmtct.setDouble(2,12.00);
						stmtct.setString(3,"https://shorturl.at/ehyF4");
						stmtct.setString(4,"Immerse yourself in Little Nightmares, a dark whimsical tale that will confront you with your childhood fears! Help Six escape The Maw – a vast, mysterious vessel inhabited by corrupted souls looking for their next meal.");
						stmtct.executeUpdate();
					}

				for(int i=0;i<platforms.length;i++)
					{
						String gamename = "Little Nightmares("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,25);
						stmtct.setDouble(2,10.00);
						stmtct.setString(3,"https://shorturl.at/noRUV");
						stmtct.setString(4,"Immerse yourself in Little Nightmares, a dark whimsical tale that will confront you with your childhood fears! Help Six escape The Maw – a vast, mysterious vessel inhabited by corrupted souls looking for their next meal.");
						stmtct.executeUpdate();
					}

				for(int i=0;i<platforms.length;i++)
					{
						String gamename = "God of War 5("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,26);
						stmtct.setDouble(2,30.98);
						stmtct.setString(3,"https://shorturl.at/eLOS9");
						stmtct.setString(4,"God of War is an action-adventure game developed by Santa Monica Studio and published by Sony Interactive Entertainment. ");
						stmtct.executeUpdate();
					}

				for(int i=0;i<platforms.length;i++)
					{
						String gamename = "God of War 4("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,26);
						stmtct.setDouble(2,15.98);
						stmtct.setString(3,"https://shorturl.at/iuAG5");
						stmtct.setString(4,"God of War is an action-adventure game developed by Santa Monica Studio and published by Sony Interactive Entertainment. ");
						stmtct.executeUpdate();
					}
				
				for(int i=0;i<platforms.length;i++)
					{
						String gamename = "God of War 3("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,26);
						stmtct.setDouble(2,15.98);
						stmtct.setString(3,"https://shorturl.at/iuAG5");
						stmtct.setString(4,"God of War is an action-adventure game developed by Santa Monica Studio and published by Sony Interactive Entertainment. ");
						stmtct.executeUpdate();
					}
					for(int i=0;i<platforms.length;i++)
					{
						String gamename = "God of War 2("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,26);
						stmtct.setDouble(2,10.98);
						stmtct.setString(3,"https://shorturl.at/cfoFX");
						stmtct.setString(4,"God of War is an action-adventure game developed by Santa Monica Studio and published by Sony Interactive Entertainment. ");
						stmtct.executeUpdate();
					}
					
					for(int i=0;i<platforms.length;i++)
					{
						String gamename = "God of War 1("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,26);
						stmtct.setDouble(2,5.98);
						stmtct.setString(3,"https://shorturl.at/rLMUX");
						stmtct.setString(4,"God of War is an action-adventure game developed by Santa Monica Studio and published by Sony Interactive Entertainment. ");
						stmtct.executeUpdate();
					}
				
					for(int i=0;i<platforms.length;i++)
					{
						String gamename = "Far Cry 3("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,21);
						stmtct.setDouble(2,19.98);
						stmtct.setString(3,"https://shorturl.at/fgjk1");
						stmtct.setString(4,"Far Cry 3 is a 2012 first-person shooter game developed by Ubisoft Montreal and published by Ubisoft.");
						stmtct.executeUpdate();
					}
					
					for(int i=0;i<platforms.length;i++)
					{
						String gamename = "Detroit: Become Human ("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,26);
						stmtct.setDouble(2,29.98);
						stmtct.setString(3,"https://shorturl.at/evwT3");
						stmtct.setString(4,"Detroit: Become Human is a 2018 adventure video game developed by Quantic Dream and published by Sony Interactive Entertainment.");
						stmtct.executeUpdate();
					}

					for(int i=0;i<platforms.length;i++)
					{
						String gamename = "Call of Duty("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,21);
						stmtct.setDouble(2,89.98);
						stmtct.setString(3,"https://shorturl.at/uzO27");
						stmtct.setString(4,"The iconic first-person shooter game is back! Cross play, free maps and modes, and new engine deliver the largest technical leap in Call of Duty history.");
						stmtct.executeUpdate();
					}

					for(int i=0;i<platforms.length;i++)
					{
						String gamename = "AC Mirage("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,26);
						stmtct.setDouble(2,36.98);
						stmtct.setString(3,"https://shorturl.at/nyAD7");
						stmtct.setString(4,"Assassin's Creed is an open-world, action-adventure, and stealth game franchise published by Ubisoft and developed mainly by its studio Ubisoft Montreal using the game engine Anvil and its more advanced derivatives.");
						stmtct.executeUpdate();
					}
					
					for(int i=0;i<platforms.length;i++)
					{
						String gamename = "Assaissin's Creed 3 ("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,26);
						stmtct.setDouble(2,39.98);
						stmtct.setString(3,"https://shorturl.at/moQ34");
						stmtct.setString(4,"Assassin's Creed is an open-world, action-adventure, and stealth game franchise published by Ubisoft and developed mainly by its studio Ubisoft Montreal using the game engine Anvil and its more advanced derivatives.");
						stmtct.executeUpdate();
					}
					
					for(int i=0;i<platforms.length;i++)
					{
						String gamename = "Doom ("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,21);
						stmtct.setDouble(2,47.99);
						stmtct.setString(3,"https://shorturl.at/eoFHR");
						stmtct.setString(4,"Doom (stylized as DOOM) is a video game series and media franchise created by John Carmack, John Romero, Adrian Carmack, Kevin Cloud, and Tom Hall.");
						stmtct.executeUpdate();
					}

					for(int i=0;i<platforms.length;i++)
					{
						String gamename = "WOW ("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,20);//19 is sandbox
						stmtct.setDouble(2,12.99);
						stmtct.setString(3,"https://shorturl.at/szAGS");
						stmtct.setString(4,"World of Warcraft (WoW) is a massively multiplayer online role-playing game (MMORPG) released in 2004 by Blizzard Entertainment.");
						stmtct.executeUpdate();
					}

					for(int i=0;i<platforms.length;i++)
					{
						String gamename = "Minecraft ("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setString(5,"Sandbox");
						stmtct.setDouble(2,9.99);
						stmtct.setString(3,"https://shorturl.at/imI36");
						stmtct.setString(4,"Minecraft is a sandbox game developed by Mojang Studios. The game was created by Markus \"Notch\" Persson in the Java programming language. ");
						stmtct.executeUpdate();
					}

					for(int i=0;i<platforms.length;i++)
					{
						String gamename = "Sims 5 ("+platforms[i]+" version)";
						stmtct.setString(1,gamename);
						stmtct.setInt(5,19);//19 is sandbox
						stmtct.setDouble(2,29.99);
						stmtct.setString(3,"https://shorturl.at/AGZ17");
						stmtct.setString(4,"The Sims is a series of life simulation video games developed by Maxis and published by Electronic Arts. The franchise has sold nearly 200 million copies worldwide, and it is one of the best-selling video game series of all time.");
						stmtct.executeUpdate();
					}
					*/
/*
					stmtct.setString(1,"Real-time strategy (RTS)");
					stmtct.executeUpdate();

					stmtct.setString(1,"Shooters (FPS and TPS)");
					stmtct.executeUpdate();

					stmtct.setString(1,"Multiplayer online battle arena (MOBA)");
					stmtct.executeUpdate();

					stmtct.setString(1,"Role-playing");
					stmtct.executeUpdate();

					stmtct.setString(1,"Simulation and sports");
					stmtct.executeUpdate();

					stmtct.setString(1,"Puzzlers and party games");
					stmtct.executeUpdate();

					stmtct.setString(1,"Action-adventure");
					stmtct.executeUpdate();

					stmtct.setString(1,"Survival and horror");
					stmtct.executeUpdate();

					stmtct.setString(1,"Platformer");
					stmtct.executeUpdate();
					*/

				
				} 
				catch (SQLException ex) {
					out.println(ex);
				}
			}
			catch(Exception ex)
			{
				out.print("Exception: "+ex);
			}
		

		return null;
	}
%>

