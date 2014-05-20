package br.ufc.npi.gal.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.ufc.npi.gal.model.Curso;
import br.ufc.npi.gal.repository.CursoRepository;


@Service
public class CursoServiceImpl implements CursoService {

	// numero de serie dos ficheiros, para saber qual classe os criou.
    private static final long serialVersionUID = 1L;
    
    @Autowired
    private CursoRepository cursoRepository;
     
    public List<Curso> getCursos(){
    	return cursoRepository.list();
    }
    
    public void deleteCurso(Integer id){
    	this.cursoRepository.delete(cursoRepository.find(id));
    }

	public void updateCurso(Curso curso) {
		this.cursoRepository.update(curso);
	}

	public void inserir(Curso curso) {
		cursoRepository.save(curso);
	}
	
	
	public List<Curso> findByCod(String cod) {
		List<Curso> d = cursoRepository.findByCod(cod);
		return d;
	}
	
	public Curso findByCod(Integer cod) {
		Curso disc = this.cursoRepository.find(cod);
		return disc;
	}
	
	public Curso pesquisar(String sigla, String nome, String cod) {
		return cursoRepository.pesquisarCurso(sigla, nome, cod);
	}
	
}