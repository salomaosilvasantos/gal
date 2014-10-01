package br.ufc.npi.gal.service.impl;

import javax.inject.Inject;
import javax.inject.Named;

import br.ufc.npi.gal.model.Exemplar;
import br.ufc.npi.gal.repository.ExemplarRepository;
import br.ufc.npi.gal.service.ExemplarService;

@Named
public class ExemplarServiceImpl extends GenericServiceImpl<Exemplar> implements ExemplarService {
	
	@Inject
	private ExemplarRepository exemplarRepository;
	
	@Override
	public Exemplar getExemplarByCod(String codExemplar) {
		return exemplarRepository.getExemplarByCod(codExemplar);
	}
	
	

}
