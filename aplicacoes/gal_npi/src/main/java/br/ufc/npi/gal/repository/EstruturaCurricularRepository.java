package br.ufc.npi.gal.repository;

import java.util.List;

import br.ufc.npi.gal.model.EstruturaCurricular;

public interface EstruturaCurricularRepository extends GenericRepository<EstruturaCurricular>{
	public List<EstruturaCurricular> listarCurriculos();
}
