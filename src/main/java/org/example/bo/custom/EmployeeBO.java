package org.example.bo.custom;

import org.example.bo.SuperBO;
import org.example.dto.EmployeeDTO;

public interface EmployeeBO extends SuperBO {
    boolean register(EmployeeDTO employeeDTO);

    String login(String username, String password);

    boolean addAdmin(EmployeeDTO employeeDTO);
}
