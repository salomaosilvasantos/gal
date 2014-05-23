package br.ufc.npi.gal.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="integracao_curricular")
@IdClass(IntegracaoCurricularId.class)
public class IntegracaoCurricular{
	@Id
	  @Column(name="id_disciplina",insertable=false,
	                         updatable=false)
	private Integer idDisciplina;
	
	@Id
	  @Column(name="id_curriculo",insertable=false,
	                         updatable=false)
	private Integer idEstruturaCurricular;
	
	@ManyToOne
	  @JoinColumn(name="id_curriculo")
	private EstruturaCurricular estruturaCurricular;
	@ManyToOne
	  @JoinColumn(name="id_disciplina")
	private Disciplina disciplina;
	
	@Column(name="qtd_alunos")
	private Integer quantidadeAlunos;
	
	@Column(name="semestre_oferta")
	private Integer semestreOferta;

	public Integer getIdDisciplina() {
		return idDisciplina;
	}

	public void setIdDisciplina(Integer idDisciplina) {
		this.idDisciplina = idDisciplina;
	}

	public Integer getIdEstruturaCurricular() {
		return idEstruturaCurricular;
	}

	public void setIdEstruturaCurricular(Integer idEstruturaCurricular) {
		this.idEstruturaCurricular = idEstruturaCurricular;
	}

	public EstruturaCurricular getEstruturaCurricular() {
		return estruturaCurricular;
	}

	public void setEstruturaCurricular(EstruturaCurricular estruturaCurricular) {
		this.estruturaCurricular = estruturaCurricular;
	}

	public Disciplina getDisciplina() {
		return disciplina;
	}

	public void setDisciplina(Disciplina disciplina) {
		this.disciplina = disciplina;
	}

	public Integer getQuantidadeAlunos() {
		return quantidadeAlunos;
	}

	public void setQuantidadeAlunos(Integer quantidadeAlunos) {
		this.quantidadeAlunos = quantidadeAlunos;
	}

	public Integer getSemestreOferta() {
		return semestreOferta;
	}

	public void setSemestreOferta(Integer semestreOferta) {
		this.semestreOferta = semestreOferta;
	}
	
	
	
}
