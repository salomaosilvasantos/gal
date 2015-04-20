package br.ufc.npi.gal.service.impl;

import java.util.List;

import javax.inject.Inject;
import javax.inject.Named;

import br.ufc.npi.gal.model.Titulo;
import br.ufc.npi.gal.service.CalculadorMeta;
import br.ufc.npi.gal.service.CalculoMetaService;
import br.ufc.npi.gal.service.MetaService;
import br.ufc.npi.gal.service.ResultadoCalculo;
import br.ufc.npi.gal.service.TituloService;

@Named
public class CalculoMetaServiceImpl implements CalculoMetaService {

	@Inject
	private TituloService tituloService;
	@Inject
	private CalculadorMeta calculadorMeta;

	@Inject
	private MetaService metaService;

	public List<ResultadoCalculo> gerarCalculo() {
		return calculadorMeta.calcular(tituloService.find(Titulo.class),metaService.getMeta());
	}

}
