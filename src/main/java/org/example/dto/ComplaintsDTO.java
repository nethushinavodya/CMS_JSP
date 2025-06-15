package org.example.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ComplaintsDTO {
    private int complaint_id;
    private String title;
    private String description;
    private String status;
    private String priority;
    private String adminRemark;
    private String username;

    @Override
    public String toString() {
        return "ComplaintsDTO{" +
                "complaint_id='" + complaint_id + '\'' +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", priority='" + priority + '\'' +
                ", status='" + status + '\'' +
                ", adminRemark='" + adminRemark + '\'' +
                ", username='" + username + '\'' +
                '}';
    }

}
