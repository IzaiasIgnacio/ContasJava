package action;

import service.GastosService;

public class EditarGastosAction extends Action {

	@Override
	public void process() throws Exception {
		
		int id = Integer.parseInt(getRequest().getParameter("id"));
		String tipo = getRequest().getParameter("tipo");
		String descricao = getRequest().getParameter("descricao");
		double valor = Double.parseDouble(getRequest().getParameter("valor"));
		
		GastosService gastosService = serviceFactory.getGastosService();
		gastosService.editarGastos(id,tipo,descricao,valor);
	}
	
}