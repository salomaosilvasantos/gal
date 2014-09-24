package br.ufc.npi.gal.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Named;

import br.ufc.npi.gal.model.Bibliografia;
import br.ufc.npi.gal.model.DetalheMetaCalculada;
import br.ufc.npi.gal.model.IntegracaoCurricular;
import br.ufc.npi.gal.model.Titulo;

@Named
public class CalculadorMeta {

	private static final int META_BASICA = 6;
	private static final int META_COMPLEMENTAR = 2;
	private static final String BIBLIOGRAFIA_TIPO_COMPLEMENTAR = "Complementar";

	private List<ResultadoCalculo> resultadoCalculo;
	private MetaCalculada metaCalculada;
	private DetalheMetaCalculada detalheMeta;
	private List<DetalheMetaCalculada> detalhePares;
	private List<DetalheMetaCalculada> detalheImpares;

	public CalculadorMeta() {
		super();
		this.resultadoCalculo = new ArrayList<ResultadoCalculo>();
		this.metaCalculada = new MetaCalculada();
		this.detalheMeta = new DetalheMetaCalculada();
		this.detalhePares = new ArrayList<DetalheMetaCalculada>();
		this.detalheImpares = new ArrayList<DetalheMetaCalculada>();
	}

	public List<ResultadoCalculo> calcular(List<Titulo> titulos) {
		resultadoCalculo = new ArrayList<ResultadoCalculo>();

		for (Titulo titulo : titulos) {

			for (Bibliografia bibliografia : titulo.getBibliografias()) {

				for (IntegracaoCurricular integracaoCurricular : bibliografia
						.getDisciplina().getCurriculos()) {
					detalheMeta.setCurriculo(integracaoCurricular
							.getEstruturaCurricular().getAnoSemestre());
					detalheMeta.setCurso(integracaoCurricular
							.getEstruturaCurricular().getCurso().getNome());

					double calculo;
					if (BIBLIOGRAFIA_TIPO_COMPLEMENTAR.equals(bibliografia
							.getTipoBibliografia())) {
						calculo = META_COMPLEMENTAR;
					} else {
						calculo = ((double) integracaoCurricular
								.getQuantidadeAlunos() / (double) META_BASICA);
					}

					detalheMeta.setCalculo(calculo);

					if (integracaoCurricular.getSemestreOferta() % 2 == 0) {

						detalheMeta.setTipoBibliografia(bibliografia
								.getTipoBibliografia());
						detalheMeta.setDisciplina(bibliografia.getDisciplina()
								.getNome());
						detalhePares.add(detalheMeta);
					} else {

						detalheMeta.setTipoBibliografia(bibliografia
								.getTipoBibliografia());
						detalheMeta.setDisciplina(bibliografia.getDisciplina()
								.getNome());
						detalheImpares.add(detalheMeta);
					}

					detalheMeta = new DetalheMetaCalculada();

				}
			}
			metaCalculada.setNome("Inep 5");
			metaCalculada.setDetalhePar(detalhePares);
			metaCalculada.setDetalheImpar(detalheImpares);

			detalhePares = new ArrayList<DetalheMetaCalculada>();
			detalheImpares = new ArrayList<DetalheMetaCalculada>();
			resultadoCalculo.add(new ResultadoCalculo(titulo, metaCalculada));

			metaCalculada = new MetaCalculada();

		}

		return resultadoCalculo;
	}
}
