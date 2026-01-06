<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Class</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: 2rem auto;
            padding: 1.5rem;
            background-color: #f9f9f9;
            border: 1px solid #ccc;
            border-radius: 10px;
        }
        input, button {
            display: block;
            width: 100%;
            margin-bottom: 1rem;
            padding: 0.5rem;
        }
        button {
            background-color: seaGreen;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: darkgreen;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Class Details</h2>
        <%
            String user_id = request.getParameter("user_id");
            Connection connection = null;
            PreparedStatement stmt = null;
            ResultSet resultSet = null;

            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                connection = DriverManager.getConnection("jdbc:derby://localhost:1527/project");
                String query = "SELECT * FROM classes WHERE class_id = ?";
                stmt = connection.prepareStatement(query);
                stmt.setString(1, user_id);
                resultSet = stmt.executeQuery();

                if (resultSet.next()) {
        %>
        <form method="post" action="UpdateClassServlet">
            <label for="id">Class ID (Uneditable):</label>
            <input type="text" id="id" name="id" value="<%= resultSet.getString("id") %>" readonly>

            <label for="name">Class Name:</label>
            <input type="text" id="name" name="name" value="<%= resultSet.getString("name") %>" readonly>

            <label for="price">Price:</label>
            <input type="number" id="price" name="price" step="0.01" value="<%= resultSet.getDouble("price") %>">

            <label for="quantity">Available Quantity:</label>
            <input type="number" id="quantity" name="quantity" value="<%= resultSet.getInt("available_quantity") %>">

            <button type="submit">Update</button>
        </form>
        <% 
                } else {
                    out.println("<p>Class not found.</p>");
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                if (resultSet != null) resultSet.close();
                if (stmt != null) stmt.close();
                if (connection != null) connection.close();
            }
        %>
    </div>
</body>
</html>
