import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class updateclassservlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String price = request.getParameter("price");
        String quantity = request.getParameter("quantity");

        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection = DriverManager.getConnection("jdbc:derby://localhost:1527/project");

            String updateQuery = "UPDATE classes SET price = ?, available_quantity = ? WHERE user_id = ?";
            stmt = connection.prepareStatement(updateQuery);
            stmt.setBigDecimal(1, new java.math.BigDecimal(price));
            stmt.setInt(2, Integer.parseInt(quantity));
            stmt.setString(3, id);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("adminDashboard.jsp?status=success");
            } else {
                response.sendRedirect("adminDashboard.jsp?status=failure");
            }

        } catch (Exception e) {
            response.sendRedirect("adminDashboard.jsp?status=error&message=" + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (connection != null) connection.close();
            } catch (Exception ex) {
                // Ignore
            }
        }
    }
}
