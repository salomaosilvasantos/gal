package br.ufc.npi.gal.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.ufc.npi.gal.model.Disciplina;
import br.ufc.npi.gal.repository.DisciplinaRepository;


@Service
public class DisciplinaServiceImpl implements DisciplinaService {

	// numero de serie dos ficheiros, para saber qual classe os criou.
    private static final long serialVersionUID = 1L;
    
    private DisciplinaRepository disciplinaRepository;
     
    @Autowired
    public DisciplinaServiceImpl(DisciplinaRepository disciplinaRepository){
    	this.disciplinaRepository  = disciplinaRepository;  
    }
  
    public void setDisciplinaDao(DisciplinaRepository disciplinaRepository) {
        this.disciplinaRepository = disciplinaRepository;
    }
    
    
    public List<Disciplina> getDisciplinas(){
    	return disciplinaRepository.getDisciplinaList();
    }
    
    public void deleteDisciplina(Integer id){
    	this.disciplinaRepository.deleteDisciplina(id);
    }

	public Disciplina findById(Integer id) {
		Disciplina disc = this.disciplinaRepository.findById(id);
		return disc;
	}

	public void updateDisciplina(Disciplina disciplina) {
		this.disciplinaRepository.updateDisciplina(disciplina);
	}
	
	public Disciplina pesquisar(String cod, String nome) {
		return disciplinaRepository.pesquisarDisciplina(cod, nome);
	}

	public void inserir(Disciplina disciplina) {
		disciplinaRepository.save(disciplina);
	}

	public List<Disciplina> findByCod(String cod) {
		List<Disciplina> d = disciplinaRepository.findByCod(cod);
		return d;
	}
}