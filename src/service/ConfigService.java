package service;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigService {
	
	public void configurar_saldo(double saldo) {
	    try {
	    	Properties prop = new Properties();
	    	InputStream in = new FileInputStream("C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/Contas/config.properties");
	    	prop.load(in);
	    	prop.setProperty("saldo_atual",String.valueOf(saldo));
	    	prop.store(new FileOutputStream("C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/Contas/config.properties"), null);
		}
	    catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void configurar_renda(double renda) {
	    try {
	    	Properties prop = new Properties();
	    	InputStream in = new FileInputStream("C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/Contas/config.properties");
	    	prop.load(in);
	    	prop.setProperty("renda_mensal",String.valueOf(renda));
	    	prop.store(new FileOutputStream("C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/Contas/config.properties"), null);
		}
	    catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void configurar_mes_inicial(String mes) {
	    try {
	    	Properties prop = new Properties();
	    	InputStream in = new FileInputStream("C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/Contas/config.properties");
	    	prop.load(in);
	    	prop.setProperty("mes_inicial",mes);
	    	prop.store(new FileOutputStream("C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/Contas/config.properties"), null);
		}
	    catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
