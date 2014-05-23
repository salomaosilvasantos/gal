package br.ufc.npi.gal.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.ufc.npi.gal.model.Curso;
import br.ufc.npi.gal.repository.CursoRepository;
import br.ufc.npi.gal.service.CursoService;


@Service
public class CursoServiceImpl implements CursoService {

	@Autowired
    private CursoRepository cursoRepository;
     
    public List<Curso> listar(){
    	return cursoRepository.listar();
    }
    
    public void excluir(Integer id){
    	this.cursoRepository.excluir(cursoRepository.buscar(id));
    }

	public void atualizar(Curso curso) {
		this.cursoRepository.adicionarOuAtualizar(curso);
	}

	public void adicionar(Curso curso) {
		cursoRepository.adicionarOuAtualizar(curso);
	}
	
	
	public List<Curso> findByCodigoList(String codigo) {
		List<Curso> cursos = cursoRepository.findByCodigo(codigo);
		return cursos;
	}
	
	public Curso findById(Integer id) {
		Curso curso = this.cursoRepository.buscar(id);
		return curso;
	}
	
	public Curso buscar(String sigla, String codigo) {
		return cursoRepository.buscar(sigla, codigo);
	}
	
}