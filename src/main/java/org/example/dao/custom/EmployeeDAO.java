package org.example.dao.custom;

import org.example.dao.SuperDAO;
import org.example.entity.Employee;
;

;import java.util.List;

public interface EmployeeDAO extends SuperDAO {
    boolean register(Employee employee);

    String login(String username, String password);

    List<Employee> getEmployeesByRole(String role);

    boolean deleteAdmin(String username);
}
