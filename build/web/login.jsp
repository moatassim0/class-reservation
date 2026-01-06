<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
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
                    background-image:linear-gradient(180deg, palegreen, seagreen, seagreen);;
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





    </style>
    
</head>
<body>
    <header>
        <br>	
        <h1>Login to Your Account</h1>
    </header>

<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) 
    {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement p = null;
        ResultSet rs = null;

        try {
            // Establish database connection
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/project");

            // Verify user credentials
            String query = "SELECT user_id, role FROM users WHERE name = ? AND password = ?";
            p = conn.prepareStatement(query);
            p.setString(1, username);
            p.setString(2, password);
            rs = p.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");
                String role = rs.getString("role");

                // Create cookies for user_id and role
                Cookie userIdCookie = new Cookie("user_id", String.valueOf(userId));
                Cookie roleCookie = new Cookie("role", role);

                // Set cookie lifespan
                userIdCookie.setMaxAge(60 * 60 * 24); // 1 day
                roleCookie.setMaxAge(60 * 60 * 24);   // 1 day

                // Add cookies to the response
                response.addCookie(userIdCookie);
                response.addCookie(roleCookie);

                // Redirect based on role
                if ("admin".equalsIgnoreCase(role)) {
                    response.sendRedirect("AdminDashboard.jsp");
                } else {
                    response.sendRedirect("UserDashboard.jsp");
                }
            } else {
                out.println("<p>Invalid username or password!</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            // Clean up resources
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (p != null) try { p.close(); } catch (SQLException ignored) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
        }
    }
%>


    <nav>
        <a href="index.html">Home</a>
        <a href="guide.html">Guides</a>
        <a href="bmi.html">BMI Calculator</a>
        <a href="calc.html">Calorie Calculator</a>
        <a href="track.html">Calorie Tracker</a>
        <a href="faqs.html">FAQs</a>

        <a id="user" href='signup.jsp'>Sign Up</a>
    </nav>

    <section>
        <div>
            <h2>Login</h2>
            
            <form method="post" action="login.jsp">

                <label for="username">Username:</label><br>
                <input type="text" id="username" name="username" required><br><br>

                <label for="password">Password:</label><br>
                <input type="password" id="password" name="password" required><br><br>

                <button class="button" type="submit">Submit</button>
            </form>
        </div>
    </section>
</body>
</html>
