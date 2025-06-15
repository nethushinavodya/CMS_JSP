package org.example.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.List;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

public class Employee {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int employee_id;
    private String fullName;
    private String address;
    @Id
    private String username;
    private String email;
    private String password;
    private String confirmPassword;
    private String profilePic;
    private String role;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "employee")
    private List<Complaints> complaints;

    public Employee(int id, String fullName, String address, String username, String email, String password,String confirmPassword, String profilePic, String role) {
        this.employee_id = id;
        this.fullName = fullName;
        this.address = address;
        this.username = username;
        this.email = email;
        this.password = password;
        this.confirmPassword = confirmPassword;
        this.profilePic = profilePic;
        this.role = role;
    }
}
