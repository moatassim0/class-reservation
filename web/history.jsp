<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Purchase History</title>
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
            .user
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
                    padding-left: 15%;
            }
            #result
            {
                    padding-left: 5%;
            }
            th, td
            {
                    padding: 10px;
            }


    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <header>
        <br><br>
        <h1>View Purchase History</h1>
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
        <a href="UserDashboard.jsp">Dashboard</a>
        <a href="browse_classes">Book</a>
        <a href="search.jsp">Search</a>
        <a href="#top">View History</a>
        <a href="updateProfile.jsp">Update Profile</a>

        <a>Balance: <span style="font-weight:700;color:palegreen"><%=balance%></span> AED</a>
        <a>Signed in as (<span style="font-weight:700;color:palegreen"><%=uname%></span>)</a>
        <a class="user" href="index.html">Log Out</a>
    </nav>

    <div>
        <h2>Your Purchase History</h2>
         <%
            if (userId == null) {
            // Inform the user to log in if user_id is not available
                out.println("<p>Error: You must be logged in to view your purchase history.</p>");
            } else {
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // Establish database connection
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    conn = DriverManager.getConnection("jdbc:derby://localhost:1527/project");

                    // Query to retrieve purchase history for the logged-in user
                    String query = "SELECT p.transaction_id, p.purchase_datetime, p.quantity, p.total_cost, c.name, c.picture_url " +
                                   "FROM purchases p " +
                                   "JOIN classes c ON p.class_id = c.class_id " +
                                   "WHERE p.customer_id = ? " +
                                   "ORDER BY p.purchase_datetime DESC";

                    pstmt = conn.prepareStatement(query);
                    pstmt.setInt(1, Integer.parseInt(userId));
                    rs = pstmt.executeQuery();

                    // Display results in a table
        %>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Transaction ID</th>
                    <th>Purchase Date & Time</th>
                    <th>Class Name</th>
                    <th>Quantity</th>
                    <th>Total Cost</th>
                    <th>Image</th>
                </tr>
            </thead>
            <tbody>
                 <%
                    boolean hasResults = false; // Track if results exist
                    while (rs.next()) {
                        hasResults = true;
                %>
                <tr>
                    <td><%= rs.getInt("transaction_id") %></td>
                    <td><%= rs.getTimestamp("purchase_datetime") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getInt("quantity") %></td>
                    <td><%= rs.getDouble("total_cost") %> AED</td>
                    <td>
                        <img src="<%= rs.getString("picture_url") %>" alt="Class Image" style="width:100px;height:100px;">
                    </td>
                </tr>
                <%
                    }
                    if (!hasResults) {
                %>
                <tr>
                    <td colspan="6">No purchases found. Start booking classes to see your history!</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <%
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
                }
            }
        %>
    </div>
</body>
</html>
