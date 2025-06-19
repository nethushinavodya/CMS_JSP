package org.example.controllers.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.bo.BOFactory;
import org.example.bo.custom.ComplaintBO;

import java.io.IOException;

@WebServlet(name = "deleteComplaintServlet", value = "/AdminDeleteComplaint")
public class deleteComplaintServlet extends HttpServlet {
    ComplaintBO complaintBO = (ComplaintBO) BOFactory.getInstance().getBO(BOFactory.BOType.COMPLAINTS);

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String complaintId = req.getParameter("complaint_id");
        boolean delete = complaintBO.deleteComplaint(Integer.parseInt(complaintId));
        if (delete) {
            resp.sendRedirect("allComplaint");
        }else {
            resp.sendRedirect("allComplaint.jsp");
        }
    }
}
