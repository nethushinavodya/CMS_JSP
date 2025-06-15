package org.example.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Complaints {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int complaint_id;
    private String title;
    private String description;
    private String status;
    private String priority;
    private String adminRemark;

    @ManyToOne
    private Employee employee;

    public Complaints(String title, String description, String status, String priority, String adminRemark, Employee employee) {
        this.title = title;
        this.description = description;
        this.status = status;
        this.priority = priority;
        this.adminRemark = adminRemark;
        this.employee = employee;
    }

    @Override
    public String toString() {
        return "Complaints{" +
                "complaint_id='" + complaint_id + '\'' +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", priority='" + priority + '\'' +
                ", status='" + status + '\'' +
                ", adminRemark='" + adminRemark + '\'' +
                ", employee_username='" + (employee != null ? employee.getUsername() : "null") + '\'' +
                '}';
    }

}
