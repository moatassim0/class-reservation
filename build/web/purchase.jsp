<%-- 
    Document   : browse_classes
    Created on : Nov 24, 2024, 6:27:17 PM
    Author     : G_ROOM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
String c = request.getParameter("class");
String price = request.getParameter("price");
String quantity = request.getParameter("quantity");
String image = request.getParameter("image");
String time = request.getParameter("time");
Cookie cookies[] = request.getCookies();

String userID = null;
if (cookies != null) {
    for (Cookie cookie : cookies) {
        if ("user_id".equals(cookie.getName())) {
            userID = cookie.getValue();
            break;
        }
    }
}
String balance = null; 
String username = null;

try {
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/project");
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
        <title>Browse Classes</title>
        <link rel="stylesheet" href="main.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            .warning-text {
                color: red;
                display: none;
                margin-top: 10px;
                margin-bottom: 10px;
            }
            .balance-warning {
                color: red;
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
                <div class="class-schedule">
                    <form class="form-horizontal col-md-6 offset-md-3" action="purchaseServlet">
                        <h2 style="text-align: center" class="display-6 mb-4">Booking: <%=c%> class</h2>
                        <h2 style="text-align: center" class="display-8 mb-4">Scheduled time: <%=time%></h2>
                        <div class="form-group">
                            <label class="control-label h6 for="Quantity">How many seats booked ?</label>
                            <div class="col-md-3">
                                <input type="number" name="quantity" class="form-control" id="quantity" value="1" min="1" max=<%=quantity%> >
                                <input type="hidden" name="class" value=<%=c%>>
                            </div>
                        </div>
                        <br>
                        <h5 class="h5">Price: <span id="totalPrice"><%=price%></span> Dhs</h5>
                        <h5 class="h5 mb-3">Balance: <span id="userBalance"><%=balance%> Dhs</span></h5>
                        <div id="warningText" class="warning-text alert alert-danger">
                            Warning: Total price exceeds your available balance!
                        </div>
                        <div class="form-group">
                            <div>
                                <button type="submit" class="btn btn-primary" id="submitButton">Submit</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </section>

        <script>
            // Get initial values
            const basePrice = parseFloat('<%=price%>');
            const userBalance = parseFloat('<%=balance%>');
            const quantityInput = document.getElementById('quantity');
            const totalPriceSpan = document.getElementById('totalPrice');
            const userBalanceSpan = document.getElementById('userBalance');
            const warningText = document.getElementById('warningText');
            const submitButton = document.getElementById('submitButton');

            // Function to update price and check balance
            function updatePrice() {
                const quantity = parseInt(quantityInput.value) || 0;
                const totalPrice = basePrice * quantity;
                
                // Update total price display
                totalPriceSpan.textContent = totalPrice.toFixed(2);
                
                // Check if total price exceeds balance
                if (totalPrice > userBalance) {
                    userBalanceSpan.parentElement.classList.add('balance-warning');
                    warningText.style.display = 'block';
                    submitButton.disabled = true;
                } else {
                    userBalanceSpan.parentElement.classList.remove('balance-warning');
                    warningText.style.display = 'none';
                    submitButton.disabled = false;
                }
            }

            // Add event listener to quantity input
            quantityInput.addEventListener('input', updatePrice);

            // Initial calculation
            updatePrice();
        </script>
    </body>
</html>