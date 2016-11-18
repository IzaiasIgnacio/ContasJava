package util;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;


public class HibernateUtil {

	private static SessionFactory sf;
	
    static {
        try {
            sf = new Configuration().configure().buildSessionFactory();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new ExceptionInInitializerError(ex);
        }
    }
	
	public static Session getSession() {
		return sf.getCurrentSession();
	}
	
	public static void beginTransaction() {
		Session session = getSession();
		session.beginTransaction();
	}

	public static void commitTransaction() {
		Session session = getSession();
		session.getTransaction().commit();
	}

	public static void rollbackTransaction() {
		Session session = getSession();
		session.getTransaction().rollback();
	}
}
