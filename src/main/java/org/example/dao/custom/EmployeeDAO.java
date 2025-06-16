package org.example.dao.custom;

import org.example.dao.SuperDAO;
import org.example.entity.Employee;

public interface EmployeeDAO extends SuperDAO {
    boolean register(Employee employee);

    String login(String username, String password);

}
