package br.ufc.gal.pojo;

public class Exemplar {

	private int id_exemplar_pk;
	private int id_titulo_pk;
	private String codigo_exemplar_pk;
	
	public int getId_exemplar_pk() {
		return id_exemplar_pk;
	}
	public void setId_exemplar_pk(int id_exemplar_pk) {
		this.id_exemplar_pk = id_exemplar_pk;
	}
	public int getId_titulo_pk() {
		return id_titulo_pk;
	}
	public void setId_titulo_pk(int id_titulo_pk) {
		this.id_titulo_pk = id_titulo_pk;
	}
	public String getCodigo_exemplar_pk() {
		return codigo_exemplar_pk;
	}
	public void setCodigo_exemplar_pk(String codigo_exemplar_pk) {
		this.codigo_exemplar_pk = codigo_exemplar_pk;
	}
	
	@Override
	public String toString() {
		String descricao = "";
		return descricao;
	}
}
