package com.companyname.springapp.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/*
 * A função do serializable � preparar objectos para estes serem escritos para um ficheiro.
 *  Entre outras coisas, penso que o principal � acrescentar uma especie de numero de serie 
 *  aos objectos no ficheiro, para o java saber que classe os criou. Se por algum motivo 
 *  escreves um ficheiro de objectos e alteras a classe que os criou, quando os voltares a 
 *  tentar ler vai dar uma exep�ao em que refere que a versao � diferente.
 * 
 * 
 * JPA Mapeamento de Entidades
 * 
 * @Entity : Define que a classe é uma entidade persistente e será mapeada para uma tabela do banco
 * @Table: Define a tabela da entidade. Opcional (padrão = nome da Classe)
 * @Column: Mapeia o atributo para uma coluna da tabela, o "name" identifica o nome da coluna. Opcional (padrão = nome do atributo)
 * @Id: Identifica o atributo/coluna que é a chave primária da entidade. Caso o nome da coluna seja diferente deve-se usar
 * o @Column conjuntamente para identificar a coluna
 * @GenerateValue: Define que o valor do campo é gerado automaticamente pelo banco
 * */

@Entity
@Table(name="products") 
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    private String description;
    private Double price;
    
    public Integer getId()
    {
        return id;
    }

    public void setId(Integer id)
    {
        this.id = id;
    } 

    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public Double getPrice() {
        return price;
    }
    
    public void setPrice(Double price) {
        this.price = price;
    }
    
    public String toString() {
        StringBuffer buffer = new StringBuffer();
        buffer.append("Description: " + description + ";");
        buffer.append("Price: " + price);
        return buffer.toString();
    }
}