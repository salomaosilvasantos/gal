package ufc.quixada;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;

import br.ce.ufc.gal.conexao.ConexaoBanco;
import br.ufc.gal.pojo.Titulo;
import br.ufc.gal.utilitarios.TituloFactory;

public class ListaTitulos {

	List<Disciplina> disciplinas = new ArrayList<Disciplina>();
	static List<Titulo> titulosBanco = retornaListaTitulosBanco();
	public ListaTitulos() {
		disciplinas = carregarDisciplinas();
	}

	static List<String> titulosComIsbn = new ArrayList<String>();
	static List<String> titulosSemIsbn = new ArrayList<String>();
	
	
	public static void separarTitulosComESemISBN(List<Disciplina> disciplinas) {
		int tituloSemIsbn = 0;
		int tituloComIsbn = 0;
		TreeSet<String> titSemIsbn = new TreeSet<String>();
		TreeSet<String> titComIsbn = new TreeSet<String>();
		
		for (int i = 0; i < disciplinas.size(); i++) {
			for (int j = 0; j < disciplinas.get(i).complementar.size(); j++) {
				if (livroTemISBN(disciplinas.get(i).complementar.get(j))) {
					if(!titComIsbn.contains(disciplinas.get(i).complementar.get(j))){
						if(titSemIsbn.add(disciplinas.get(i).complementar.get(j))) tituloSemIsbn++;
					}
					
				} else {
					if(!titSemIsbn.contains(disciplinas.get(i).complementar.get(j))){
						if(titComIsbn.add(disciplinas.get(i).complementar.get(j))) tituloComIsbn++;
					}
				}
			}
		}

		for (int i = 0; i < disciplinas.size(); i++) {
			for (int j = 0; j < disciplinas.get(i).basica.size(); j++) {
				if (livroTemISBN(disciplinas.get(i).basica.get(j))) {
					if(!titComIsbn.contains(disciplinas.get(i).basica.get(j))){
						if(titSemIsbn.add(disciplinas.get(i).basica.get(j))) tituloSemIsbn++;
					}
					
					
				} else {
					if(!titSemIsbn.contains(disciplinas.get(i).basica.get(j))){
						if(titComIsbn.add(disciplinas.get(i).basica.get(j))) tituloComIsbn++;
					}
					
					
				}
			}
		}
		
		titulosComIsbn = new ArrayList<String>(titComIsbn);
		titulosSemIsbn = new ArrayList<String>(titSemIsbn);
		System.out.println("Títulos com ISBN: " + tituloComIsbn);
		System.out.println("Títulos sem ISBN: " + tituloSemIsbn);
		System.out.println(titulosComIsbn.size());
		System.out.println(titulosSemIsbn.size());
	}
	public static void retiraEspacoTitulosBanco(){
		Connection connection;
		String sql = "SELECT * FROM titulos";
		String isbn, nome_titulo;
		try {
			connection = ConexaoBanco.AbrirConexao();
			PreparedStatement pstm = connection.prepareStatement(sql);
			PreparedStatement pstm2;
			ResultSet rs = pstm.executeQuery();
			while (rs.next()) {
				isbn = (rs.getString("isbn"));
				nome_titulo = (rs.getString("nome_titulo"));

				pstm2 = connection.prepareStatement("UPDATE titulos SET nome_titulo = ? WHERE isbn = ?;");
				pstm2.setString(1, nome_titulo.replace("  ", " "));
				pstm2.setString(2, isbn);

				pstm2.executeUpdate();
				pstm2.close();
			}
			rs.close();
			pstm.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();

		}

	}
	
