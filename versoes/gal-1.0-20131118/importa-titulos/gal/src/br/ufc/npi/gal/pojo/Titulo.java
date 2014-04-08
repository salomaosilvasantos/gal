package br.ufc.npi.gal.pojo;

import java.util.List;

public class Titulo implements Comparable<Titulo>{
	
	private int id_titulo_pk;
	private String nome;
	private String isbn;
	private String tipo;
	private List<String> codigo_exemplar;
	
	public int getId_titulo_pk() {
		return id_titulo_pk;
	}
	public void setId_titulo_pk(int id_titulo_pk) {
		this.id_titulo_pk = id_titulo_pk;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
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
	public void setCodigo_exemplar(List<String> exemplares) {
		this.codigo_exemplar = exemplares;
	}
	
	@Override
	public String toString() {
		String separador = "-";
		String descricao = "";
		descricao += getId_titulo_pk();
		descricao += separador + getNome();
		descricao += separador + getTipo();
		descricao += separador + getId_titulo_pk();
		return descricao;
	}
	
	@Override
	public boolean equals(Object obj) {
		boolean iguais = false;
		
		Titulo titulo = (Titulo) obj;
		
		if(this.isbn.equals(titulo.getIsbn())){
			iguais = true;
		}
		
		return iguais;
	}
	@Override
	public int compareTo(Titulo o) {
		int ordem;
		
		ordem = this.isbn.compareTo(o.getIsbn());
		
		return ordem;
	}
	
}
