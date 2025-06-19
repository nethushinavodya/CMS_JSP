package org.example.dao.custom.impl;

import org.example.config.FactoryConfiguration;
import org.example.dao.custom.ComplaintDAO;
import org.example.dto.ComplaintsDTO;
import org.example.entity.Complaints;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

public class ComplaintDAOImpl implements ComplaintDAO {
    FactoryConfiguration factoryConfiguration = FactoryConfiguration.getInstance();
    @Override
    public void addComplaint(Complaints complaints) {
        Session session = factoryConfiguration.getSession();
        session.beginTransaction();
        session.save(complaints);
        session.getTransaction().commit();

    }


    @Override
    public List<Complaints> getAllComplaints(String username) {
        Session session = factoryConfiguration.getSession();
        session.beginTransaction();
        System.out.println("DAO: Username = " + username);
        List<Complaints> complaints = session.createQuery("FROM Complaints WHERE employee.username = :username", Complaints.class)
                .setParameter("username", username)
                .list();
        System.out.println("DAO: Complaints = " + complaints);
        session.getTransaction().commit();
        session.close();
        return complaints;
    }

    @Override
    public boolean updateComplaint(Session session, Complaints complaint) {
        session.beginTransaction();
        session.update(complaint);
        session.getTransaction().commit();
        return true;
    }

    @Override
    public String getComplaintStatus(int complaintId) {
        Session session = factoryConfiguration.getSession();
        try {
            String status = session.createQuery(
                            "SELECT c.status FROM Complaints c WHERE c.complaint_id = :id", String.class)
                    .setParameter("id", complaintId)
                    .uniqueResult();
            System.out.println("DAO: Status = " + status);
            return status;
        } finally {
            session.close();
        }
    }

    @Override
    public boolean deleteComplaint(int i) {
        Session session = factoryConfiguration.getSession();
        session.beginTransaction();
        session.delete(session.get(Complaints.class, i));
        session.getTransaction().commit();
        return true;
    }

    @Override
    public List<Complaints> getAllEmployeeComplaints() {
        Session session = FactoryConfiguration.getInstance().getSession();
        try {
            session.beginTransaction();
            Query<Complaints> query = session.createQuery(
                    "FROM Complaints WHERE employee.username IS NOT NULL", Complaints.class);
            List<Complaints> list = query.list();
            session.getTransaction().commit();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
            return null;
        } finally {
            session.close();
        }
    }

    @Override
    public boolean updateComplaintByAdmin(int i, String status, String adminRemark) {
        Session session = factoryConfiguration.getSession();
        session.beginTransaction();
        Complaints complaint = session.get(Complaints.class, i);
        complaint.setStatus(status);
        complaint.setAdminRemark(adminRemark);
        session.update(complaint);
        session.getTransaction().commit();
        return true;
    }

    @Override
    public boolean deleteEmployeeComplaint(int i) {
        Session session = factoryConfiguration.getSession();
        session.beginTransaction();
        session.delete(session.get(Complaints.class, i));
        session.getTransaction().commit();
        return true;
    }

}
