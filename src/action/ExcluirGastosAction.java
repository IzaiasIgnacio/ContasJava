package action;

import service.GastosService;

public class ExcluirGastosAction extends Action {

	@Override
	public void process() throws Exception {
		
		int id = Integer.parseInt(getRequest().getParameter("id"));
		
		GastosService gastosService = serviceFactory.getGastosService();
		gastosService.excluirGastos(id);
	}
	
}