package action;

import service.ConfigService;

public class ConfigurarSaldoAction extends Action {

	@Override
	public void process() throws Exception {
		double saldo = Double.parseDouble(getRequest().getParameter("saldo"));
		
		ConfigService configService = serviceFactory.getConfigService();
		configService.configurar_saldo(saldo);
	}
	
}