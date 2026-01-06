<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Profile</title>
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
</head>
<body>
     <%
        String userId = request.getParameter("user_id");
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String balanceToAdd = request.getParameter("balance");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Establish database connection
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/project");

            // Build the update query
            StringBuilder query = new StringBuilder("UPDATE users SET name = ?, age = ?, email = ?, balance = balance + ?");
            
            // If password is provided, include it in the query
            if (password != null && !password.trim().isEmpty()) {
                query.append(", password = ?");
            }
            query.append(" WHERE user_id = ?");

            pstmt = conn.prepareStatement(query.toString());
            pstmt.setString(1, name);
            pstmt.setInt(2, age);
            pstmt.setString(3, email);
            pstmt.setDouble(4, balanceToAdd != null && !balanceToAdd.isEmpty() ? Double.parseDouble(balanceToAdd) : 0.0);
            
            // Set password if provided
            if (password != null && !password.trim().isEmpty()) {
                pstmt.setString(5, password);
                pstmt.setInt(6, Integer.parseInt(userId));
            } else {
                pstmt.setInt(5, Integer.parseInt(userId));
            }
            
            // Execute the update query
            int rowsAffected = pstmt.executeUpdate();
            
            // Provide feedback to the user
            if (rowsAffected > 0) {
                out.println("<div style=\" padding-top:10%;padding-bottom:10%;\" >Profile updated successfully!");
                out.println("<a href='UserDashboard.jsp'>Return to Dashboard</a></div>");
            } else {
                out.println("<p>Error: Profile update failed.</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    %>
</body>
</html>
