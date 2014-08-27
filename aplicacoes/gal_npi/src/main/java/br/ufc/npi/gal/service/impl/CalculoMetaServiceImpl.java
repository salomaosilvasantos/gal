package br.ufc.npi.gal.service.impl;

import javax.inject.Inject;
import javax.inject.Named;

import br.ufc.npi.gal.model.Titulo;
import br.ufc.npi.gal.service.CalculadorMeta;
import br.ufc.npi.gal.service.CalculoMetaService;
import br.ufc.npi.gal.service.ResultadoCalculo;
import br.ufc.npi.gal.service.TituloService;

@Named
public class CalculoMetaServiceImpl implements CalculoMetaService {

	@Inject
	TituloService tituloService;
	@Inject
	CalculadorMeta calculo;
	
	ResultadoCalculo resultado;

	public ResultadoCalculo chamar() {

		return calculo.calcular(tituloService.find(Titulo.class));

	}

}
