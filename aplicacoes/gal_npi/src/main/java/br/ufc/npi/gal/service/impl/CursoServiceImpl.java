package br.ufc.npi.gal.service.impl;

import javax.inject.Inject;
import javax.inject.Named;

import br.ufc.npi.gal.model.Curso;
import br.ufc.npi.gal.repository.CursoRepository;
import br.ufc.npi.gal.service.CursoService;
import br.ufc.quixada.npi.service.impl.GenericServiceImpl;

@Named
public class CursoServiceImpl extends GenericServiceImpl<Curso> implements CursoService {
	
	@Inject
	private CursoRepository cursoRepository;

	@Override
	public Curso getCursoBySigla(String sigla) {
		return cursoRepository.getCursoBySigla(sigla);
	}

	@Override
	public Curso getCursoByCodigo(Integer codigo) {
		return cursoRepository.getCursoByCodigo(codigo);
	}

	@Override
	public Curso getOutroCursoBySigla(Integer id, String sigla) {
		return cursoRepository.getOutroCursoBySigla(id, sigla);
	}

	@Override
	public Curso getOutroCursoByCodigo(Integer id, Integer codigo) {
		return cursoRepository.getOutroCursoByCodigo(id, codigo);
	}

	
}