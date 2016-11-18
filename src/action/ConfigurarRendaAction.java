package action;

import service.ConfigService;

public class ConfigurarRendaAction extends Action {

	@Override
	public void process() throws Exception {
		double renda = Double.parseDouble(getRequest().getParameter("renda"));
		
		ConfigService configService = serviceFactory.getConfigService();
		configService.configurar_renda(renda);
	}
	
}