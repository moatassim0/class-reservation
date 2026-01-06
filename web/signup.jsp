<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
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




    </style>
    
</head>
<body>
    <header>
        <br>	
        <h1>Create Your Account</h1>
    </header>

    
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String username = request.getParameter("username");
            int age = Integer.parseInt(request.getParameter("age"));
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = "user"; // Default role
            double balance = 0.00; // Default balance

            Connection conn = null;
            PreparedStatement p = null;
            ResultSet rs = null;

            try {
                // Establish database connection
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                conn = DriverManager.getConnection("jdbc:derby://localhost:1527/project");

                // Insert user into database
                String insertQuery = "INSERT INTO users (name, age, email, password, role, balance) VALUES (?, ?, ?, ?, ?, ?)";
                p = conn.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS);
                p.setString(1, username);
                p.setInt(2, age);
                p.setString(3, email);
                p.setString(4, password);
                p.setString(5, role);
                p.setDouble(6, balance);
                p.executeUpdate();

                // Get the generated user_id
                rs = p.getGeneratedKeys();
                int userId = 0;
                if (rs.next()) {
                    userId = rs.getInt(1);
                }

                // Create cookies for user_id and role
                Cookie userIdCookie = new Cookie("user_id", String.valueOf(userId));
                Cookie roleCookie = new Cookie("role", role);

                // Set cookie lifespan
                userIdCookie.setMaxAge(60 * 60 * 24); // 1 day
                roleCookie.setMaxAge(60 * 60 * 24);   // 1 day

                // Add cookies to the response
                response.addCookie(userIdCookie);
                response.addCookie(roleCookie);

                // Redirect to User Dashboard
                response.sendRedirect("UserDashboard.jsp");
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

        <a id="user" href='login.jsp'">Login</a>
    </nav>

    <section>
        <div>
            <h2>Sign Up</h2>
            <form method="post" action="signup.jsp">
                <table>	
                    <tr>
                        <td><label for="username">Username:</label></td>
                        <td><input type="text" id="username" name="username" required></td>
                    </tr>

                    <tr>
                        <td><label for="age">Age:</label></td>
                        <td><input type="number" id="age" name="age" min="18" step="1" required></td>
                    </tr>

                    <tr>
                        <td><label for="email">Email:</label></td>
                        <td><input type="email" id="email" name="email" required></td>
                    </tr>

                    <tr>
                        <td><label for="password">Password:</label></td>
                        <td><input type="password" id="password" name="password" required></td>
                    </tr>

                    <tr>
                        <td></td>
                        <td>
                            <button class="button" type="submit">Submit</button>
                            <button class="button" type="reset">Reset</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </section>
</body>
</html>
