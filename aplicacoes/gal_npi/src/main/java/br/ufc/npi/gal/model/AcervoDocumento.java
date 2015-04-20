package br.ufc.npi.gal.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Type;


@Entity

@Table(name = "AcervoDocumento")
public class AcervoDocumento {
	
	@Id
	@Column(name = "id_ef")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Temporal(TemporalType.DATE)
	private Date dataEntrada;
	
	@Temporal(TemporalType.DATE)
	private Date dataValidade;
	
	@Type(type="org.hibernate.type.BinaryType")
	private byte[] arquivo;
	
	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public Date getDataEntrada() {
		return dataEntrada;
	}


	public void setDataEntrada(Date dataEntrada) {
		this.dataEntrada = dataEntrada;
	}


	public Date getDataValidade() {
		return dataValidade;
	}


	public void setDataValidade(Date dataValidade) {
		this.dataValidade = dataValidade;
	}


	public byte[] getArquivo() {
		return arquivo;
	}


	public void setArquivo(byte[] arquivo) {
		this.arquivo = arquivo;
	}
	
	
	@Override
	public boolean equals(Object obj) {
		if(obj instanceof AcervoDocumento) {
			AcervoDocumento other = (AcervoDocumento) obj;
			if (other != null && other.getId() != null && this.id != null && other.getId().equals(this.id)) {
				return true;
			}
		}
		return false;
	}
	

}
