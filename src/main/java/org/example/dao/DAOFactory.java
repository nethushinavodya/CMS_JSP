package org.example.dao;


import org.example.dao.custom.impl.ComplaintDAOImpl;
import org.example.dao.custom.impl.EmployeeDAOImpl;

public class DAOFactory {
    private static DAOFactory daoFactory;
    private DAOFactory() {
    }
    public static DAOFactory getInstance() {
        return daoFactory==null?daoFactory=new DAOFactory():daoFactory;
    }
    public enum DAOType {
        EMPLOYEE,COMPLAINT
    }
    public SuperDAO getDAO(DAOType type) {
        switch(type) {
            case EMPLOYEE:
                return new EmployeeDAOImpl();
            case COMPLAINT:
                return new ComplaintDAOImpl();
            default:
                return null;
        }
    }
}
