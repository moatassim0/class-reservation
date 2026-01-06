<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Class</title>
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

            div
            {
                    margin: auto;
                    width:40%;
                    height:30%;
                    clear:both;
                    background-color: white;
                    box-shadow: 0 0 10px rgba(0, 0, 0, .7);
                    padding:2%;
                    border-radius: 15px 50px;
                    text-align: center; 
                    margin-top: 100px
            }
            #user
            {
                    font-weight: 500;
                    background-image:linear-gradient(180deg, palegreen, seagreen, seagreen);
                    padding: 15px;
            }
            input 
            {
                    padding: 10px 10px;
                    margin: 5px 0;
                    box-sizing: border-box;
                    border-radius: 9px;
            }

            input:focus 
            {
                    border: 3px solid gray;
            }
            table
            {
                    padding-left: 20%;
            }
            .user
            {
                    font-weight: 600;
                    background-image:linear-gradient(180deg, palegreen, seagreen, seagreen);
                    padding: 15px;
            }
            .success
            {
                margin-bottom:10%;
                color:seagreen;
                font-weight: 500;
            }
            .error
            {
                margin-bottom:10%;
                color:red;
                font-weight: 500;
            }


    </style>
</head>
<body>
    <header>
        <br>
        <h1>Add New Class</h1>
    </header>
    <%
        // Initialize variables
        double balance = 0.0;
        String uname = "User"; // Default name

        // Retrieve user_id from cookie
        Cookie[] cookies = request.getCookies();
        String userId = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user_id".equals(cookie.getName())) {
                    userId = cookie.getValue();
                    break;// Extract user_id from the cookie
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
                    uname = rs.getString("name");
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
    
    <nav>
        <a href="AdminDashboard.jsp">Dashboard</a>
        <a href="#top">Add Class</a>
        <a href="updateClass.jsp">Update Class</a>
        <a href="browse_classes">Book</a>
        <a href="search.jsp">Search</a>
        <a href="history.jsp">View History</a>
        <a href="updateProfile.jsp">Update Profile</a>
            
            <a>Balance: <span style="font-weight:700;color:palegreen"><%=balance%></span> AED</a>
            <a>Signed in as (<span style="font-weight:700;color:palegreen"><%=uname%></span>)</a>
            <a class="user" href="index.html">Log Out</a>
    </nav>
    

    <div class="container">
        <h2>Enter New Class Details</h2>
        <form method="post" action="">
            <table>
            <tr>    
                <td><label for="name">Class Name:</label></td>
                <td><input type="text" id="name" name="name" required></td>
            </tr>
            <tr>
                <td><label for="price">Price (AED):</label></td>
                <td><input type="number" id="price" name="price" step="10" required></td>
            </tr>
            <tr>    
                <td><label for="quantity">Available Seats:</label></td>
                <td><input type="number" id="quantity" step="1" name="quantity" required></td>
            </tr>
            <tr>
                <td><label for="picture_url">Class Picture URL:</label></td>
                <td><input type="text" id="picture_url" name="picture_url"></td>
            </tr>
            <tr>
                <td><label for="class_datetime">Class Date & Time:</label></td>
                <td><input type="datetime-local" id="class_datetime" name="class_datetime" required></td>
            </tr>
                <td></td>
                <td>
                    <button class="button" type="submit">Add Class</button>
                    <button class="button" type="reset">Clear</button>
                </td>
            </table>
        </form>
    </div>

    <% 
        // Server-side logic for adding the class to the database
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String name = request.getParameter("name");
            String price = request.getParameter("price");
            String quantity = request.getParameter("quantity");
            String pictureUrl = request.getParameter("picture_url");
            String classDatetime = request.getParameter("class_datetime");

            Connection connection = null;
            PreparedStatement preparedStatement = null;

            try {
                // Database connection
                Class.forName("org.apache.derby.jdbc.ClientDriver"); // Change driver if needed
                connection = DriverManager.getConnection("jdbc:derby://localhost:1527/project");

                // SQL to insert a new class
                String sql = "INSERT INTO classes (name, price, available_quantity, picture_url, class_datetime) VALUES (?, ?, ?, ?, ?)";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, name);
                preparedStatement.setBigDecimal(2, new java.math.BigDecimal(price));
                preparedStatement.setInt(3, Integer.parseInt(quantity));
                preparedStatement.setString(4, pictureUrl);
                preparedStatement.setTimestamp(5, Timestamp.valueOf(classDatetime.replace("T", " ") + ":00"));

                int rowsInserted = preparedStatement.executeUpdate();

                if (rowsInserted > 0) {
    %>
                    <div class="success">Class added successfully!</div>
    <% 
                } else {
    %>
                    <div class="error">Failed to add the class. Please try again.</div>
    <% 
                }
            } catch (Exception e) {
    %>
                <div class="error">Error: <%= e.getMessage() %></div>
    <%
            } finally {
                try {
                    if (preparedStatement != null) preparedStatement.close();
                    if (connection != null) connection.close();
                } catch (SQLException ex) {
                    // Ignore cleanup exceptions
                }
            }
        }
    %>
</body>
</html>
