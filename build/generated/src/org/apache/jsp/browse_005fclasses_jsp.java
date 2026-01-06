package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;

public final class browse_005fclasses_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Browse Classes</title>\n");
      out.write("        <link rel=\"stylesheet\" href=\"main.css\">\n");
      out.write("        <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("        <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js\"></script>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <section>\n");
      out.write("            <div>\n");
      out.write("                <div class=\"class-schedule\">\n");
      out.write("                    <div class=\"row\">\n");
      out.write("                        ");

                            try {
                                Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/project");
                                Statement st = conn.createStatement();
                                String query = "select * from classes";
                                ResultSet rs = st.executeQuery(query);
                                while (rs.next()) {
                        
      out.write("\n");
      out.write("                        <div class=\"col-md-3\">\n");
      out.write("                            <div class=\"card\">\n");
      out.write("                                <img class=\"card-img-top\" src=");
      out.print(rs.getString(5));
      out.write(" >\n");
      out.write("                                <div class=\"card-body\">\n");
      out.write("                                    <h4 class=\"card-title\">");
      out.print(rs.getString(2));
      out.write("</h4>\n");
      out.write("                                    <p class=\"card-text\">Price: ");
      out.print(rs.getString(3));
      out.write(" Dhs</p>\n");
      out.write("                                    <p class=\"card-text\">Spaces left: ");
      out.print(rs.getString(4));
      out.write("</p>\n");
      out.write("                                    <p class=\"card-text\">Class date and time: ");
      out.print(rs.getString(6));
      out.write("</p>\n");
      out.write("                                    <form action=\"purchase.jsp\" method=\"POST\">\n");
      out.write("                                        <input type=\"hidden\" name=\"class\" value=");
      out.print(rs.getString(2));
      out.write(">\n");
      out.write("                                        <button class=\"btn btn-primary\" type=\"submit\">Book Now</button>\n");
      out.write("                                    </form>\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                     ");

                         }
                            conn.close();
                         } catch (SQLException ex) {
                            ex.printStackTrace();
                         }

                     
      out.write("\n");
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
