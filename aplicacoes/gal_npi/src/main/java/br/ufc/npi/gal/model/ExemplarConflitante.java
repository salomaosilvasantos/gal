package br.ufc.npi.gal.model;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;


public class ExemplarConflitante {
	//campos da tabela
	@Id
	@Column(name = "id_ef")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(name = "cod_ef")	
	private String codigoExemplar;
	
	@Column(name = "tipo")
	private String tipo;
	
	@Column(name = "isbn")
	private String isbn;
	
	@Column(name = "autor")
	private String autor;
	
	@Column(name = "titulo")
	private String titulo;
	
	@Column(name = "titulo_n")
	private String titulo_n;
	
	@Column(name = "sub_titulo")
	private String subTitulo;
	
	@Column(name = "titulo_revista")
	private String tituloRevista;
	
	@Column(name = "pagina")
	private String pagina;
	
	@Column(name = "ref_artigo")
	private String refArtigo;
	
	@Column(name = "edicao")
	private String edicao;
	
	@Column(name = "publicador")
	private String publicador;
	
	@Column(name = "discricao_erro")
	private String discricaoErro;
	
	
	public String getDiscricaoErro() {
		return discricaoErro;
	}

	public void setDiscricaoErro(String discricaoErro) {
		this.discricaoErro = discricaoErro;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCodigoExemplar() {
		return codigoExemplar;
	}

	public void setCodigoExemplar(String codigoExemplar) {
		this.codigoExemplar = codigoExemplar;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getIsbn() {
		return isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}

	public String getAutor() {
		return autor;
	}

	public void setAutor(String autor) {
		this.autor = autor;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getTitulo_n() {
		return titulo_n;
	}

	public void setTitulo_n(String titulo_n) {
		this.titulo_n = titulo_n;
	}

	public String getSubTitulo() {
		return subTitulo;
	}

	public void setSubTitulo(String subTitulo) {
		this.subTitulo = subTitulo;
	}

	public String getTituloRevista() {
		return tituloRevista;
	}

	public void setTituloRevista(String tituloRevista) {
		this.tituloRevista = tituloRevista;
	}

	public String getPagina() {
		return pagina;
	}

	public void setPagina(String pagina) {
		this.pagina = pagina;
	}

	public String getRefArtigo() {
		return refArtigo;
	}

	public void setRefArtigo(String refArtigo) {
		this.refArtigo = refArtigo;
	}

	public String getEdicao() {
		return edicao;
	}

	public void setEdicao(String edicao) {
		this.edicao = edicao;
	}

	public String getPublicador() {
		return publicador;
	}

	public void setPublicador(String publicador) {
		this.publicador = publicador;
	}
}
