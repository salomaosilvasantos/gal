package br.ufc.npi.gal.service;

import br.ufc.npi.gal.model.Exemplar;

public interface ExemplarService extends GenericService<Exemplar> {
	public Exemplar getExemplarByCod(String codExemplar);
}
