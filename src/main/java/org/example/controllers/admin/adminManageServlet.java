package org.example.controllers.admin;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.bo.BOFactory;
import org.example.bo.custom.EmployeeBO;
import org.example.dto.EmployeeDTO;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet(name = "adminManageServlet", value = "/adminManage")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // max 5MB
public class adminManageServlet extends HttpServlet {
    EmployeeBO employeeBO = (EmployeeBO) BOFactory.getInstance().getBO(BOFactory.BOType.EMPLOYEE);

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       String fullName = req.getParameter("fullName");
       String address = req.getParameter("address");
       String username = req.getParameter("username");
       String email = req.getParameter("email");
       String password = req.getParameter("password");
       String confirmPassword = req.getParameter("confirmPassword");
       String role = req.getParameter("role");

       Part part = req.getPart("profilePic");
       String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();

       String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
       File uploadDir = new File(uploadPath);
       if (!uploadDir.exists()) {
           uploadDir.mkdir();
       }
       part.write(uploadPath + File.separator + fileName);

        EmployeeDTO employeeDTO = new EmployeeDTO(
                fullName,
                address,
                username,
                email,
                password,
                confirmPassword,
                fileName,
                "Admin"
        );
        boolean isAdded = employeeBO.addAdmin(employeeDTO);
        System.out.println("username = " + username + "role = " + role + "fullName = " + fullName + "address = " + address + "email = " + email + "password = " + password);
        if (isAdded) {
            ServletContext context = req.getServletContext();
            context.setAttribute("username", username);
            HttpSession session = req.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", "Admin");
            resp.sendRedirect("adminManage.jsp");
        } else {
            resp.sendRedirect("adminDashboard.jsp");
        }

    }
}
