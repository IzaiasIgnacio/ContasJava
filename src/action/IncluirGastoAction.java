package action;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import entity.Gastos;
import service.GastosService;

public class IncluirGastoAction extends Action {

	@Override
	public void process() throws Exception {
		
		String tipo = getRequest().getParameter("tipo");
		String descricao = getRequest().getParameter("descricao");
		double valor = Double.parseDouble(getRequest().getParameter("valor"));
		int parcelas = Integer.parseInt(getRequest().getParameter("parcelas"));
		
		String data_gasto = "01/"+getRequest().getParameter("mes_gasto")+'/'+getRequest().getParameter("ano_gasto");
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		Date data = formatter.parse(data_gasto);
		Calendar cal = Calendar.getInstance();
		cal.setTime(data);
		
		GastosService gastosService = serviceFactory.getGastosService();
		
		if (parcelas > 1) {
			Gastos primeira_parcela = new Gastos();
			for (int i=1;i<=parcelas;i++) {
				Gastos gasto = gastosService.incluirGasto(tipo,descricao,valor,i,parcelas,cal.getTime());
				if (i == 1) {
					primeira_parcela = gasto;
				}
				gastosService.incluirParcela(primeira_parcela, gasto);
				cal.add(Calendar.MONTH, 1);
			}
		}
		else {
			gastosService.incluirGasto(tipo,descricao,valor,1,1,cal.getTime());
		}
	}
	
}