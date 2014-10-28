/**
 * Pojo simples para tratamento dos Titulos.
 * Possivel mudança para Beean no futuro.
 */

package br.ufc.gal.pojo;

import java.util.List;

public class Titulo {

	private int id_titulo_pk;
	private String isbn;
	private String nome;
	private String tipo;
	private List<String> codigo_exemplar;
	
	public int getId_titulo_pk() {
		return id_titulo_pk;
	}
	public void setId_titulo_pk(int id_titulo_pk) {
		this.id_titulo_pk = id_titulo_pk;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public List<String> getCodigo_exemplar() {
		return codigo_exemplar;
	}
	public void setCodigo_exemplar(List<String> codigo_exemplar) {
		this.codigo_exemplar = codigo_exemplar;
	}
	
	@Override
	public String toString() {
		
		String descricao = "";
		descricao += "ID: "+ id_titulo_pk;
		//descricao += "NOME: "+ nome;
		descricao += "ISBN: "+ isbn;
		//descricao += "TIPO: "+ tipo;
		return descricao;
	}
}
