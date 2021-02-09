package Controller;

import com.sun.org.slf4j.internal.Logger;
import com.sun.org.slf4j.internal.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AbstractController extends HttpServlet {
    private static final long serialVersionUID = -3374292002495962407L;
    Logger logger = LoggerFactory.getLogger(getClass());

    public final void forwardToPage(String jspPage, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("currentPage", "page/" +jspPage);
        req.getRequestDispatcher("WEB-INF/jsp/page-template.jsp").forward(req,resp);
    }

    public final void forwardToFragment(String jspPage, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("WEB-INF/jsp/fragment" + jspPage).forward(req, resp);
    }
}
