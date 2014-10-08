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

	private static final String BIBLIOGRAFIA_TIPO_COMPLEMENTAR = "Complementar";

	public List<ResultadoCalculo> calcular(List<Titulo> titulos, String nomeMeta,double indiceCalculoBasica, double indiceCalculoComplementar) {
		List<ResultadoCalculo> resultadoCalculo = new ArrayList<ResultadoCalculo>();
		MetaCalculada metaCalculada;
		DetalheMetaCalculada detalheMeta;
		List<DetalheMetaCalculada> detalhePares;
		List<DetalheMetaCalculada> detalheImpares;

		for (Titulo titulo : titulos) {
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
						calculo = indiceCalculoComplementar;
					} else {
						calculo = ((double) integracaoCurricular
								.getQuantidadeAlunos() / (double) indiceCalculoBasica);
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

				}
			}
			metaCalculada.setNome(nomeMeta);
			metaCalculada.setDetalhePar(detalhePares);
			metaCalculada.setDetalheImpar(detalheImpares);

			resultadoCalculo.add(new ResultadoCalculo(titulo, metaCalculada));

		}

		return resultadoCalculo;
	}
}
