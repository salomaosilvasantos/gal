package br.ufc.npi.gal.service;

import java.util.ArrayList;
import java.util.List;

import br.ufc.npi.gal.model.DetalheMetaCalculada;

public class MetaCalculada {

	private String nome;
	private List<DetalheMetaCalculada> detalhePar;
	private List<DetalheMetaCalculada> detalheImpar;

	public MetaCalculada() {
		super();
		this.detalhePar = new ArrayList<DetalheMetaCalculada>();
		this.detalheImpar = new ArrayList<DetalheMetaCalculada>();
	}

	public MetaCalculada(String nome, List<DetalheMetaCalculada> detalhePar,
			List<DetalheMetaCalculada> detalheImpar) {
		super();
		this.nome = nome;
		this.detalhePar = detalhePar;
		this.detalheImpar = detalheImpar;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public List<DetalheMetaCalculada> getDetalhePar() {
		return detalhePar;
	}

	public void setDetalhePar(List<DetalheMetaCalculada> detalhePar) {
		this.detalhePar = detalhePar;
	}

	public List<DetalheMetaCalculada> getDetalheImpar() {
		return detalheImpar;
	}

	public void setDetalheImpar(List<DetalheMetaCalculada> detalheImpar) {
		this.detalheImpar = detalheImpar;
	}

	@Override
	public String toString() {
		return "MetaCalculada [nome=" + nome + ", detalhePar=" + detalhePar
				+ ", detalheImpar=" + detalheImpar + "]";
	}

	public double getCalculo() {
		return calcular();
	}

	public double calcular() {

		double somatorioPar = 0;
		double somatorioImpar = 0;

		for (DetalheMetaCalculada detalheMetaCalculadaPar : detalhePar) {
			somatorioPar = somatorioPar + detalheMetaCalculadaPar.getCalculo();
		}
		for (DetalheMetaCalculada detalheMetaCalculadaImpar : detalheImpar) {
			somatorioImpar = somatorioImpar
					+ detalheMetaCalculadaImpar.getCalculo();
		}
		if (somatorioPar > somatorioImpar) {

			return somatorioPar;

		} else {

			return  somatorioImpar;
		}
	}

}
