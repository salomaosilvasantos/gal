package br.ufc.npi.gal.model;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;


public class ExemplarConflitante {
	@Id
	@Column(name = "id_ef")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Column(name = "cod_ef")	
	private String codigoExemplar;
	
	//campos da tabela
}
