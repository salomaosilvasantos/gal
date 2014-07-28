package br.ufc.npi.gal.enumeration;

public enum TipoTitulo {
	
	FISICO("Físico"), VIRTUAL("Virtual");
	
	private String descricao;
	
	private TipoTitulo(String descricao) {
		this.descricao = descricao;
	}
	
	public String getDescricao() {
		return this.descricao;
	}

}
