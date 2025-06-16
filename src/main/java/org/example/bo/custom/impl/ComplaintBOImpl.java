package org.example.bo.custom.impl;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletResponse;
import org.example.bo.custom.ComplaintBO;
import org.example.config.FactoryConfiguration;
import org.example.dao.DAOFactory;
import org.example.dao.custom.ComplaintDAO;
import org.example.dto.ComplaintsDTO;
import org.example.entity.Complaints;
import org.example.entity.Employee;
import org.hibernate.Session;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class ComplaintBOImpl implements ComplaintBO {
    FactoryConfiguration factoryConfiguration = FactoryConfiguration.getInstance();
    ComplaintDAO complaintDAO = (ComplaintDAO) DAOFactory.getInstance().getDAO(DAOFactory.DAOType.COMPLAINT);

    @Override
    public void addComplaint(ComplaintsDTO complaintsDTO) {
        Session session = factoryConfiguration.getSession();
        Employee employee = session.get(Employee.class,complaintsDTO.getUsername());
        complaintDAO.addComplaint(new Complaints(complaintsDTO.getComplaint_id(),complaintsDTO.getTitle(),complaintsDTO.getDescription(),complaintsDTO.getPriority(),complaintsDTO.getStatus(),complaintsDTO.getAdminRemark(),employee));
    }

    @Override
    public List<ComplaintsDTO> getAllComplaints(String username) {
        List<Complaints> complaints = complaintDAO.getAllComplaints(username);
        List<ComplaintsDTO> complaintsDTO = new ArrayList<>();
        for (Complaints c : complaints) {
            complaintsDTO.add(new ComplaintsDTO(c.getComplaint_id(),c.getTitle(),c.getDescription(),c.getStatus(),c.getPriority(),c.getAdminRemark(),c.getEmployee().getUsername()));
        }
        return complaintsDTO;
    }

    @Override
    public boolean updateComplaint(ComplaintsDTO complaintsDTO) {
        Session session = factoryConfiguration.getSession();
        try {
            session.beginTransaction();

            Complaints complaint = session.get(Complaints.class, complaintsDTO.getComplaint_id());
            if (complaint != null) {
                complaint.setTitle(complaintsDTO.getTitle());
                complaint.setDescription(complaintsDTO.getDescription());
                complaint.setPriority(complaintsDTO.getPriority());

                session.update(complaint);
                session.getTransaction().commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            session.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            session.close();
        }
    }

    @Override
    public String getComplaintStatus(int complaintId) {
        return complaintDAO.getComplaintStatus(complaintId);
    }

    @Override
    public boolean deleteComplaint(int i) {
        return complaintDAO.deleteComplaint(i);
    }

    @Override
    public List<ComplaintsDTO> getAllComplaintForAdmin() {
        List<Complaints> complaints = complaintDAO.getAllEmployeeComplaints();
        List<ComplaintsDTO> dtoList = new ArrayList<>();

        for (Complaints c : complaints) {
            ComplaintsDTO dto = new ComplaintsDTO();

            dto.setComplaint_id(c.getComplaint_id());
            dto.setTitle(c.getTitle());
            dto.setDescription(c.getDescription());
            dto.setPriority(c.getPriority());
            dto.setStatus(c.getStatus());
            dto.setAdminRemark(c.getAdminRemark());
            dto.setUsername(c.getEmployee().getUsername().toString());

            dtoList.add(dto);
        }

        return dtoList;
    }

    @Override
    public boolean updateComplaintByAdmin(int i, String status, String adminRemark) {
        return complaintDAO.updateComplaintByAdmin(i,status,adminRemark);
    }

}

