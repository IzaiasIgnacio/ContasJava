package service;

public class ServiceFactory {

	private static ServiceFactory instance;
	
	private ServiceFactory() {
	}
	
	public static ServiceFactory getInstance() {
		if (instance == null) {
			instance = new ServiceFactory();
		}
		return instance;
	}
	
	public GastosService getGastosService() {
		GastosService service = new GastosService();
		return service;
	}
	
	public ConfigService getConfigService() {
		ConfigService service = new ConfigService();
		return service;
	}	
	
		
}
