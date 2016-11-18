package action;

import java.io.FileInputStream;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import entity.Gastos;
import service.GastosService;

public class ListarGastosAction extends Action {

	@Override
	public void process() throws Exception {
		
		String[] meses = new String[12];
		meses[0] = "Janeiro";
		meses[1] = "Fevereiro";
		meses[2] = "Março";
		meses[3] = "Abril"; 
		meses[4] = "Maio";
		meses[5] = "Junho";
		meses[6] = "Julho";
		meses[7] = "Agosto";
		meses[8] = "Setembro";
		meses[9] = "Outubro";
		meses[10] = "Novembro";
		meses[11] = "Dezembro";
		
		Properties prop = new Properties();
    	InputStream in = new FileInputStream("C:/Program Files/Apache Software Foundation/Tomcat 7.0/webapps/Contas/config.properties");
    	prop.load(in);
    	
		Double saldo_atual = Double.parseDouble(prop.getProperty("saldo_atual"));
		Double renda_mensal = Double.parseDouble(prop.getProperty("renda_mensal"));
		String mes_inicial = prop.getProperty("mes_inicial");
		String data_inicial = "01/"+mes_inicial;
		
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date data = formatter.parse(data_inicial);
		Calendar cal = Calendar.getInstance();
		cal.setTime(data);
		
		GastosService GastosService = serviceFactory.getGastosService();
		
		String mes1 = meses[cal.get(Calendar.MONTH)];
		int m1 = cal.get(Calendar.MONTH)+1;
		int ano1 = cal.get(Calendar.YEAR);
		List<Gastos> gastos1 = GastosService.getGastos(cal);
		
		cal.add(Calendar.MONTH, 1);
		String mes2 = meses[cal.get(Calendar.MONTH)];
		int m2 = cal.get(Calendar.MONTH)+1;
		int ano2 = cal.get(Calendar.YEAR);
		List<Gastos> gastos2 = GastosService.getGastos(cal);
		
		cal.add(Calendar.MONTH, 1);
		String mes3 = meses[cal.get(Calendar.MONTH)];
		int m3 = cal.get(Calendar.MONTH)+1;
		int ano3 = cal.get(Calendar.YEAR);
		List<Gastos> gastos3 = GastosService.getGastos(cal);
		
		cal.add(Calendar.MONTH, 1);
		String mes4 = meses[cal.get(Calendar.MONTH)];
		int m4 = cal.get(Calendar.MONTH)+1;
		int ano4 = cal.get(Calendar.YEAR);
		List<Gastos> gastos4 = GastosService.getGastos(cal);
		
		getRequest().setAttribute("saldo", saldo_atual);
		getRequest().setAttribute("renda_mensal", renda_mensal);
		getRequest().setAttribute("mes_inicial", mes_inicial);
		getRequest().setAttribute("gastos1", gastos1);
		getRequest().setAttribute("gastos2", gastos2);
		getRequest().setAttribute("gastos3", gastos3);
		getRequest().setAttribute("gastos4", gastos4);
		getRequest().setAttribute("mes1", mes1);
		getRequest().setAttribute("mes2", mes2);
		getRequest().setAttribute("mes3", mes3);
		getRequest().setAttribute("mes4", mes4);
		getRequest().setAttribute("m1", m1);
		getRequest().setAttribute("m2", m2);
		getRequest().setAttribute("m3", m3);
		getRequest().setAttribute("m4", m4);
		getRequest().setAttribute("ano1", ano1);
		getRequest().setAttribute("ano2", ano2);
		getRequest().setAttribute("ano3", ano3);
		getRequest().setAttribute("ano4", ano4);
		forward("lista_gastos.jsp");
	}
	
}
