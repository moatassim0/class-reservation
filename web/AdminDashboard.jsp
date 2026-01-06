<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
            body 
            {
                    margin: 0;
                    padding: 0;
                    font-family: Arial, sans-serif;
                    background-image: url('BG.jpg');
                    background-repeat: repeat;

            }

            header 
            {
                    background-color: seaGreen;
                    color: white;
                    padding: 1rem;
                    text-align: center;
            }

            #intro
            {
                    width: 80%;
                    margin-left:10%;
                    margin-right:10%;
                    padding:2%;
                    background-color:white;
                    opacity:0.8;
                    border-radius: 15px 50px;
            }

            nav 
            {
                    background-color: seaGreen;
                    color: white;
                    padding: 1rem;
                    text-align: center;
                    position: fixed;
                    width: 100%;
                    top: 0;
                    z-index: 1000;
                    max-height: 60px;
                    overflow-y: auto;


            }

            nav a 
            {
                    color: white;
                    text-decoration: none;
                    margin: 0 1rem;

            }

            nav a:hover 
            {
                    color: lightgray;
            }

            h1 
            {
                    color: white;
                    margin-bottom: 1rem;
            }

            p 
            {
                    line-height: 1.5;
                    margin-bottom: 1rem;
            }

            .button 
            {
                    background-color: seaGreen;
                    color: white;
                    padding: 0.5rem 1rem;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                    transition-duration: 0.5s;
            }

            .button:hover 
            {
                    background-color: green;
                     box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 50px 0 rgba(0,0,0,0.19);
            }

            .button a 
            {
                    color: white;
                    text-decoration: none;
            }

            .button a:hover 
            {
                    color: white;
            }

            .button:active 
            {
                    background-color: palegreen;
                    box-shadow: 0 5px #666;
                    transform: translateY(3px);
            }

            div.leftbox
            {
                    margin-top: 5%;
                    margin-left: 5%;
                    width:40%;
                    height:30%;
                    float:left;
                    clear:both;
                    background-image:linear-gradient(to bottom right, white, honeydew, palegreen);
                    box-shadow: 0 0 10px rgba(0, 0, 0, .7);
                    padding:2%;
                    border-radius: 15px 50px;

            }

            div.rightbox
            {
                    margin-top: 5%;
                    margin-right: 5%;
                    width:40%;
                    height:30%;
                    float:right;
                    clear:both;
                    background-image:linear-gradient(to bottom right, palegreen, honeydew, white);
                    box-shadow: 0 0 10px rgba(0, 0, 0, .7);
                    padding:2%;
                    border-radius: 15px 50px;
            }
            .user
            {
                    font-weight: 600;
                    background-image:linear-gradient(180deg, palegreen, seagreen, seagreen);
                    padding: 15px;
            }


    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <header>
            <br><br>
            <h1>Admin Dashboard</h1>
    </header>

    <%
        // Initialize variables
        double balance = 0.0;
        String name = "User"; // Default name

        // Retrieve user_id from cookie
        Cookie[] cookies = request.getCookies();
        String userId = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user_id".equals(cookie.getName())) {
                    userId = cookie.getValue(); // Extract user ID from cookie
                    break;
                }
            }
        }

        // Fetch balance and name from the database
        if (userId != null) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                // Establish database connection
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn = DriverManager.getConnection("jdbc:derby://localhost:1527/project");

                // Query to get the balance and name
                String query = "SELECT balance, name FROM users WHERE user_id = ?";
                pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, Integer.parseInt(userId));
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    balance = rs.getDouble("balance");
                    name = rs.getString("name");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                // Clean up resources
                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
            }
        }
    %>

    
    <nav class="Navbar fixed-top">
            <a href="#top">Dashboard</a>
            <a href="#add">Add Class</a>
            <a href="#updateClass">Update Class</a>
            <a href="#purchase">Book</a>
            <a href="#search">Search</a>
            <a href="#history">View History</a>
            <a href="#updateProfile">Update Profile</a>
            
            <a>Balance: <span style="font-weight:700;color:palegreen"><%=balance%></span> AED</a>
            <a>Signed in as (<span style="font-weight:700;color:palegreen"><%=name%></span>)</a>
            <a class="user" href="index.html">Log Out</a>
    </nav>

    <br><br>

    <p id="intro">
            Welcome to the Admin Dashboard<br>
            Here you have absolute control over the website functionalities and the data it stores.
             
    </p>

    
    <div id="add" class="leftbox">
    <h2>Add Classes</h2>
    <p>
            Admin option to create new classes and add them to the database.
    </p>
    <button class="button"><a href="add.jsp">Add</a></button>
    </div>


    <div id="updateClass" class="rightbox">
    <h2>Update Classes</h2>
    <p>
            Admin option to update class details.
    </p>
    <button class="button"><a href="updateClass.jsp">Update</a></button>
    </div>

    <div id="purchase" class="leftbox">
    <h2>Book</h2>
    <p>
            Search tool to find classes
    </p>
    <button class="button"><a href="browse_classes">Search</a></button>
    </div>

    <div id="search" class="rightbox">
    <h2>Search Classes</h2>
    <p>
            Book registration service
    </p>
    <button class="button"><a href="search.jsp">Search</a></button>
    </div>
    

    <div id="history" class="leftbox" ">
    <h2>Purchase History</h2>
    <p>
            View purchase history for admins
    </p>
    <button class="button"><a href="history.jsp">Learn More</a></button>
    </div>
	
    <div id="updateProfile" class="rightbox" style="margin-bottom:60px;">

    <h2>Update Profile</h2>
    <p>
            Tool to update profiles
    </p>
    <button class="button"><a href="updateProfile.jsp">Update</a></button>
    </div>
    
</body>
</html>
