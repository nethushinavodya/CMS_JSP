package org.example.bo;

import org.example.bo.custom.impl.ComplaintBOImpl;
import org.example.bo.custom.impl.EmployeeBOImpl;

public class BOFactory {
    private static BOFactory boFactory;
    private BOFactory() {}
    public static BOFactory getInstance() {
        return boFactory==null?boFactory=new BOFactory():boFactory;
    }
    public enum BOType {
        EMPLOYEE, COMPLAINTS
    }
    public SuperBO getBO(BOType type) {
        switch (type) {
            case EMPLOYEE:
                return new EmployeeBOImpl();
            case COMPLAINTS:
                return new ComplaintBOImpl();
            default:
                return null;
        }
    }
}
