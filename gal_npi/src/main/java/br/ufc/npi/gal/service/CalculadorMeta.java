package br.ufc.npi.gal.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Named;

import br.ufc.npi.gal.model.Bibliografia;
import br.ufc.npi.gal.model.IntegracaoCurricular;
import br.ufc.npi.gal.model.Titulo;

@Named
public class CalculadorMeta {

	private int META_BASICA = 6;
	private int META_COMPLEMENTAR= 2;
	private List<ResultadoCalculo> resultCalculo;

	private MetaCalculada metaCalculada;
	private DetalheMetaCalculada detalheMeta;
	private List<DetalheMetaCalculada> detalhePares;
	private List<DetalheMetaCalculada> detalheImpares;

	public CalculadorMeta() {
		super();
		this.resultCalculo = new ArrayList<ResultadoCalculo>();
		this.metaCalculada = new MetaCalculada();
		this.detalheMeta = new DetalheMetaCalculada();
		this.detalhePares = new ArrayList<DetalheMetaCalculada>();
		this.detalheImpares = new ArrayList<DetalheMetaCalculada>();
	}

	public List<ResultadoCalculo> calcular(List<Titulo> titulos) {
		resultCalculo = new ArrayList<ResultadoCalculo>();

		for (Titulo t : titulos) {

			for (Bibliografia b : t.getBibliografias()) {

				for (IntegracaoCurricular i : b.getDisciplina().getCurriculos()) {
					detalheMeta.setCurriculo(i.getEstruturaCurricular()
							.getAnoSemestre());
					detalheMeta.setCurso(i.getEstruturaCurricular().getCurso().getNome());
					
					
					double calculo;
					if(b.getTipoBibliografia().equals("Complementar")){
						calculo = META_COMPLEMENTAR;
					}
					else{
						calculo = (double) ((double)i.getQuantidadeAlunos() / (double)META_BASICA);
					}
					
					detalheMeta.setCalculo(calculo);
					
					if (i.getSemestreOferta() % 2 == 0) {
						
						detalheMeta.setTipoBibliografia(b.getTipoBibliografia());
						detalheMeta.setDisciplina(b.getDisciplina().getNome());
						detalhePares.add(detalheMeta);
					} else {

						detalheMeta.setTipoBibliografia(b.getTipoBibliografia());
						detalheMeta.setDisciplina(b.getDisciplina().getNome());
						detalheImpares.add(detalheMeta);
					}
					
					detalheMeta = new DetalheMetaCalculada();

				}
			}
			metaCalculada.setNome("Inep 5");
			metaCalculada.setDetalheMetaCalculadaPar(detalhePares);
			metaCalculada.setDetalheMetaCalculadaImpar(detalheImpares);

			detalhePares = new ArrayList<DetalheMetaCalculada>();
			detalheImpares = new ArrayList<DetalheMetaCalculada>();
			resultCalculo.add(new ResultadoCalculo(t, metaCalculada));
			
			metaCalculada = new MetaCalculada();

		}

		return resultCalculo;
	}
}
