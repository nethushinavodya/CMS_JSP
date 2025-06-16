package org.example.controllers.userController;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.bo.BOFactory;
import org.example.bo.custom.EmployeeBO;
import org.example.entity.Employee;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
@MultipartConfig
public class LoginServlet extends HttpServlet {
     EmployeeBO employeeBO = (EmployeeBO) BOFactory.getInstance().getBO(BOFactory.BOType.EMPLOYEE);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        String role = employeeBO.login(username, password);
        if (role.equals("Employee")) {
            ServletContext context = req.getServletContext();
            context.setAttribute("username", username);
            HttpSession session = req.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            resp.sendRedirect( "employeeDashboard.jsp?username=" + username + "&role=" + role);
        } else if (role.equals("Admin")) {
            ServletContext context = req.getServletContext();
            context.setAttribute("username", username);
            HttpSession session = req.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role);
            resp.sendRedirect("adminDashboard.jsp");
        } else {
            resp.sendRedirect( "index.jsp?error=invalid");
        }

    }
}