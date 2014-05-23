package br.ufc.npi.gal.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.ufc.npi.gal.model.Disciplina;
import br.ufc.npi.gal.repository.DisciplinaRepository;
import br.ufc.npi.gal.service.DisciplinaService;


@Service
public class DisciplinaServiceImpl implements DisciplinaService {

    @Autowired
    private DisciplinaRepository disciplinaRepository;
     
    public List<Disciplina> listar(){
    	return disciplinaRepository.listar();
    }
    
    public void excluir(Integer id){
    	this.disciplinaRepository.excluir(disciplinaRepository.buscar(id));
    }

	public Disciplina findById(Integer id) {
		Disciplina disciplina = this.disciplinaRepository.buscar(id);
		return disciplina;
	}

	public void atualizar(Disciplina disciplina) {
		this.disciplinaRepository.adicionarOuAtualizar(disciplina);
	}
	
	public Disciplina buscar(String codigo, String nome) {
		return disciplinaRepository.buscar(codigo, nome);
	}

	public void adicionar(Disciplina disciplina) {
		disciplinaRepository.adicionarOuAtualizar(disciplina);
	}

	public List<Disciplina> findByCodigo(String codigo) {
		List<Disciplina> disciplinas = disciplinaRepository.findByCodigo(codigo);
		return disciplinas;
	}
}