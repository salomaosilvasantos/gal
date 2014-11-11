package br.ufc.quixada.parse;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import ufc.quixada.ListaTitulos;
import br.ufc.gal.conexao.SingleConnection;
import br.ufc.gal.dao.TituloDAO;
import br.ufc.gal.pojo.Titulo;
import br.ufc.gal.relatorio.RelatorioFalha;
import br.ufc.gal.utilitarios.TituloFactory;

public class ParseAllFromDocs {
	
//	private FileReader cvs;
	private ParseTitulos parseTitulo;
	private Connection conexao;
	private List<Titulo> titulos;
	
	public ParseAllFromDocs() {
		//this.url = "fontes/CSV_fonte";
		this.conexao = SingleConnection.getInstance().conectar();
	}
	
	public ParseAllFromDocs(String url){
	}
	
	public void persistir(){
		//selecionarCVS();
		parseTitulo();
		persistirTitulo();
		setTituloID(titulos);
		//persistirExemplares();
		
	}
	
//	private void selecionarCVS(){
//		try {
//			cvs = new FileReader(url);
//		} catch (FileNotFoundException e) {
//		
//			e.printStackTrace();
//		}
//	}
	
	private void parseTitulo(){
		parseTitulo = new ParseTitulos();
		titulos = parseTitulo.ler(ListaTitulos.getTitulosComIsbn());
		
		
	}
	

	private void persistirTitulo() {
		for (Titulo titulo : titulos) {
			try {
				if (titulo.getNome().length() < 5) {
					TituloFactory.titulosComFalha.add(titulo);
					String texto = "\n\n";
					texto += "Nome Inconsistente:  ";
					texto += titulo.getNome();
					texto += "\nISBN:  ";
					texto += titulo.getIsbn();
					RelatorioFalha.gravar(texto);
				}else {
					TituloDAO.cadastra(conexao, titulo);
				}
			} catch (SQLException e) {
				TituloFactory.titulosComFalha.add(titulo);
				String texto = "\n\n";
				texto += "ISBN ja cadastrado:  ";
				texto += titulo.getIsbn();
				texto += "\nTitulo: ";
				texto += titulo.getNome();
				texto += "\nExemplares " + titulo.getCodigo_exemplar().size() + ": ";
				for (String codigo : titulo.getCodigo_exemplar()) {
					texto += codigo + ", ";
				}
				RelatorioFalha.gravar(texto);				
				//e.printStackTrace();
			}
		}
	}
	
	//Ler o banco e atualizar a lista de titulos.
	private void setTituloID(List<Titulo> titulos2) {
		
		List<Titulo> aux = TituloDAO.listarTodos(conexao);
		
		for (Titulo titulo : aux) {
			for (Titulo titulo2 : titulos) {
				if (titulo.getIsbn().equals(titulo2.getIsbn())) {
					titulo.setCodigo_exemplar(titulo2.getCodigo_exemplar());
				}
			}			
		}
		
		titulos = aux;
	}

	//Cadastrar os exemplares no banco.
//	private void persistirExemplares() {
//		for (Titulo titulo : titulos) {
//			try {
//				ExemplarDAO.cadastra(conexao, titulo);
//			} catch (SQLException e) {
//		
//				e.printStackTrace();
//			}
//		}
//	}
}
