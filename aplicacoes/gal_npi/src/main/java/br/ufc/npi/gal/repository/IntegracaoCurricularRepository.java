package br.ufc.npi.gal.repository;

import java.util.List;

import br.ufc.npi.gal.model.IntegracaoCurricular;

public interface IntegracaoCurricularRepository extends GenericRepository<IntegracaoCurricular> {
	public List<IntegracaoCurricular> listar();
	public void salvar(IntegracaoCurricular integracaoCurricular);
}
