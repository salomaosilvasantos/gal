package br.ufc.npi.gal.service.impl;

import javax.inject.Inject;
import javax.inject.Named;

import br.ufc.npi.gal.model.Disciplina;
import br.ufc.npi.gal.repository.DisciplinaRepository;
import br.ufc.npi.gal.service.DisciplinaService;


@Named
public class DisciplinaServiceImpl extends GenericServiceImpl<Disciplina> implements DisciplinaService {
	
	@Inject
	private DisciplinaRepository disciplinaRepository;

	@Override
	public Disciplina getDisciplinaByNome(String nome) {
		return disciplinaRepository.getDisciplinaByNome(nome);
	}

	@Override
	public Disciplina getDisciplinaByCodigo(String codigo) {
		return disciplinaRepository.getDisciplinaByCodigo(codigo);
	}

	@Override
	public Disciplina getOutraDisciplinaByNome(Integer id, String nome) {
		return disciplinaRepository.getOutraDisciplinaByNome(id, nome);
	}

	@Override
	public Disciplina getOutraDisciplinaByCodigo(Integer id, String codigo) {
		return disciplinaRepository.getOutraDisciplinaByCodigo(id, codigo);
	}

}