package br.ufc.npi.gal.service;

import br.ufc.npi.gal.model.Exemplar;
import br.ufc.quixada.npi.service.GenericService;

public interface ExemplarService extends GenericService<Exemplar> {
	public Exemplar getExemplarByCodigo(String codigoExemplar);
}
