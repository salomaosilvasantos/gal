package br.ufc.npi.gal.service;

import java.util.List;
import java.util.Map;

public interface CalculoMetaService {

	public abstract List<ResultadoCalculo> gerarCalculo();

	public abstract List<ResultadoCalculo> gerarCalculo2();
	public abstract Map<String, List<ResultadoCalculo>> geraCalculo();
    
}