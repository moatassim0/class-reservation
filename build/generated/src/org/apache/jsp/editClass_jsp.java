package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class editClass_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <title>Edit Class</title>\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            font-family: Arial, sans-serif;\n");
      out.write("            margin: 0;\n");
      out.write("            padding: 0;\n");
      out.write("        }\n");
      out.write("        .container {\n");
      out.write("            width: 50%;\n");
      out.write("            margin: 2rem auto;\n");
      out.write("            padding: 1.5rem;\n");
      out.write("            background-color: #f9f9f9;\n");
      out.write("            border: 1px solid #ccc;\n");
      out.write("            border-radius: 10px;\n");
      out.write("        }\n");
      out.write("        input, button {\n");
      out.write("            display: block;\n");
      out.write("            width: 100%;\n");
      out.write("            margin-bottom: 1rem;\n");
      out.write("            padding: 0.5rem;\n");
      out.write("        }\n");
      out.write("        button {\n");
      out.write("            background-color: seaGreen;\n");
      out.write("            color: white;\n");
      out.write("            border: none;\n");
      out.write("            cursor: pointer;\n");
      out.write("        }\n");
      out.write("        button:hover {\n");
      out.write("            background-color: darkgreen;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    <div class=\"container\">\n");
      out.write("        <h2>Edit Class Details</h2>\n");
      out.write("        ");

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
        
      out.write("\n");
      out.write("        <form method=\"post\" action=\"UpdateClassServlet\">\n");
      out.write("            <label for=\"id\">Class ID (Uneditable):</label>\n");
      out.write("            <input type=\"text\" id=\"id\" name=\"id\" value=\"");
      out.print( resultSet.getString("id") );
      out.write("\" readonly>\n");
      out.write("\n");
      out.write("            <label for=\"name\">Class Name:</label>\n");
      out.write("            <input type=\"text\" id=\"name\" name=\"name\" value=\"");
      out.print( resultSet.getString("name") );
      out.write("\" readonly>\n");
      out.write("\n");
      out.write("            <label for=\"price\">Price:</label>\n");
      out.write("            <input type=\"number\" id=\"price\" name=\"price\" step=\"0.01\" value=\"");
      out.print( resultSet.getDouble("price") );
      out.write("\">\n");
      out.write("\n");
      out.write("            <label for=\"quantity\">Available Quantity:</label>\n");
      out.write("            <input type=\"number\" id=\"quantity\" name=\"quantity\" value=\"");
      out.print( resultSet.getInt("available_quantity") );
      out.write("\">\n");
      out.write("\n");
      out.write("            <button type=\"submit\">Update</button>\n");
      out.write("        </form>\n");
      out.write("        ");
 
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
        
      out.write("\n");
      out.write("    </div>\n");
      out.write("</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
