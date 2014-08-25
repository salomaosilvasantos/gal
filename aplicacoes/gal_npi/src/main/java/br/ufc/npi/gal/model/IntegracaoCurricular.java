package br.ufc.npi.gal.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Table(name = "integracao_curricular")
@IdClass(IntegracaoCurricularId.class)
public class IntegracaoCurricular {
	@Id
	@Column(name = "id_disciplina", insertable = false, updatable = false)
	private Integer id_disciplina;

	@Id
	@Column(name = "id_curriculo", insertable = false, updatable = false)
	private Integer id_curriculo;

	@ManyToOne
	@JoinColumn(name = "id_curriculo")
	@PrimaryKeyJoinColumn(name = "id_curriculo", referencedColumnName = "id_curriculo")
	private EstruturaCurricular estruturaCurricular;
	@ManyToOne
	@JoinColumn(name = "id_disciplina")
	@PrimaryKeyJoinColumn(name = "id_disciplina", referencedColumnName = "id_disciplina")
	private Disciplina disciplina;

	@Column(name = "qtd_alunos")
	private Integer quantidadeAlunos;

	@Column(name = "semestre_oferta")
	private Integer semestreOferta;

	public Integer getId_disciplina() {
		return id_disciplina;
	}

	public void setId_disciplina(Integer id_disciplina) {
		this.id_disciplina = id_disciplina;
	}

	public Integer getId_curriculo() {
		return id_curriculo;
	}

	public void setId_curriculo(Integer id_curriculo) {
		this.id_curriculo = id_curriculo;
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
	

	@Override
	public String toString() {
		return "IntegracaoCurricular [id_disciplina=" + id_disciplina
				+ ", id_curriculo=" + id_curriculo + ", estruturaCurricular="
				+ estruturaCurricular + ", disciplina=" + disciplina
				+ ", quantidadeAlunos=" + quantidadeAlunos
				+ ", semestreOferta=" + semestreOferta + "]";
	}

}
