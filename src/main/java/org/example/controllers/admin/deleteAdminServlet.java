package org.example.controllers.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.bo.BOFactory;
import org.example.bo.custom.EmployeeBO;

import java.io.IOException;

@WebServlet(name = "deleteAdminServlet", value = "/deleteAdmin")
public class deleteAdminServlet extends HttpServlet {
    EmployeeBO employeeBO = (EmployeeBO) BOFactory.getInstance().getBO(BOFactory.BOType.EMPLOYEE);

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        System.out.println("Servlet: Username = " + username);
        boolean isDeleted = employeeBO.deleteAdmin(username);
        if (isDeleted) {
            resp.getWriter().write("Admin deleted successfully");
            resp.sendRedirect("adminManage");
        } else {
            resp.sendRedirect("adminManage");
        }
    }
}
