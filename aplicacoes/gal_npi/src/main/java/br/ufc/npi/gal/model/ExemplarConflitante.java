package br.ufc.npi.gal.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

@Entity

@Table(name = "exemplarConflitante",
uniqueConstraints={@UniqueConstraint(columnNames="cod_ef")})

public class ExemplarConflitante {
	
	@Id
	@Column(name = "id_ef")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Column(unique = true ,name = "cod_ef")	
	private String codigoExemplar;
	
	@Column(name = "linhaErro")
	private int linha;
	
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
	private String descricaoErro;
	
	
	public String getDescricaoErro() {
		return descricaoErro;
	}

	public void setDescricaoErro(String descricaoErro) {
		this.descricaoErro = descricaoErro;
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
	
	public int getLinha() {
		return linha;
	}

	public void setLinha(int linha) {
		this.linha = linha;
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
