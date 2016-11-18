package dao;

import java.util.Calendar;
import java.util.List;

import entity.Gastos;

public class GastosDAO extends DAO<Gastos> {

	public GastosDAO() {
		super(Gastos.class);
	}
	
	@SuppressWarnings("unchecked")
	public List<Gastos> getGastos(Calendar data) throws DAOException {
		int mes = data.get(Calendar.MONTH)+1;
		int ano = data.get(Calendar.YEAR);
		return (List<Gastos>) list("FROM Gastos WHERE month(data) = "+mes+" and year(data) = "+ano+" ORDER BY descricao");
	}
	
}
