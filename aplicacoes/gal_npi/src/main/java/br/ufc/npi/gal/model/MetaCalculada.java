package br.ufc.npi.gal.model;

import java.util.List;

public class MetaCalculada {

	private String nome;
	private List<DetalheMetaCalculada> detalhePar;
	private List<DetalheMetaCalculada> detalheImpar;

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public List<DetalheMetaCalculada> getDetalheMetaCalculadaPar() {
		return detalhePar;
	}

	public void setDetalheMetaCalculadaPar(
			List<DetalheMetaCalculada> detalheMetaCalculadaPar) {
		this.detalhePar = detalheMetaCalculadaPar;
	}

	public List<DetalheMetaCalculada> getDetalheMetaCalculadaImpar() {
		return detalheImpar;
	}

	public void setDetalheMetaCalculadaImpar(
			List<DetalheMetaCalculada> detalheMetaCalculadaImpar) {
		this.detalheImpar = detalheMetaCalculadaImpar;
	}

	@Override
	public String toString() {
		return "MetaCalculada [nome=" + nome + ", detalhePar=" + detalhePar
				+ ", detalheImpar=" + detalheImpar + "]";
	}
	
	

}
