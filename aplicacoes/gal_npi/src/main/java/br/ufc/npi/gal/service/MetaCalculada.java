package br.ufc.npi.gal.service;

import java.util.ArrayList;
import java.util.List;

public class MetaCalculada {

	private String nomeMeta;
	private List<DetalheMetaCalculada> detalhePar;
	private List<DetalheMetaCalculada> detalheImpar;
	
	

	public MetaCalculada() {
		super();
		this.nomeMeta = new String();
		this.detalhePar = new ArrayList<DetalheMetaCalculada>();
		this.detalheImpar = new ArrayList<DetalheMetaCalculada>();
	}

	public String getNome() {
		return nomeMeta;
	}

	public void setNome(String nome) {
		this.nomeMeta = nome;
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
	

	public String getNomeMeta() {
		return nomeMeta;
	}

	public void setNomeMeta(String nomeMeta) {
		this.nomeMeta = nomeMeta;
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
		return "MetaCalculada [nome=" + nomeMeta + ", detalhePar=" + detalhePar
				+ ", detalheImpar=" + detalheImpar + "]";
	}
	
	public double getCalculo(){
		return calcular();
	}

	public double calcular() {
		
		double somatorioPar = new Double(0);
		double somatorioImpar = new Double(0);
        
		for (DetalheMetaCalculada detalheMetaCalculadaPar : detalhePar) {
			somatorioPar = somatorioPar + detalheMetaCalculadaPar.getCalculo();
		}
		for (DetalheMetaCalculada detalheMetaCalculadaImpar : detalheImpar) {
			somatorioImpar = somatorioImpar + detalheMetaCalculadaImpar.getCalculo();
		}
		if (somatorioPar > somatorioImpar) {
			
			return ((int)(somatorioPar*10))/10.0;
			
		} else {
			
			return ((int)(somatorioImpar*10))/10.0;
		}
	}

}
