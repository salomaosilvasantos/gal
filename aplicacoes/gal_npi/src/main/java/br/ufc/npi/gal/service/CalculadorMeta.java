package br.ufc.npi.gal.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Named;

import br.ufc.npi.gal.model.Bibliografia;
import br.ufc.npi.gal.model.DetalheMetaCalculada;
import br.ufc.npi.gal.model.IntegracaoCurricular;
import br.ufc.npi.gal.model.Meta;
import br.ufc.npi.gal.model.Titulo;

@Named
public class CalculadorMeta {

	private static final String BIBLIOGRAFIA_TIPO_COMPLEMENTAR = "Complementar";

	public List<ResultadoCalculo> calcular2(List<Titulo> titulos,
			List<Meta> metas) {
		List<ResultadoCalculo> resultadoCalculo = new ArrayList<ResultadoCalculo>();
		MetaCalculada metaCalculada;
		DetalheMetaCalculada detalheMeta;
		List<DetalheMetaCalculada> detalhePares;
		List<DetalheMetaCalculada> detalheImpares;
		List<MetaCalculada> metasCalculadas;

		for (Titulo titulo : titulos) {
			metasCalculadas = new ArrayList<MetaCalculada>();
			for (Meta meta : metas) {
				metaCalculada = new MetaCalculada();
				detalhePares = new ArrayList<DetalheMetaCalculada>();
				detalheImpares = new ArrayList<DetalheMetaCalculada>();

				for (Bibliografia bibliografia : titulo.getBibliografias()) {

					for (IntegracaoCurricular integracaoCurricular : bibliografia
							.getDisciplina().getCurriculos()) {
						detalheMeta = new DetalheMetaCalculada();
						detalheMeta.setCurriculo(integracaoCurricular
								.getEstruturaCurricular().getAnoSemestre());
						detalheMeta.setCurso(integracaoCurricular
								.getEstruturaCurricular().getCurso().getNome());

						double calculo;
						if (BIBLIOGRAFIA_TIPO_COMPLEMENTAR.equals(bibliografia
								.getTipoBibliografia())) {
							calculo = meta.getIndiceCalculoComplementar();
						} else {
							calculo = ((double) integracaoCurricular
									.getQuantidadeAlunos() / (double) meta
									.getIndiceCalculoBasica());
						}

						detalheMeta.setCalculo(calculo);

						if (integracaoCurricular.getSemestreOferta() % 2 == 0) {

							detalheMeta.setTipoBibliografia(bibliografia
									.getTipoBibliografia());
							detalheMeta.setDisciplina(bibliografia
									.getDisciplina().getNome());
							detalhePares.add(detalheMeta);
						} else {

							detalheMeta.setTipoBibliografia(bibliografia
									.getTipoBibliografia());
							detalheMeta.setDisciplina(bibliografia
									.getDisciplina().getNome());
							detalheImpares.add(detalheMeta);
						}

					}
				}
				metaCalculada.setNome(meta.getNome());
				metaCalculada.setDetalhePar(detalhePares);
				metaCalculada.setDetalheImpar(detalheImpares);
				metasCalculadas.add(metaCalculada);
			}

			resultadoCalculo.add(new ResultadoCalculo(titulo, metasCalculadas));

		}

		return resultadoCalculo;
	}
}