	public static void cadastraBibliografiaBanco (Disciplina disciplina) {
		int id_d = retornaIdDisciplinaBanco(disciplina);		
		if(id_d<0) {
			cadastraDisciplinaBanco(disciplina);
			id_d = retornaIdDisciplinaBanco(disciplina);
		}
		Titulo titulo;
		Connection connection;
		String sql = "INSERT INTO bibliografias(id_disciplina, id_titulo, tipo_bibliografia) VALUES (?, ?, ?) ;";
		try {
			connection = ConexaoBanco.AbrirConexao();			
			for (int j = 0; j < disciplina.complementar.size(); j++) {
				titulo = TituloFactory.criarTitulo(disciplina.complementar.get(j));
				for (int i = 0; i < titulosBanco.size(); i++) {
					if (titulo.getIsbn().equals(titulosBanco.get(i).getIsbn())) {
						if(!verificaregistroBibliografiaBanco(id_d, titulosBanco.get(i).getId_titulo_pk())){
							PreparedStatement pstm = connection.prepareStatement(sql);
							pstm.setInt(1, id_d);
							pstm.setInt(2, titulosBanco.get(i).getId_titulo_pk());
							pstm.setString(3, "Complementar");
							pstm.executeUpdate();
							pstm.close();
						}
						
					}
					else if(titulo.getNome().equals(titulosBanco.get(i).getNome()))
					{
						if(!verificaregistroBibliografiaBanco(id_d, titulosBanco.get(i).getId_titulo_pk())){
							PreparedStatement pstm = connection.prepareStatement(sql);
							pstm.setInt(1, id_d);
							pstm.setInt(2, titulosBanco.get(i).getId_titulo_pk());
							pstm.setString(3, "Complementar");
							pstm.executeUpdate();
							pstm.close();
						}
					
					}
					
				}	
			}
			for (int j = 0; j < disciplina.basica.size(); j++) {
				titulo = TituloFactory.criarTitulo(disciplina.basica.get(j));
				for (int i = 0; i < titulosBanco.size(); i++) {
					if (titulo.getIsbn().equals(titulosBanco.get(i).getIsbn())) {		
						if(!verificaregistroBibliografiaBanco(id_d, titulosBanco.get(i).getId_titulo_pk())){
							PreparedStatement pstm = connection.prepareStatement(sql);
							pstm.setInt(1, id_d);
							pstm.setInt(2, titulosBanco.get(i).getId_titulo_pk());
							pstm.setString(3, "Básica");
							pstm.executeUpdate();
							pstm.close();
						}
							
					}	
					else if(titulo.getNome().equals(titulosBanco.get(i).getNome())){
						if(!verificaregistroBibliografiaBanco(id_d, titulosBanco.get(i).getId_titulo_pk())){
							PreparedStatement pstm = connection.prepareStatement(sql);
							pstm.setInt(1, id_d);
							pstm.setInt(2, titulosBanco.get(i).getId_titulo_pk());
							pstm.setString(3, "Básica");
							pstm.executeUpdate();
							pstm.close();
						}
						
					}
					
					
				}
			}
			connection.close();
		} catch (Exception e) {
	
			e.printStackTrace();
		}
	   
		
}
	public static void cadastraDisciplinaBanco(Disciplina disciplina){
		
		
		Connection connection;
		String sql = "INSERT INTO disciplinas(cod_d, nome, qtd_alunos, semestre_oferta) VALUES (?, ?, ?, ?);";
		
		
			try {
				connection = ConexaoBanco.AbrirConexao();
				PreparedStatement pstm = connection.prepareStatement(sql);
				pstm.setString(1, disciplina.codigo);
				pstm.setString(2, disciplina.nome.toUpperCase());
				pstm.setInt(3, 50);
				pstm.setInt(4, 8);
				pstm.executeUpdate();
				
				pstm.close();
				connection.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
	}
	public static  boolean verificaregistroBibliografiaBanco(int id_disciplina, int id_titulo) {
		
		Connection connection;
		String sql = "SELECT * FROM bibliografias ";
		int id_d=0,id_t=0;		
			try {
				connection = ConexaoBanco.AbrirConexao();
				PreparedStatement pstm = connection.prepareStatement(sql);
				ResultSet rs = pstm.executeQuery();

				while (rs.next()) {
					id_d = (rs.getInt("id_disciplina"));
					id_t = (rs.getInt("id_titulo"));
					if((id_d==id_disciplina)&&(id_t==id_titulo)){
						rs.close();
						pstm.close();
						connection.close();
						return true;
					}
					
				}
			
				rs.close();
				pstm.close();
				connection.close();
			} catch (Exception e) {

				e.printStackTrace();
			}
			return false;
		
	}
	public static int retornaIdDisciplinaBanco(Disciplina disciplina) {
		
		Connection connection;
		String sql = "SELECT * FROM disciplinas where cod_d = ?";
		int id_d=-1;		
			try {
				connection = ConexaoBanco.AbrirConexao();
				PreparedStatement pstm = connection.prepareStatement(sql);
				pstm.setString(1, disciplina.codigo);
				ResultSet rs = pstm.executeQuery();

				while (rs.next()) {
					id_d = (rs.getInt("id_d"));
					return id_d;
				}
				rs.close();
				pstm.close();
				connection.close();
			} catch (Exception e) {

				e.printStackTrace();
			}
			
			return id_d;
	}
	
	public static List<Titulo> retornaListaTitulosBanco() {
		retiraEspacoTitulosBanco();
		Connection connection;
		String sql = "SELECT * FROM titulos";
		String isbn, nome_titulo, tipo_titulo;
		int id_t;
		List<Titulo> listaTit = new ArrayList<Titulo>();
		
			try {
				connection = ConexaoBanco.AbrirConexao();
				PreparedStatement pstm = connection.prepareStatement(sql);
				ResultSet rs = pstm.executeQuery();
		
				while (rs.next()) {
					isbn = (rs.getString("isbn"));
					nome_titulo = (rs.getString("nome_titulo"));
					tipo_titulo = (rs.getString("tipo_titulo"));
					id_t = (rs.getInt("id_t"));
					Titulo tit = new Titulo();
					tit.setId_titulo_pk(id_t);
					tit.setIsbn(isbn);
					tit.setNome(nome_titulo);
					tit.setTipo(tipo_titulo);
					listaTit.add(tit);
				}
				rs.close();
				pstm.close();
				connection.close();
			} catch (Exception e) {
	
				e.printStackTrace();
			}
			return listaTit;			
			
	}
	
	
	public List<Disciplina> getDisciplinas() {
		return disciplinas;
	}

	public static List<String> getTitulosComIsbn() {
		return titulosComIsbn;
	}

	public static List<String> getTitulosSemIsbn() {
		return titulosSemIsbn;
	}

	public void listar() {
//		ParseTitulos parseTitulos = new ParseTitulos();
//		System.out.println("\n\n**************************************************************************");
//		System.out.println("Títulos com ISBN com dados no formato próprio para o match com o banco\n\n");
//		List<Titulo> titulosComIsbn2 = parseTitulos.ler(titulosComIsbn);
//		System.out.println("\n\n**************************************************************************");
//		System.out.println("Títulos sem ISBN com dados no formato próprio para o match com o banco\n\n");
//		List<Titulo> titulosSemIsbn2 = parseTitulos.ler(titulosSemIsbn);
//		System.out.println("**************************************************************************");
//	//	temIsbn(titulosComIsbn2, titulosSemIsbn2);
//		System.out.println(titulosSemIsbn2.size());
	}
	
	

	private static boolean livroTemISBN(String titulo) {
		if (titulo.toLowerCase().contains("isbn"))
			return false;
		else
			return true;
	}
	
	public static List<Disciplina> carregarDisciplinas(){
		File[] lista;
		// old = File folder = new
		// File("/home/camilo/projetos/persistencia/ExtracaoDadosProgramasDisciplinas/res/formatados/xml");
		File folder = new File("res/formatados/xml");
		// Carregando os caminhos dos arquivos.
		lista = folder.listFiles();

		List<Disciplina> disciplinas = new ArrayList<Disciplina>();

		for (int i = 0; i < lista.length; i++) {
			// Excluindo os diretórios...
			if (lista[i].isFile()) {
				ProgramaDOCHandler app = new ProgramaDOCHandler();
				// Envio para parse.
				app.executar(lista[i].getAbsolutePath());

				// Remove as inconsistencias das bibliografias de cada
				// disciplina.
				app.disc.biblioOrder();

				// Adicionar as disciplinas na lista. :)
				disciplinas.add(app.disc);
			
			}
		}
		
		
		//disciplinas =  aux.lerDisciplina(disciplinas);
		return disciplinas;
	}

}
