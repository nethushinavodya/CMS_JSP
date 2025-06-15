package org.example.controllers.employee;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.bo.BOFactory;
import org.example.bo.custom.ComplaintBO;
import org.example.bo.custom.EmployeeBO;
import org.example.dto.ComplaintsDTO;
import org.example.dto.EmployeeDTO;

import java.io.IOException;

@WebServlet(name = "submitComplaintServlet", value = "/submitComplaint")
public class SubmitComplaintServlet extends HttpServlet {
    EmployeeBO employeeBO = (EmployeeBO) BOFactory.getInstance().getBO(BOFactory.BOType.EMPLOYEE);
    ComplaintBO complaintBO = (ComplaintBO) BOFactory.getInstance().getBO(BOFactory.BOType.COMPLAINTS);
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String priority = req.getParameter("priority");
        String status = "Pending";

        ServletContext context = req.getServletContext();
        String username = (String) context.getAttribute("username");

        ComplaintsDTO complaintsDTO = new ComplaintsDTO(0,title,description,priority,status,null,username);
        complaintBO.addComplaint(complaintsDTO);

        resp.sendRedirect("employeeDashboard.jsp");
    }

}
