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
}
