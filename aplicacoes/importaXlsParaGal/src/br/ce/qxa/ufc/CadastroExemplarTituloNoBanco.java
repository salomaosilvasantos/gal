package br.ce.qxa.ufc;

import java.io.BufferedWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import br.ce.ufc.gal.conexao.ConexaoBanco;
/*
 * Realiza a conexão com o banco e cadastra o exempla ou o titulo diretamente 
 */
public class CadastroExemplarTituloNoBanco {
	
	/*
	 * Retorna o id do exemplar se existir, e se não existir retorna -1
	 */
	public static int retornaIdExemplarBanco(String cod) {
		
		Connection connection;
		String sql = "SELECT id_e FROM exemplares where cod_e = ?";
		int id_e=-1;		
			try {
				connection = ConexaoBanco.AbrirConexao();
				PreparedStatement pstm = connection.prepareStatement(sql);
				pstm.setString(1, cod.replaceAll(" ", ""));
				ResultSet rs = pstm.executeQuery();

				while (rs.next()) {
					id_e= (rs.getInt("id_e"));
					rs.close();
					pstm.close();
					connection.close();
					return id_e;
				}
				rs.close();
				pstm.close();
				connection.close();
			} catch (Exception e) {

				e.printStackTrace();
			}
			
			return id_e;
	}
	
	/*
	 * Cadastra o exempla direto no banco
	 */
	public static String cadastraExemplaresBanco(int id_t, String cod_e){
		
		
		Connection connection;
		String sql = "INSERT INTO exemplares(id_titulo, cod_e) VALUES (?, ?);";
		int id_e = retornaIdExemplarBanco(cod_e);
		if(id_e<0){
			//try {
				try {
					connection = ConexaoBanco.AbrirConexao();
					PreparedStatement pstm = connection.prepareStatement(sql);
					pstm.setInt(1, id_t);
					pstm.setString(2, cod_e);
					pstm.executeUpdate();
					pstm.close();
					connection.close();
				} catch (SQLException e) {
					return "Exemplar não cadastrado: "+e.getMessage();
				} catch (Exception e) {
					return "Exemplar não cadastrado: "+e.getMessage();
				}
				return "Cadastrado com sucesso.";
		}
		return "exemplar já cadastrado";
		
	}
	
	/*
	 * Cadatra titulo direto no banco
	 */
	public static String cadastraTituloBanco(TituloExemplarParaCadastroNoBanco novo){
		
		
		Connection connection;
		
		String sql = "INSERT INTO titulos (isbn, nome_titulo, tipo_titulo) VALUES (?, ?, ?);";
		int id_t = retornaIdTituloBanco(novo.isbn);
		if(id_t<0){
			//try {
				try {
					connection = ConexaoBanco.AbrirConexao();
					PreparedStatement pstm = connection.prepareStatement(sql);
					pstm.setString(1, novo.isbn);
					pstm.setString(2, novo.nomeTitulo);
					pstm.setString(3, "Físico");
					pstm.executeUpdate();
					pstm.close();
					connection.close();
				} catch (SQLException e) {
				return "Isbn "+novo.isbn+" não cadastrado: "+e.getMessage();
				} catch (Exception e) {
					return "Isbn "+novo.isbn+" não cadastrado: "+e.getMessage();
				}
				return "Isbn "+novo.isbn+" cadastrado com sucesso.";
		}
		return "Isbn "+novo.isbn+" já cadastrado";
		
	}
	
	/*
	 * Retorna o id do titulo se existir, se não retorna -1.
	 */
	public static int retornaIdTituloBanco(String isbn) {
		
		Connection connection;
		String sql = "SELECT id_t FROM titulos where isbn = ?";
		int id_t=-1;		
			try {
				connection = ConexaoBanco.AbrirConexao();
				PreparedStatement pstm = connection.prepareStatement(sql);
				pstm.setString(1, isbn.replaceAll(" ", ""));
				ResultSet rs = pstm.executeQuery();

				while (rs.next()) {
					id_t= (rs.getInt("id_t"));
					rs.close();
					pstm.close();
					connection.close();
					return id_t;
				}
				rs.close();
				pstm.close();
				connection.close();
			} catch (Exception e) {

				e.printStackTrace();
			}
			
			return id_t;
	}
	
	/*
	 * Verifica se os titulos da lista já esta cadastrado. Os titulos não cadastrado serão cadastrados. Para titulos cadastrados
	 * serão cadastrados os exemplares dele.
	 * Um log é criado para saber os resultados.
	 */
	public void castrataExemplaresTitulos(List <TituloExemplarParaCadastroNoBanco> tituloExemplaParaCadastro){
		CriaArquivoRelatorio arquivo = new CriaArquivoRelatorio();
		SimpleDateFormat dataformatada = new SimpleDateFormat("_dd_MM_yyyy");
		BufferedWriter Str = arquivo.abreCsvFile("log"+dataformatada.format(new Date())+".txt");
		arquivo.escreveCsvFile(Str, "Cadastro de titulos e Exemplares");
		for (int i = 0; i < tituloExemplaParaCadastro.size(); i++) {
			int id_t = retornaIdTituloBanco(tituloExemplaParaCadastro.get(i).isbn);
			if(id_t<0){
			    String linha = cadastraTituloBanco(tituloExemplaParaCadastro.get(i));
				arquivo.escreveCsvFile(Str, linha);
				
			}
			id_t = retornaIdTituloBanco(tituloExemplaParaCadastro.get(i).isbn);
			if(id_t>0){
				arquivo.escreveCsvFile(Str, "Cadastro dos exemplares do isbn: "+tituloExemplaParaCadastro.get(i).isbn);
				for (int j = 0; j < tituloExemplaParaCadastro.get(i).codExemplares.size(); j++) {
					//System.out.println(tituloExemplaParaCadastro.get(i).codExemplares.get(j));
					String linha = cadastraExemplaresBanco(id_t,tituloExemplaParaCadastro.get(i).codExemplares.get(j));
					arquivo.escreveCsvFile(Str, (j+1)+": "+tituloExemplaParaCadastro.get(i).codExemplares.get(j)+": "+linha);
				}
			}
			
			
		}
		arquivo.fechaCsvFile(Str);
	}
	
	public static void main(String[] args) {
		LerXls x=new LerXls();
		CadastroExemplarTituloNoBanco cadastro =new CadastroExemplarTituloNoBanco();
		cadastro.castrataExemplaresTitulos(x.leMatrizRetornaEstruturaTitulo("Relatório exemplares jul 2014.xls"));
		
	}

}
