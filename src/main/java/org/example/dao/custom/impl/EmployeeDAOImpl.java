package org.example.dao.custom.impl;

import jakarta.servlet.ServletContext;
import org.example.config.FactoryConfiguration;
import org.example.dao.custom.EmployeeDAO;
import org.example.entity.Employee;
import org.hibernate.Session;

import java.util.List;


public class EmployeeDAOImpl implements EmployeeDAO {
    FactoryConfiguration factoryConfiguration = FactoryConfiguration.getInstance();


    @Override
    public boolean register(Employee employee) {
        Session session = factoryConfiguration.getSession();
        session.beginTransaction();
        session.save(employee);
        session.getTransaction().commit();
        return true;
    }

    @Override
    public String login(String username, String password) {
        Session session = factoryConfiguration.getSession();
        session.beginTransaction();
        String sql = "FROM Employee WHERE username = :username AND password = :password";
        Employee employee = session.createQuery(sql, Employee.class).setParameter("username", username).setParameter("password", password).uniqueResult();
        session.getTransaction().commit();
        if (employee != null) {
            return employee.getRole();
        } else {
            return null;
        }
    }
}
