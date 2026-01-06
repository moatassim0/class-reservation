/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author G_ROOM
 */
public class purchaseServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");

    int quantity;
    try {
        quantity = Integer.parseInt(request.getParameter("quantity"));
    } catch (NumberFormatException e) {
        // Handle invalid quantity
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid quantity provided.");
        return;
    }

    String c = request.getParameter("class");
    Cookie cookies[] = request.getCookies();
    int userID = -1;

    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("user_id".equals(cookie.getName())) {
                try {
                    userID = Integer.parseInt(cookie.getValue());
                } catch (NumberFormatException e) {
                    // If the user_id is not numeric, return an error
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid user ID in cookie.");
                    return;
                }
                break;
            }
        }
    }

    if (userID == -1) {
        // If user_id cookie is missing
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "User ID cookie is missing.");
        return;
    }

    int price = 0;
    int balance = 0;
    int classID = 0;

    try (Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/project")) {
        String query1 = "SELECT * FROM classes WHERE name = ?";
        String query2 = "SELECT * FROM users WHERE user_id = ?";

        PreparedStatement st1 = conn.prepareStatement(query1);
        PreparedStatement st2 = conn.prepareStatement(query2);

        st1.setString(1, c);
        st2.setInt(1, userID);

        ResultSet rs1 = st1.executeQuery();
        ResultSet rs2 = st2.executeQuery();

        if (rs1.next() && rs2.next()) {
            price = rs1.getInt("price");
            classID = rs1.getInt("class_id");
            balance = rs2.getInt("balance");

            int cost = price * quantity;
            int newbalance = balance - cost;

            // Ensure balance is sufficient
            if (newbalance < 0) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Insufficient balance.");
                return;
            }

            // Update balance
            String updateBalance = "UPDATE users SET balance = ? WHERE user_id = ?";
            PreparedStatement st3 = conn.prepareStatement(updateBalance);
            st3.setInt(1, newbalance);
            st3.setInt(2, userID);
            st3.executeUpdate();

            // Insert purchase record
            String insertPurchase = "INSERT INTO purchases (customer_id, quantity, total_cost, class_id) VALUES (?, ?, ?, ?)";
            PreparedStatement st4 = conn.prepareStatement(insertPurchase);
            st4.setInt(1, userID);
            st4.setInt(2, quantity);
            st4.setDouble(3, cost);
            st4.setInt(4, classID);
            st4.executeUpdate();

            // Commit changes and redirect
            conn.commit();
            response.sendRedirect("purchaseSuccess.jsp");
        } else {
            conn.rollback();
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Class or User not found.");
        }
    } catch (SQLException ex) {
        // Log error and send internal server error response
        ex.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + ex.getMessage());
    }
}


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
