package entity;

import java.util.Date;

public class Gastos {

	private Integer id;
	private String descricao;
	private Double valor;
	private Integer parcela;
	private Integer total_parcelas;
	private Date data;
	private String tipo;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public Double getValor() {
		return valor;
	}
	public void setValor(Double valor) {
		this.valor = valor;
	}
	public Integer getParcela() {
		return parcela;
	}
	public void setParcela(Integer parcela) {
		this.parcela = parcela;
	}
	public Integer getTotal_parcelas() {
		return total_parcelas;
	}
	public void setTotal_parcelas(Integer total_parcelas) {
		this.total_parcelas = total_parcelas;
	}
	public Date getData() {
		return data;
	}
	public void setData(Date data) {
		this.data = data;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	
}
