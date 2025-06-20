package org.example.bo.custom;

import org.example.bo.SuperBO;
import org.example.dto.EmployeeDTO;
import org.example.entity.Employee;

import java.util.List;

public interface EmployeeBO extends SuperBO {
    boolean register(EmployeeDTO employeeDTO);

    String login(String username, String password);

    boolean addAdmin(EmployeeDTO employeeDTO);
    
    List<Employee> getEmployeesByRole(String role);

    boolean deleteAdmin(String username);

    EmployeeDTO getEmployeeByUsername(String username);
}
