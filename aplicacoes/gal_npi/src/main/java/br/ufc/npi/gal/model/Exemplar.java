package br.ufc.npi.gal.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "exemplares")
public class Exemplar {

	@Id
	@Column(name = "id_e")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@ManyToOne
	@JoinColumn(name = "id_titulo")
	private Titulo titulo;

	@Column(name = "cod_e")
	private String codigoExemplar;
	
	public Titulo getTitulo() {
		return titulo;
	}

	public void setTitulo(Titulo titulo) {
		this.titulo = titulo;
	}

	public String getCodigoExemplar() {
		return codigoExemplar;
	}

	public void setCodigoExemplar(String codigoExemplar) {
		this.codigoExemplar = codigoExemplar;
	}
    
	
}
