import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class SignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String username = request.getParameter("username");
        int age = Integer.parseInt(request.getParameter("age"));
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Validate input (example: basic check for empty values)
        if (username == null || username.trim().isEmpty() || email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.sendRedirect("signup.html?error=Please fill in all fields");
            return;
        }

        // JDBC setup to insert data into the database
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        String jdbcURL = "jdbc:mysql://localhost:1527/project"; // Update with your DB URL
        String jdbcUsername = "your_db_username"; // Update with your DB username
        String jdbcPassword = "your_db_password"; // Update with your DB password

        try {
            // Initialize database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            // SQL query to insert data into the users table
            String sql = "INSERT INTO users (username, age, email, password) VALUES (?, ?, ?, ?)";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            preparedStatement.setInt(2, age);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, password);

            // Execute update and check if insertion is successful
            int result = preparedStatement.executeUpdate();
            
            if (result > 0) {
                // Redirect to a success page or login page
                response.sendRedirect("login.jsp?message=Registration successful, please login");
            } else {
                // Redirect back to signup page with error
                response.sendRedirect("signup.html?error=Registration failed, try again");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("signup.html?error=Database error");
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
