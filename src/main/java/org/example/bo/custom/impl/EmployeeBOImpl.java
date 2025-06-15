package org.example.bo.custom.impl;

import org.example.bo.custom.EmployeeBO;
import org.example.dao.DAOFactory;
import org.example.dao.custom.EmployeeDAO;
import org.example.dto.EmployeeDTO;
import org.example.entity.Employee;

public class EmployeeBOImpl implements  EmployeeBO {
    EmployeeDAO employeeDAO = (EmployeeDAO) DAOFactory.getInstance().getDAO(DAOFactory.DAOType.EMPLOYEE);

    @Override
    public boolean register(EmployeeDTO employeeDTO) {
        return employeeDAO.register(new Employee(employeeDTO.getEmployee_id(),employeeDTO.getFullName(),employeeDTO.getAddress(),employeeDTO.getUsername(),employeeDTO.getEmail(),employeeDTO.getPassword(),employeeDTO.getConfirmPassword(),employeeDTO.getProfilePic(),employeeDTO.getRole()));
    }

    @Override
    public String login(String username, String password) {
        return employeeDAO.login(username,password);
    }
}
