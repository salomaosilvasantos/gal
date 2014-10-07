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
	@ManyToOne
	@JoinColumn(name = "id_curriculo")
	private EstruturaCurricular estruturaCurricular;
	@Id
	@ManyToOne
	@JoinColumn(name = "id_disciplina")
	private Disciplina disciplina;

	@Column(name = "qtd_alunos")
	private Integer quantidadeAlunos;

	@Column(name = "semestre_oferta")
	private Integer semestreOferta;
	
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
		return "IntegracaoCurricular [estruturaCurricular="
				+ estruturaCurricular + ", disciplina=" + disciplina
				+ ", quantidadeAlunos=" + quantidadeAlunos
				+ ", semestreOferta=" + semestreOferta + "]";
	}

}
