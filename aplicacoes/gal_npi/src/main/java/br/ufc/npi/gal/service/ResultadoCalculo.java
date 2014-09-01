package br.ufc.npi.gal.service;

import br.ufc.npi.gal.model.Titulo;

public class ResultadoCalculo {

	private Titulo titulo;
	private MetaCalculada metaCalculada;
	
	

	public ResultadoCalculo() {
		super();
		titulo = titulo;
		metaCalculada = metaCalculada;
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

	@Override
	public String toString() {
		return "ResultadoCalculo [titulo=" + titulo + ", metaCalculada="
				+ metaCalculada + "]";
	}

}
