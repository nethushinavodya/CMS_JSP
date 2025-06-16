package org.example.controllers.userController;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.bo.BOFactory;
import org.example.bo.custom.EmployeeBO;
import org.example.dto.EmployeeDTO;
import org.example.entity.Employee;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet(name = "RegisterServlet", value = "/register")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // max 5MB
public class RegisterServlet extends HttpServlet {
    EmployeeBO employeeBO = (EmployeeBO) BOFactory.getInstance().getBO(BOFactory.BOType.EMPLOYEE);
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/signup.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fullName = req.getParameter("fullName");
        String address = req.getParameter("address");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        Part part = req.getPart("profilePic");
        System.out.println(part+ "part");
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
                "Employee"
        );

        boolean isRegistered = employeeBO.register(employeeDTO);

        if (isRegistered) {
            ServletContext context = req.getServletContext();
            context.setAttribute("username", username);
            HttpSession session = req.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", "Employee");
            System.out.println(username);
            resp.sendRedirect("employeeDashboard.jsp?username=" + username+"&role=Employee");
        }else {
            resp.sendRedirect("index.jsp") ;
        }
    }
}