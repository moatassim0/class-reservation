<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
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
                    margin-top: 20%;
                    margin-left: 20%;
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
                    margin-top: 20%;
                    margin-right: 20%;
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
            <h1>Fitness Booking</h1>
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
                    userId = cookie.getValue();
                    break; // Exit loop once the user_id is found
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
        <a href="#purchase">Book</a>
        <a href="#search">Search</a>
        <a href="#history">View History</a>
        <a href="#update">Update Profile</a>
            
            
            <a>Balance: <span style="font-weight:700;;color:palegreen"><%= balance %></span> AED</a>
            <a>Signed in as (<span style="font-weight:700;;color:palegreen"><%= name %></span>)</a>
            <a class="user" href="index.html">Log Out</a>

    </nav>

    <br><br>

    <p id="intro">
            Welcome to our Fitness Class Booking System!<br>
            We provide fitness services, expert guidance, and personalized support on your journey to better health and wellness. Whether you're a seasoned fitness enthusiast or just starting your fitness journey, our platform is designed to empower you with the tools, knowledge, and motivation you need to achieve your fitness goals effectively. From tailored workout guides and nutrition plans to intuitive calculators and informative articles. Get ready to unleash your full potential and become the healthiest, happiest version of yourself.
    </p>

    
    <div id="purchase" class="leftbox">

    <h2>Book Classes Now!</h2>
    <p>
            Enroll into our many services that are designed to help you achieve your fitness goals and maintain a healthy lifestyle. Whether you're looking to shed excess pounds, build muscle, or simply improve your overall well-being, our services offer tailored solutions to meet your unique needs.
    </p>
    <button class="button"><a href="browse_classes">Book</a></button>

    </div>


    <div id="search" class="rightbox">

    <h2>Search your desired service</h2>
    <p>
            Here's a reliable tool for searching any service that may interest you.
    </p>
    <button class="button"><a href="search.jsp">Search</a></button>
    </div>




    <div id="history" class="leftbox">

    <h2>View your purchase history</h2>
    <p>
            Display your transactions that racked up over time in our dataset.
    </p>
    <button class="button"><a href="history.jsp">Learn More</a></button>
    </div>




    <div id="update" class="rightbox">

    <h2>Update your profile</h2>
    <p>
            Perhaps you did a typo when registering or entered the wrong info ? we have you covered with our tool that updates your details stored.
    </p>
    <button class="button"><a href="updateProfile.jsp">Update</a></button>
    </div>



    <div id="about-us" class="leftbox" style="margin-bottom:60px;">
    <h2>About Us</h2>
    <p>
            We are undergraduate students more than willing to dedicate our efforts to helping you achieve your fitness goals.
    </p>
    </div>
	
	
</body>
</html>
