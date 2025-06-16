package org.example.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class EmployeeDTO {
    private String fullName;
    private String address;
    private String username;
    private String email;
    private String password;
    private String confirmPassword;
    private String profilePic;
    private String role;
}
