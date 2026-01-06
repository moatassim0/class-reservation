package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class purchase_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html;charset=UTF-8");
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
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

String c = request.getParameter("name");
String price = request.getParameter("price");
String quantity = request.getParameter("quantity");
String image = request.getParameter("image");
HttpSession s = request.getSession(false);
String username;
//String username = s.getAttribute("username").toString();
String balance; 

try {
        username = s.getAttribute("username").toString();
    } catch(NullPointerException ex) {
        ex.getMessage();
    }

try {
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/project");
        String query = "select balance from users where name = ?";
        PreparedStatement st = conn.prepareStatement(query);
        st.setString(1, username);
        ResultSet rs = st.executeQuery();
        balance = rs.getString(6);
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    


      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Browse Classes</title>\n");
      out.write("        <link rel=\"stylesheet\" href=\"main.css\">\n");
      out.write("        <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("        <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js\"></script>\n");
      out.write("    </head>\n");
      out.write("    <header>\n");
      out.write("        <div class=\"top bar\" style=\"padding: 50px\">\n");
      out.write("        <h1>Fitness Class Booking System</h1>\n");
      out.write("        </div>\n");
      out.write("    </header>\n");
      out.write("    <nav>\n");
      out.write("        <a href=\"index.html\">Home</a>\n");
      out.write("        <a href=\"guide.html\">Guides</a>\n");
      out.write("        <a href=\"add_class.html\">BMI Calculator</a>\n");
      out.write("        <a href=\"calc.html\">Calorie Calculator</a>\n");
      out.write("        <a href=\"track.html\">Calorie Tracker</a>\n");
      out.write("        <a href=\"#top\">FAQs</a>\n");
      out.write("        <a class=\"user\" href=\"login.jsp\">Login</a>\n");
      out.write("        <a class=\"user\" href=\"signup.jsp\">Sign Up</a>\n");
      out.write("        <a class=\"user\" href='add_class.jsp'>Add Class</a>\n");
      out.write("        <a class=\"user\" href=\"editClass.jsp\">Edit Class</a>\n");
      out.write("    </nav>\n");
      out.write("    <body>\n");
      out.write("        <section>\n");
      out.write("            <div class=\"fbox\">\n");
      out.write("                <div class=\"class-schedule\">\n");
      out.write("                    <h2 style=\"text-align: center\">Booking: ");
      out.print(c);
      out.write(" class</h2>\n");
      out.write("                    <img class=\"img-rounded img-responsive\" src=");
      out.print(image);
      out.write(">\n");
      out.write("                    <form class=\"form-horizontal\" action=\"purchaseServlet\">\n");
      out.write("                        \n");
      out.write("                        <div class=\"form-group\">\n");
      out.write("                            <label class=\"control-label h6\" for=\"Quantity\">Quantity</label>\n");
      out.write("                            <div class=\"col-md-3\">\n");
      out.write("                                <input type=\"number\" name=\"quantity\" class=\"form-control\" id=\"quantity\" min=\"1\" max=");
      out.print(quantity);
      out.write(">\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                        <h5 class=\"h5\">Price: ");
      out.print(price);
      out.write("</h5>\n");
      out.write("                        <h5 class=\"h5\">Balance: </h5>\n");
      out.write("                    </form>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </section>\n");
      out.write("    </body>\n");
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
