package action;

import service.ConfigService;

public class ConfigurarMesInicialAction extends Action {

	@Override
	public void process() throws Exception {
		String mes = getRequest().getParameter("mes");
		
		ConfigService configService = serviceFactory.getConfigService();
		configService.configurar_mes_inicial(mes);
	}
	
}