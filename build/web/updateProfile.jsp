<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <header>
        <br><br>
        <h1>Update Profile</h1>
    </header>
    
      <%
        // Initialize variables
        String uname = "User";
        int age = 0;
        String email = "";
        double balance = 0.0;
        String userId = null;

        // Retrieve user_id from cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user_id".equals(cookie.getName())) {
                    userId = cookie.getValue();
                    break;
                }
            }
        }

        if (userId != null) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                // Establish database connection
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn = DriverManager.getConnection("jdbc:derby://localhost:1527/project");

                // Query to get the user's current details
                String query = "SELECT name, age, email, balance FROM users WHERE user_id = ?";
                pstmt = conn.prepareStatement(query);
                pstmt.setInt(1, Integer.parseInt(userId));
                rs = pstmt.executeQuery();
                
                // Retrieve user details
                if (rs.next()) {
                    uname = rs.getString("name");
                    age = rs.getInt("age");
                    email = rs.getString("email");
                    balance = rs.getDouble("balance");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
            }
        } else {
            out.println("<p>Error: User not logged in. Please log in to update your profile.</p>");
            return;
        }
    %>

    <nav>
        <a href="UserDashboard.jsp">Dashboard</a>
        <a href="browse_classes">Book</a>
        <a href="search.jsp">Search</a>
        <a href="history.jsp">View History</a>
        <a href="#top">Update Profile</a>
        <a>Balance: <span style="font-weight:700;color:palegreen"><%=balance%></span> AED</a>
        <a>Signed in as (<span style="font-weight:700;color:palegreen"><%=uname%></span>)</a>
        <a class="user" href="index.html">Log Out</a>
    </nav>

    <div>
        <h2>Update Your Profile</h2>
        <form method="post" action="updateProfileHandler.jsp">
            <table>
            <tr>
                <td>
                <input type="hidden" name="user_id" value="<%= userId %>" />
                </td>
            </tr>
            <tr>
                <td>
                    <label for="name">Name:</label>
                </td>
                <td>
                    <input type="text" id="name" name="name" value="<%= uname %>" required>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="age" >Age:</label></td>
                <td>
                    <input type="number" id="age" name="age" value="<%= age %>" step="1" min="18" max ="100" required>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="email" >Email:</label></td>
                <td>
                    <input type="email" id="email" name="email" value="<%= email %>" required>
                </td>
            </tr>
            <tr>
                <td>
                    <label for="password">New Password:</label>
                </td>
                <td>
                    <input type="password" id="password" name="password" placeholder="Enter new password">
                </td>
            </tr>
            <tr>
                <td>
                    <label for="balance" >Add Money to Balance:</label></td>
                <td>
                    <input type="number" id="balance" name="balance" min="0" step="50" placeholder="Enter amount to add">
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <button class="button" type="submit" >Update</button>
                    <button class="button" type="reset" >Clear</button>
                </td>
                
            </tr>
            </table>
        </form>
    </div>
</body>
</html>
