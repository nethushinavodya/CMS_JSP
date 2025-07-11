package org.example.controllers.employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.bo.BOFactory;
import org.example.bo.custom.ComplaintBO;
import org.example.dto.ComplaintsDTO;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ViewComplaintServlet", value = "/ViewAndEditComplaint")
public class ViewComplaintServlet extends HttpServlet {
    ComplaintBO complaintBO = (ComplaintBO) BOFactory.getInstance().getBO(BOFactory.BOType.COMPLAINTS);
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String username = session.getAttribute("username").toString();
        System.out.println("Servlet: Username = " + username);


        if (username != null && !username.isEmpty()) {
            List<ComplaintsDTO> complaints = complaintBO.getAllComplaints(username);
            req.setAttribute("complaints", complaints);
            req.getRequestDispatcher("myComplaint.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("employeeDashboard.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String complaintId = (req.getParameter("complaint_id"));

        //check the status resolved or not
        String currentStatus = complaintBO.getComplaintStatus(Integer.parseInt((complaintId)));
        if (currentStatus.equals("Resolved")) {
            resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
            resp.getWriter().write("Complaint already resolved");
            return;
        }

        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String priority = req.getParameter("priority");
        String username = req.getParameter("username");

        ComplaintsDTO complaintsDTO = new ComplaintsDTO(Integer.parseInt(complaintId), title, description, null,priority, null, username);

        boolean isUpdated = complaintBO.updateComplaint(complaintsDTO);
        if (isUpdated) {
            resp.getWriter().write("Complaint updated successfully");
            resp.sendRedirect("ViewAndEditComplaint");
        } else {
            resp.getWriter().write("Update failed");
        }
    }
}
