package org.example.dao.custom;

import org.example.dao.SuperDAO;
import org.example.dto.ComplaintsDTO;
import org.example.entity.Complaints;
import org.hibernate.Session;

import java.util.List;

public interface ComplaintDAO extends SuperDAO {
    void addComplaint(Complaints complaints);

    List<Complaints> getAllComplaints(String username);

    boolean updateComplaint(Session session, Complaints complaint);

    String getComplaintStatus(int complaintId);

    boolean deleteComplaint(int i);


    List<Complaints> getAllEmployeeComplaints();
}
