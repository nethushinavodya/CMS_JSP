package org.example.controllers.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.bo.BOFactory;
import org.example.bo.custom.ComplaintBO;
import org.example.dto.ComplaintsDTO;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "allComplaintServlet", value = "/allComplaint")
public class allComplaintServlet extends HttpServlet {
    ComplaintBO complaintBO = (ComplaintBO) BOFactory.getInstance().getBO(BOFactory.BOType.COMPLAINTS);

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ComplaintsDTO> complaints = complaintBO.getAllComplaintForAdmin();
        System.out.println("Servlet: Complaints = " + complaints);

        req.setAttribute("complaints", complaints);
        req.getRequestDispatcher("allComplaint.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String complaintId = req.getParameter("complaint_id");
        String status = req.getParameter("status");
        String adminRemark = req.getParameter("adminRemark");

        boolean isUpdated = complaintBO.updateComplaintByAdmin(Integer.parseInt(complaintId), status, adminRemark);
        if (isUpdated) {
            resp.getWriter().write("Complaint updated successfully");
            resp.sendRedirect("allComplaint");
        } else {
            resp.getWriter().write("Update failed");
        }
    }
}
