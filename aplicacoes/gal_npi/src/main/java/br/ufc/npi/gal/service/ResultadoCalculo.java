package br.ufc.npi.gal.service;

import java.util.List;

import br.ufc.npi.gal.model.Titulo;

public class ResultadoCalculo {

	private Titulo titulo;
	private MetaCalculada metaCalculada;
	private List<MetaCalculada> metasCalculadas;

	public ResultadoCalculo() {
		super();
		this.titulo = new Titulo();
		this.metaCalculada = new MetaCalculada();
	}

	public ResultadoCalculo(Titulo titulo, MetaCalculada metaCalculada) {
		super();
		this.titulo = titulo;
		this.metaCalculada = metaCalculada;
	}

	public ResultadoCalculo(Titulo titulo, List<MetaCalculada> metasCalculadas) {
		super();
		this.titulo = titulo;
		this.metasCalculadas = metasCalculadas;
	}

	public Titulo getTitulo() {
		return titulo;
	}

	public void setTitulo(Titulo titulo) {
		this.titulo = titulo;
	}

	public MetaCalculada getMetaCalculada() {
		return metaCalculada;
	}

	public void setMetaCalculada(MetaCalculada metaCalculada) {
		this.metaCalculada = metaCalculada;
	}

	public List<MetaCalculada> getMetasCalculadas() {
		return metasCalculadas;
	}

	public void setMetasCalculadas(List<MetaCalculada> metasCalculadas) {
		this.metasCalculadas = metasCalculadas;
	}

	@Override
	public String toString() {
		return "ResultadoCalculo [titulo=" + titulo + ", metaCalculada="
				+ metaCalculada + "]";
	}

}
