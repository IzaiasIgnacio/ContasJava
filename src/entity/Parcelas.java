package entity;

public class Parcelas {

	private Integer id;
	private Gastos gasto;
	private Gastos parcela;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Gastos getGasto() {
		return gasto;
	}
	public void setGasto(Gastos gasto) {
		this.gasto = gasto;
	}
	public Gastos getParcela() {
		return parcela;
	}
	public void setParcela(Gastos parcela) {
		this.parcela = parcela;
	}
	
}
