package br.ufc.npi.gal.model;

public class DetalheMetaCalculada {

	private String disciplina;
	private String curso;
	private String tipoBibliografia;
	private String curriculo;
	private String calculo;

	public String getDisciplina() {
		return disciplina;
	}

	public void setDisciplina(String disciplina) {
		this.disciplina = disciplina;
	}

	public String getCurso() {
		return curso;
	}

	public void setCurso(String curso) {
		this.curso = curso;
	}

	public String getTipoBibliografia() {
		return tipoBibliografia;
	}

	public void setTipoBibliografia(String tipoBibliografia) {
		this.tipoBibliografia = tipoBibliografia;
	}

	public String getCurriculo() {
		return curriculo;
	}

	public void setCurriculo(String curriculo) {
		this.curriculo = curriculo;
	}

	public String getCalculo() {
		return calculo;
	}

	public void setCalculo(String calculo) {
		this.calculo = calculo;
	}

	@Override
	public String toString() {
		return "DetalheMetaCalculadaPar [disciplina=" + disciplina + ", curso="
				+ curso + ", tipoBibliografia=" + tipoBibliografia
				+ ", curriculo=" + curriculo + ", calculo=" + calculo + "]";
	}

}
