package org.example.dao.custom.impl;

import org.example.config.FactoryConfiguration;
import org.example.dao.custom.EmployeeDAO;
import org.example.dto.EmployeeDTO;
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

    @Override
    public List<Employee> getEmployeesByRole(String role) {
        Session session = factoryConfiguration.getSession();
        session.beginTransaction();
        String sql = "FROM Employee WHERE role = :role";
        List<Employee> employees = session.createQuery(sql, Employee.class)
                .setParameter("role", role)
                .getResultList();
        session.getTransaction().commit();
        return employees;
    }

    @Override
    public boolean deleteAdmin(String username) {
        Session session = factoryConfiguration.getSession();
        session.beginTransaction();
        String sql = "DELETE FROM Employee WHERE username = :username";
        session.createQuery(sql).setParameter("username", username).executeUpdate();
        session.getTransaction().commit();
        return false;
    }

    @Override
    public Employee getEmployeeByUsername(String username) {
        Session session = factoryConfiguration.getSession();
        session.beginTransaction();
        String sql = "FROM Employee WHERE username = :username";
        Employee employee = session.createQuery(sql, Employee.class).setParameter("username", username).uniqueResult();
        session.getTransaction().commit();
        return employee;
    }

}
