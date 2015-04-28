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
	@Column(name = "id_ad")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Temporal(TemporalType.DATE)
	private Date inicioPeridoDelta;

	@Temporal(TemporalType.DATE)
	private Date finalPeridoDelta;

	@Type(type = "org.hibernate.type.BinaryType")
	private byte[] arquivo;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getFinalPeridoDelta() {
		return finalPeridoDelta;
	}

	public Date getInicioPeridoDelta() {
		return inicioPeridoDelta;
	}

	public void setInicioPeridoDelta(Date inicioPeridoDelta) {
		this.inicioPeridoDelta = inicioPeridoDelta;
	}

	public void setFinalPeridoDelta(Date finalPeridoDelta) {
		this.finalPeridoDelta = finalPeridoDelta;
	}

	public byte[] getArquivo() {
		return arquivo;
	}

	public void setArquivo(byte[] arquivo) {
		this.arquivo = arquivo;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj instanceof AcervoDocumento) {
			AcervoDocumento other = (AcervoDocumento) obj;
			if (other != null && other.getId() != null && this.id != null
					&& other.getId().equals(this.id)) {
				return true;
			}
		}
		return false;
	}

}