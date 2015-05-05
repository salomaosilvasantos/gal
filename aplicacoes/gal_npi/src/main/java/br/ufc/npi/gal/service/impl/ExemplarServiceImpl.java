package br.ufc.npi.gal.service.impl;

import javax.inject.Inject;
import javax.inject.Named;

import br.ufc.npi.gal.model.Exemplar;
import br.ufc.npi.gal.repository.ExemplarRepository;
import br.ufc.npi.gal.service.ExemplarService;
import br.ufc.quixada.npi.service.impl.GenericServiceImpl;

@Named
public class ExemplarServiceImpl extends GenericServiceImpl<Exemplar> implements ExemplarService {
	
	@Inject
	private ExemplarRepository exemplarRepository;
	
	@Override
	public Exemplar getExemplarByCodigo(String codigoExemplar) {
		return exemplarRepository.getExemplarByCodigo(codigoExemplar);
	}
	
	

}
