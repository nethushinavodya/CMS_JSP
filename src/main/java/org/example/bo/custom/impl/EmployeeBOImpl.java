package org.example.bo.custom.impl;

import org.example.bo.custom.EmployeeBO;
import org.example.dao.DAOFactory;
import org.example.dao.custom.EmployeeDAO;
import org.example.dto.EmployeeDTO;
import org.example.entity.Employee;

import java.util.List;

public class EmployeeBOImpl implements  EmployeeBO {
    EmployeeDAO employeeDAO = (EmployeeDAO) DAOFactory.getInstance().getDAO(DAOFactory.DAOType.EMPLOYEE);

    @Override
    public boolean register(EmployeeDTO employeeDTO) {
        return employeeDAO.register(new Employee(employeeDTO.getFullName(),employeeDTO.getAddress(),employeeDTO.getUsername(),employeeDTO.getEmail(),employeeDTO.getPassword(),employeeDTO.getConfirmPassword(),employeeDTO.getProfilePic(),employeeDTO.getRole()));
    }

    @Override
    public String login(String username, String password) {
        return employeeDAO.login(username,password);
    }

    @Override
    public boolean addAdmin(EmployeeDTO employeeDTO) {
        Employee employee = new Employee(employeeDTO.getFullName(), employeeDTO.getAddress(), employeeDTO.getUsername(), employeeDTO.getEmail(), employeeDTO.getPassword(), employeeDTO.getConfirmPassword(), employeeDTO.getProfilePic(), employeeDTO.getRole());
        return employeeDAO.register(employee);
    }
    
    @Override
    public List<Employee> getEmployeesByRole(String role) {
        return employeeDAO.getEmployeesByRole(role);
    }

    @Override
    public boolean deleteAdmin(String username) {
       return employeeDAO.deleteAdmin(username);

    }

    @Override
    public EmployeeDTO getEmployeeByUsername(String username) {
        Employee employee = employeeDAO.getEmployeeByUsername(username);
        if (employee != null) {
            return new EmployeeDTO(employee.getFullName(), employee.getAddress(), employee.getUsername(), employee.getEmail(), employee.getPassword(), employee.getConfirmPassword(), employee.getProfilePic(), employee.getRole());
        } else {
            return null;
        }
    }
}
