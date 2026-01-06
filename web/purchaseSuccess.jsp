<%-- 
    Document   : purchaseSuccess
    Created on : Nov 24, 2024, 11:01:10 PM
    Author     : G_ROOM
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <%
            Cookie cookies[] = request.getCookies();
            String userID = null;
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("user_id".equals(cookie.getName())) {
                        userID = cookie.getValue();
                        break;// Extract user ID from the cookie
                    }
                }
            }
            String balance = null; 
            String username = null;

            try {
                    Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/project");
                    
                    // Query to fetch user details based on user_id
                    String query = "select * from users where user_id = ?";
                    PreparedStatement st = conn.prepareStatement(query);
                    
                    st.setString(1, userID);
                    
                    ResultSet rs = st.executeQuery();
                    
                    rs.next();
                    
                    balance = rs.getString("balance");
                    username = rs.getString("name");
                    
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }

        %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Purchase Successful!</title>
        <link rel="stylesheet" href="main.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            .success-message {
                text-align: center;
                padding: 40px;
                border-radius: 10px;
                margin: 20px auto;
                max-width: 600px;
            }
            .success-icon {
                color: #198754;
                font-size: 48px;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <header>
        <div class="top bar" style="padding: 50px">
            <h1>Fitness Class Booking System</h1>
        </div>
    </header>
    <nav>
        <a href="UserDashboard.jsp">Dashboard</a>
        <a href="browse_classes">Book</a>
        <a href="search.jsp">Search</a>
        <a href="history.jsp">View History</a>
        <a href="updateProfile.jsp">Update Profile</a>

        <a>Balance: <span style="font-weight:700;color:palegreen"><%=balance%></span> AED</a>
        <a>Signed in as (<span style="font-weight:700;color:palegreen"><%=username%></span>)</a>
        <a class="user" href="index.html">Log Out</a>
    </nav>
    <body>
        <section>
            <div class="fbox">
                <div class="success-message">
                    <div class="success-icon">✓</div>
                    <h2 class="display-6 mb-4">Purchase Successful!</h2>
                    <p class="lead mb-4">Your fitness class has been booked successfully.</p>
                    <div class="mt-4">
                        <a href="browse_classes" class="btn btn-primary me-2">Browse More Classes</a>
                        <a href="UserDashboard.jsp" class="btn btn-outline-primary">Return to Dashboard</a>
                    </div>
                </div>
            </div>
        </section>
    </body>
</html>