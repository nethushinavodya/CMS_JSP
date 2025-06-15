package org.example.controllers.employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.bo.BOFactory;
import org.example.bo.custom.ComplaintBO;

import java.io.IOException;

@WebServlet(name = "deleteComplaintServlet", value = "/deleteComplaint")
public class deleteComplaintServlet extends HttpServlet {
    ComplaintBO complaintBO = (ComplaintBO) BOFactory.getInstance().getBO(BOFactory.BOType.COMPLAINTS);

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String complaintId = req.getParameter("complaint_id");

        String currentStatus = complaintBO.getComplaintStatus(Integer.parseInt(complaintId));
        if (currentStatus.equals("Resolved")) {
            resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
            resp.getWriter().write("Complaint already resolved");
            return;
        }
        boolean isDeleted = complaintBO.deleteComplaint(Integer.parseInt(complaintId));
        if (isDeleted) {
            resp.getWriter().write("Complaint deleted successfully");
        } else {
            resp.getWriter().write("Delete failed");
        }
    }
}
