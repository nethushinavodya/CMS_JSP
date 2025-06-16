package org.example.bo.custom;

import jakarta.servlet.http.HttpServletResponse;
import org.example.bo.SuperBO;
import org.example.dto.ComplaintsDTO;

import java.util.List;

public interface ComplaintBO extends SuperBO {
    void addComplaint(ComplaintsDTO complaintsDTO);


    List<ComplaintsDTO> getAllComplaints(String username);

    boolean updateComplaint(ComplaintsDTO complaintsDTO);

    String getComplaintStatus(int complaintId);

    boolean deleteComplaint(int i);

    List<ComplaintsDTO> getAllComplaintForAdmin();

    boolean updateComplaintByAdmin(int i, String status, String adminRemark);
}
