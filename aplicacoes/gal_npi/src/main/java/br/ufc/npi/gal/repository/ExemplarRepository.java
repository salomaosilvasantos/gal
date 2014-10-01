package br.ufc.npi.gal.repository;

import br.ufc.npi.gal.model.Exemplar;

public interface ExemplarRepository extends GenericRepository<Exemplar> {
	public abstract Exemplar getExemplarByCodigo(String codigoExemplar);
}
