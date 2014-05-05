package com.companyname.springapp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.companyname.springapp.domain.Disciplina;
import com.companyname.springapp.domain.Product;
import com.companyname.springapp.repository.DisciplinaDao;
import com.companyname.springapp.repository.ProductDao;

@Service
public class SimpleProductManager implements ProductManager {

	//numero de serie dos ficheiros, para saber qual classe os criou.
    private static final long serialVersionUID = 1L;
    
    //OBS: NÃO ESQUEÇA QUE ESSAS VARIAVÉIS TEM QUE SER DO TIPO DA INTERFACE E NÃO DO TIPO DA CLASSE IMPLEMENTADA
     private ProductDao productDao;
     private DisciplinaDao disciplinaDao;
     
    @Autowired
    public SimpleProductManager(DisciplinaDao disciplinaDao,ProductDao productDao){
    	this.disciplinaDao  = disciplinaDao;
    	this.productDao = productDao;
    }
  
    public void setProductDao(ProductDao productDao) {
        this.productDao = productDao;
    }
    public void setDisciplinaDao(DisciplinaDao disciplinaDao) {
        this.disciplinaDao = disciplinaDao;
    }
    
    public List<Product> getProducts() {
        return productDao.getProductList();
    }

    public void increasePrice(int percentage) {
        List<Product> products = productDao.getProductList();
        if (products != null) {
            for (Product product : products) {
                double newPrice = product.getPrice().doubleValue() * 
                                    (100 + percentage)/100;
                product.setPrice(newPrice);
                productDao.saveProduct(product);
            }
        }
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
}