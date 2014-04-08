package br.ufc.npi.gal.parse;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.ufc.npi.gal.conexao.Conexao;
import br.ufc.npi.gal.dao.ExemplarDAO;
import br.ufc.npi.gal.dao.TituloDAO;
import br.ufc.npi.gal.pojo.Titulo;
import br.ufc.npi.gal.utilitarios.RelatorioFalha;

public class ParseCompleto {

	private String urlArquivo;
	private FileReader arquivo;
	private Connection conexao;
	private List<Titulo> titulosConsistentes;
	private List<Titulo> titulosInconsistentes;
	private List<Titulo> titulosIsbnRepetidos;
	private List<Titulo> titulosPersistidos;
	
	
	public ParseCompleto() {
		this.urlArquivo = "fontes/CSV_fonte";
		
		this.titulosConsistentes = new ArrayList<Titulo>();
		this.titulosInconsistentes = new ArrayList<Titulo>();
		this.titulosIsbnRepetidos = new ArrayList<Titulo>();
		this.titulosPersistidos = new ArrayList<Titulo>();
		
		try {
			this.conexao = Conexao.getInstance().conectar();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		lerCSV();
	}

	public void persistir(){
		persistirTitulo();
		atualizarIdTitulos();
		persistirExemplar();
		
		gerarRelatorio();
	}


	private void lerCSV(){
		
		selecionarCSV();
		
		LeitorCSV leitor = new LeitorCSV(arquivo);
		
		try {
			leitor.ler();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		titulosConsistentes = leitor.getTitulosConsistentes();
		titulosInconsistentes = leitor.getTitulosInconsistentes();
	}
	
	private void selecionarCSV(){
		try {
			arquivo = new FileReader(urlArquivo);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	private void persistirTitulo() {
		
		for (Titulo titulo : titulosConsistentes) {
			boolean sucess = false;
			try {
				sucess = TituloDAO.cadastrar(titulo, conexao);
				if (sucess) {
					titulosPersistidos.add(titulo);
				}
			} catch (SQLException e) {
				titulosIsbnRepetidos.add(titulo);
			}
		}
	}
	
	private void atualizarIdTitulos() {
		List<Titulo> titulosBanco = new ArrayList<Titulo>();
		try {
			titulosBanco = TituloDAO.listar(conexao);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		for (Titulo titulo : titulosBanco) {
			int index = titulosPersistidos.indexOf(titulo);
			if (index >= 0) {
				titulosPersistidos.get(index).setId_titulo_pk(titulo.getId_titulo_pk());
			} 
		}
	}
	
	private void persistirExemplar() {
		
		for (Titulo titulo : titulosPersistidos) {
			try {
				ExemplarDAO.cadastrar(titulo, conexao);
			} catch (SQLException e) {

				e.printStackTrace();
			}
		}
	}
	

	private void gerarRelatorio() {
		
		log("Titulo Inconsistente--> ", titulosInconsistentes);
		log("Titulo com ISBN repetito--> ", titulosIsbnRepetidos);
	}
	
	private void log(String caso, List<Titulo> lista) {

		String log = "";
		int qtd_exemplares;
		for (Titulo titulo : lista) {
			qtd_exemplares = titulo.getCodigo_exemplar().size();
			
			log += caso;
			log += "ISBN : " + titulo.getIsbn();
			log += "\nNome: " + titulo.getNome();
			log += "\nExemplares : " + qtd_exemplares + " : ";
			log += "Codigos ";
			for (String codigo : titulo.getCodigo_exemplar()) {
				log += ": " + codigo;
			}
			log += "\n\n";
			
			RelatorioFalha.gravar(log);
		}
	}
}
