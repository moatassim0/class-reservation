import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

//@WebServlet("/browse-classes")
public class browse_classes extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
                // User Authentication
        String userID = null;
        String username = null;
        String balance = null;
        
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("user_id".equals(cookie.getName())) {
                    userID = cookie.getValue();
                    break;
                }
            }
        }
        
        // Database connection to fetch user details
        if (userID != null) {
            try {
                Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/project");
                String query = "select * from users where user_id = ?";
                PreparedStatement st = conn.prepareStatement(query);
                st.setString(1, userID);
                ResultSet rs = st.executeQuery();
                
                if (rs.next()) {
                    balance = rs.getString("balance");
                    username = rs.getString("name");
                }
                conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">");
            out.println("<title>Browse Classes</title>");
            out.println("<link rel=\"stylesheet\" href=\"main.css\">");
            out.println("<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\">");
            out.println("<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js\"></script>");
            out.println("</head>");
            
           
            
            // Navigation bar
            out.println("<nav>");
            out.println("<a href=\"UserDashboard.jsp\">Dashboard</a>");
            out.println("<a href=\"browse_classes\">Book</a>");
            out.println("<a href=\"search.jsp\">Search</a>");
            out.println("<a href=\"history.jsp\">View History</a>");
            out.println("<a href=\"updateProfile.jsp\">Update Profile</a>");
            
            // Conditional display of balance and username
            if (username != null && balance != null) {
                out.println("<a>Balance: <span style=\"font-weight:700;color:palegreen\">" + balance + "</span> AED</a>");
                out.println("<a>Signed in as (<span style=\"font-weight:700;color:palegreen\">" + username + "</span>)</a>");
            } else {
                out.println("<a class=\"user\" href=\"login.jsp\">Login</a>");
                out.println("<a class=\"user\" href=\"signup.jsp\">Sign Up</a>");
            }
            
            out.println("<a class=\"user\" href=\"index.html\">Log Out</a>");
            out.println("</nav>");
            
             // Header
            out.println("<header>");
            out.println("<div class=\"top bar\" style=\"padding: 50px\">");
            out.println("<h1>Fitness Class Booking System</h1>");
            out.println("</div>");
            out.println("</header>");
            
            out.println("<body>");
            out.println("<section>");
            out.println("<div class=\"fbox\">");
            out.println("<div class=\"class-schedule\">");
            out.println("<div class=\"row\">");
            
            // Database connection and data retrieval
            try {
                Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/project");
                Statement st = conn.createStatement();
                String query = "select * from classes";
                ResultSet rs = st.executeQuery(query);
                
                while (rs.next()) {
                    out.println("<div class=\"col-md-3\">");
                    out.println("<div class=\"card\">");
                    out.println("<img class=\"card-img-top\" src=\"" + rs.getString(5) + "\">");
                    out.println("<div class=\"card-body\">");
                    out.println("<h4 class=\"card-title\">" + rs.getString(2) + "</h4>");
                    out.println("<p class=\"card-text\">Price: " + rs.getString(3) + " Dhs</p>");
                    out.println("<p class=\"card-text\">Spaces left: " + rs.getString(4) + "</p>");
                    out.println("<p class=\"card-text\">Date & Time: " + rs.getString(6) + "</p>");
                    out.println("<form action=\"purchase.jsp\" method=\"POST\">");
                    out.println("<input type=\"hidden\" name=\"class\" value=\"" + rs.getString(2) + " \">");
                    out.println("<input type=\"hidden\" name=\"price\" value=\"" + rs.getString(3) + " \">");
                    out.println("<input type=\"hidden\" name=\"quantity\" value=\"" + rs.getString(4) + " \">");
                    out.println("<input type=\"hidden\" name=\"image\" value=\"" + rs.getString(5) + " \">");
                    out.println("<input type=\"hidden\" name=\"time\" value=\"" + rs.getString(6) + " \">");
                    out.println("<button class=\"btn btn-primary\" type=\"submit\">Book Now</button>");
                    out.println("</form>");
                    out.println("</div>");
                    out.println("</div>");
                    out.println("</div>");
                }
                
                conn.close();
            } catch (SQLException ex) {
                out.println("<div class=\"alert alert-danger\">Error: Unable to retrieve class information.</div>");
                ex.printStackTrace();
            }
            
            out.println("</div>");
            out.println("</div>");
            out.println("</div>");
            out.println("</section>");
            out.println("</body>");
            out.println("</html>");
            
        } finally {
            out.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}