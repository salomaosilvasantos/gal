package br.ufc.npi.gal.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.inject.Named;

import br.ufc.npi.gal.model.Meta;
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
		
		return calculadorMeta.calcular(tituloService.find(Titulo.class),
				"inep 5", 6, 2);

	}

	public Map<String, List<ResultadoCalculo>> geraCalculo() {
		Map<String, List<ResultadoCalculo>> resultados = new HashMap<String, List<ResultadoCalculo>>();
		
		for (Meta meta : metaService.find(Meta.class)) {
			resultados.put(meta.getNome(), calculadorMeta.calcular(tituloService.find(Titulo.class), meta.getNome(), meta.getIndiceCalculoBasica(),meta.getIndiceCalculoComplementar()));
			//resultados.put(meta.getNome(), calculadorMeta.calcular(tituloService.find(Titulo.class), "Meta Repetida", meta.getIndiceCalculoBasica(),meta.getIndiceCalculoComplementar()));
		}
		return resultados;

	}
	
	public List<ResultadoCalculo> gerarCalculo2(){
		return calculadorMeta.calcular2(tituloService.find(Titulo.class),metaService.find(Meta.class));
	}

}
