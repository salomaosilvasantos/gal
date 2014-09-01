package br.ufc.npi.gal.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Named;

import br.ufc.npi.gal.model.Bibliografia;
import br.ufc.npi.gal.model.IntegracaoCurricular;
import br.ufc.npi.gal.model.Titulo;

@Named
public class CalculadorMeta {

	private int META = 6;
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

		for (Titulo t : titulos) {

			for (Bibliografia b : t.getBibliografias()) {
				System.out.println(b.getTitulo().getNome());
				detalheMeta.setTipoBibliografia(b.getTipoBibliografia());
				detalheMeta.setDisciplina(b.getDisciplina().getNome());
				for (IntegracaoCurricular i : b.getDisciplina().getCurriculos()) {
					detalheMeta.setCurriculo(i.getEstruturaCurricular()
							.getAnoSemestre());
					detalheMeta.setCurso(i.getEstruturaCurricular().getCurso()
							.getNome());
					double calculo = (double) (i.getQuantidadeAlunos() / META);
					
					detalheMeta.setCalculo(calculo);

					if (i.getSemestreOferta() % 2 == 0) {
						detalhePares.add(detalheMeta);
					} else {
						detalheImpares.add(detalheMeta);
					}

				}
			}
			metaCalculada.setNome("Inep 5");
			metaCalculada.setDetalheMetaCalculadaPar(detalhePares);
			metaCalculada.setDetalheMetaCalculadaImpar(detalheImpares);

			resultCalculo.add(new ResultadoCalculo(t, metaCalculada));

		}

		return resultCalculo;
	}

}
