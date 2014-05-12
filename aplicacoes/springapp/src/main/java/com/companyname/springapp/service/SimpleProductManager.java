package com.companyname.springapp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.companyname.springapp.domain.Disciplina;
import com.companyname.springapp.repository.DisciplinaDao;


@Service
public class SimpleProductManager implements ProductManager {

	//numero de serie dos ficheiros, para saber qual classe os criou.
    private static final long serialVersionUID = 1L;
    
    //OBS: NÃO ESQUEÇA QUE ESSAS VARIAVÉIS TEM QUE SER DO TIPO DA INTERFACE E NÃO DO TIPO DA CLASSE IMPLEMENTADA
     
     private DisciplinaDao disciplinaDao;
     
    @Autowired
    public SimpleProductManager(DisciplinaDao disciplinaDao){
    	this.disciplinaDao  = disciplinaDao;
    	
    }
  
  
    public void setDisciplinaDao(DisciplinaDao disciplinaDao) {
        this.disciplinaDao = disciplinaDao;
    }
    
    
    public List<Disciplina> getDisciplinas(){
    	return disciplinaDao.getDisciplinaList();
    }
    
    public void deleteDisciplina(Integer id){
    	
    	this.disciplinaDao.deleteDisciplina(id);
    	
    }
    

	public Disciplina findById(Integer id) {
		
		Disciplina disc = this.disciplinaDao.findById(id);
		
		return disc;
	}

	public void updateDisciplina(Disciplina disciplina) {

		this.disciplinaDao.updateDisciplina(disciplina);
	}
	
	public Disciplina pesquisar(String cod, String nome) {
		return disciplinaDao.pesquisarDisciplina(cod, nome);
	}

	public void inserir(Disciplina disciplina) {
		disciplinaDao.save(disciplina);
	}

	public List<Disciplina> findByCod(String cod) {
		List<Disciplina> d = disciplinaDao.findByCod(cod);
		return d;
	}
}