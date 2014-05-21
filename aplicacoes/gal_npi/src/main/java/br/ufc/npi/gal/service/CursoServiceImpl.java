package br.ufc.npi.gal.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.ufc.npi.gal.model.Curso;
import br.ufc.npi.gal.repository.CursoRepository;


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
	
	
	public List<Curso> findByCodigo(String codigo) {
		List<Curso> cursos = cursoRepository.findByCodigo(codigo);
		return cursos;
	}
	
	public Curso findByCodigo(Integer codigo) {
		Curso curso = this.cursoRepository.buscar(codigo);
		return curso;
	}
	
	public Curso buscar(String sigla, String nome, String codigo) {
		return cursoRepository.buscar(sigla, nome, codigo);
	}
	
}