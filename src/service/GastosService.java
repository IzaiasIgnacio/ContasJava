package service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import dao.DAOException;
import dao.GastosDAO;
import dao.ParcelasDAO;
import entity.Gastos;
import entity.Parcelas;
import util.HibernateUtil;

public class GastosService extends Service {

	public List<Gastos> getGastos(Calendar data) throws ServiceException {
		try {
			GastosDAO GastosDAO = daoFactory.getGastosDAO();
			List<Gastos> gastos = GastosDAO.getGastos(data);
			return gastos;

		} catch (DAOException e) {
			throw new ServiceException(e);
		}
	}
	
	public Gastos incluirGasto(String tipo, String descricao, double valor, int parcelas, int total_parcelas, Date data) {
		GastosDAO gastosDAO = daoFactory.getGastosDAO();
		Gastos gastos = new Gastos();
		try {
			gastos.setTipo(tipo);
			gastos.setDescricao(descricao);
			gastos.setValor(valor);
			gastos.setParcela(parcelas);
			gastos.setTotal_parcelas(total_parcelas);
			gastos.setData(data);
			
			gastosDAO.save(gastos);
		} catch (DAOException e) {
			e.printStackTrace();
		}
		return gastos;
	}
	
	public void incluirParcela(Gastos primeira_parcela,Gastos parcela) {
		ParcelasDAO parcelasDAO = daoFactory.getParcelasDAO();
		Parcelas parcelas = new Parcelas();
		try {
			GastosDAO gastosDAO = daoFactory.getGastosDAO();
			Gastos gasto_primeira_parcela = gastosDAO.load(primeira_parcela.getId());
			Gastos gasto_parcela = gastosDAO.load(parcela.getId());
			
			parcelas.setGasto(gasto_primeira_parcela);
			parcelas.setParcela(gasto_parcela);
			
			parcelasDAO.save(parcelas);
		} catch (DAOException e) {
			e.printStackTrace();
		}
	}
	
	public void editarGastos(int id,String tipo,String descricao,double valor) {
		try {
			GastosDAO gastosDAO = daoFactory.getGastosDAO();
			Gastos gastos = gastosDAO.load(id);
			
			gastos.setTipo(tipo);
			gastos.setDescricao(descricao);
			gastos.setValor(valor);
			
			gastosDAO.save(gastos);
		} catch (DAOException e) {
			e.printStackTrace();
		}
	}

	public void excluirGastos(int id) {
		Session session = HibernateUtil.getSession();
		GastosDAO gastosDAO = daoFactory.getGastosDAO();
		
		try {
			
			Query query = session.createQuery("select parcela from Parcelas where id_gasto = :id_gasto)");
			query.setParameter("id_gasto", id);
			@SuppressWarnings("unchecked")
			List<Gastos> lista = query.list();
		
			if (lista.size() > 0) {
				for (Gastos g : lista) {
					gastosDAO.delete(g);
				}
			}
			else {
				gastosDAO.delete(gastosDAO.load(id));
			}
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
