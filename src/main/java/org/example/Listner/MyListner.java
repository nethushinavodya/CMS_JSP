package org.example.Listner;

import jakarta.servlet.annotation.WebListener;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;

@WebListener
public class MyListner implements ServletContextListener {
    private static SessionFactory sessionFactory;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            sessionFactory = new Configuration().configure().buildSessionFactory();
            sce.getServletContext().setAttribute("sessionFactory", sessionFactory);
            System.out.println("SessionFactory initialized successfully");
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to initialize SessionFactory", e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
}