package com.companyname.springapp.repository;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.companyname.springapp.domain.Product;

/*
 * obs: de modo geral o JAVA possui uma anotaçao chamada @Named que serve tambem para fazer a injeçao de dependecia,
 * pode servir como alternativa para utilizar as anotaçoes do spring
 * 
 * */

@Repository(value = "productDao")
public class JPAProductDao implements ProductDao {

    private EntityManager em = null;

    //etiqueta do spring utiliza para carregar o objeto EntityManager responsável por fazer
  	//as operações com as entities
    @PersistenceContext
    public void setEntityManager(EntityManager em) {
        this.em = em;
    }

  //etiqueta do spring responsável por representar os métodos que realizarão operações na base de dados
    @Transactional(readOnly = true)
    @SuppressWarnings("unchecked")
    public List<Product> getProductList() {
        return em.createQuery("select p from Product p order by p.id").getResultList();
    }

    @Transactional(readOnly = false)
    public void saveProduct(Product prod) {
        em.merge(prod);
    }

}