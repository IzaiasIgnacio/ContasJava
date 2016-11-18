package dao;


public class DAOFactory {

	private static DAOFactory instance;
	
	private DAOFactory() {
	}
	
	public static DAOFactory getInstance() {
		if (instance == null) {
			instance = new DAOFactory();
		}
		return instance;
	}
	
	public GastosDAO getGastosDAO() {
		GastosDAO dao = new GastosDAO();
		return dao;
	}
	
	public ParcelasDAO getParcelasDAO() {
		ParcelasDAO dao = new ParcelasDAO();
		return dao;
	}
}
