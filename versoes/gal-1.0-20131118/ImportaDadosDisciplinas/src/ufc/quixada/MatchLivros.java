package ufc.quixada;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.ce.ufc.gal.conexao.ConexaoBanco;
import br.ufc.gal.pojo.Titulo;
import br.ufc.quixada.parse.ParseTitulos;

public class MatchLivros {

	/**
	 * @param args
	 */

	public static void main(String[] args) {

		try {
			Connection conexao = ConexaoBanco.AbrirConexao();

			if (conexao != null) {
				System.out.println("Conexão bem sucedida");
			}

		} catch (Exception e) {
			System.out.println("Erro: " + e.getMessage());
		}

		testeListarTítulos();
		//matchTitulos();

	}

	public static void testeListarTítulos() {
		Connection connection;
		String sql = "SELECT * FROM titulos";
		String isbn, nome_titulo, tipo_titulo;
		// JSONArray arrayObj = new JSONArray();

		try {
			connection = ConexaoBanco.AbrirConexao();
			PreparedStatement pstm = connection.prepareStatement(sql);
			PreparedStatement pstm2;
			ResultSet rs = pstm.executeQuery();
			while (rs.next()) {
				List<String> titulos = new ArrayList<String>();
				isbn = (rs.getString("isbn"));
				nome_titulo = (rs.getString("nome_titulo").replaceAll("[ ]+", " "));
				tipo_titulo = (rs.getString("tipo_titulo"));
				titulos.add(isbn);
				titulos.add(nome_titulo);
				titulos.add(tipo_titulo);

				// String str2 = "UPDATE titulos SET nome_titulo ="
				// +nome_titulo.replace(" ", "")+" WHERE isbn ="+ isbn+";";
				pstm2 = connection
						.prepareStatement("UPDATE titulos SET nome_titulo = ? WHERE isbn = ?;");
				pstm2.setString(1, nome_titulo.replaceAll("[ ]+", " "));
				pstm2.setString(2, isbn);

				pstm2.executeUpdate();
				System.out.println(nome_titulo);
				// arrayObj.put(titulos);
				// rs2.close();
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

	public static void matchTitulos() {

		List<Disciplina> disciplinas = ListaTitulos.carregarDisciplinas();
		
		ParseTitulos parseTitulos = new ParseTitulos();
		
		
		ListaTitulos.separarTitulosComESemISBN(disciplinas);

		List<String> titulosComIsbn = ListaTitulos.getTitulosComIsbn();
		List<String> titulosSemIsbn = ListaTitulos.getTitulosSemIsbn();

		List<Titulo> titulosComIsbnFormatados = parseTitulos
				.ler(titulosComIsbn);
		List<Titulo> titulosSemIsbnFormatados = parseTitulos
				.ler(titulosSemIsbn);
		temIsbn(titulosComIsbnFormatados, titulosSemIsbnFormatados);
		Connection connection;
		String sql = "SELECT * FROM titulos";
		String isbn, nome_titulo, tipo_titulo;
		int id_t;
		List<Titulo> listaTit = new ArrayList<Titulo>();
		try {
			connection = ConexaoBanco.AbrirConexao();
			PreparedStatement pstm = connection.prepareStatement(sql);
			PreparedStatement pstm2;
			ResultSet rs = pstm.executeQuery();
	
			int titulosCadastrados = 0;

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
				
				//System.out.println(nome_titulo);
				

				for (int i = 0; i < titulosComIsbnFormatados.size(); i++) {
					if(isbn!=null){
						if (titulosComIsbnFormatados.get(i).getIsbn().equalsIgnoreCase(isbn.replace(" ", ""))||
								titulosComIsbnFormatados.get(i).getIsbn().toLowerCase().contains(isbn.replace(" ", "").toLowerCase())||
								isbn.replace(" ", "").toLowerCase().contains(titulosComIsbnFormatados.get(i).getIsbn().toLowerCase())) 
						{
							titulosCadastrados++;
//							System.out.println("Título: "+ titulosCadastrados+ ":  "	+ titulosComIsbnFormatados.get(i).getNome()
//									+ " já cadastrado no banco.");
							titulosComIsbnFormatados.remove(i);
							continue;
						}
						
					}
				}
			}
			for (int i = 0; i < titulosComIsbnFormatados.size(); i++) {
			//	System.out.println("Titulo "+i+":  "+titulosComIsbnFormatados.get(i).getIsbn()+" "+titulosComIsbnFormatados.get(i).getNome());
				pstm2 = connection.prepareStatement("INSERT INTO titulos(isbn, nome_titulo, tipo_titulo) VALUES (?, ?, ?);");
				pstm2.setString(1,titulosComIsbnFormatados.get(i).getIsbn().replace(" ", ""));
				pstm2.setString(2, titulosComIsbnFormatados.get(i).getNome().replace(" ", ""));
				pstm2.setString(3, titulosComIsbnFormatados.get(i).getTipo().replace(" ", ""));
				pstm2.executeUpdate();
				
				
			}
			rs.close();
			pstm.close();
			connection.close();
			System.out.println(titulosCadastrados);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();

		}
		for (int i = 0; i < disciplinas.size(); i++) 
		{
			ListaTitulos.cadastraBibliografiaBanco(disciplinas.get(i));
		}
	}

	public static void temIsbn(List<Titulo> titulosComIsbn2,
			List<Titulo> titulosSemIsbn2) {
		
		List<Titulo> titulos = new ArrayList<Titulo>();

		for (int i = 0; i < titulosComIsbn2.size(); i++) {
			//System.out.println(i+ " "+ titulosComIsbn2.get(i).getNome());
			//System.out.println(titulosComIsbn2.get(i).getNome());
			for (int j = 0; j < titulosSemIsbn2.size(); j++) {
			
				if (titulosComIsbn2.get(i).getNome().contains(",")) {
					int fimNome = titulosComIsbn2.get(i).getNome().indexOf(",");
					
					if(titulosSemIsbn2.get(j).getNome().contains(titulosComIsbn2.get(i).getNome().substring(0, fimNome))){
					//	System.out.println(titulosSemIsbn2.get(j).getNome());
						titulos.add(titulosSemIsbn2.remove(j));
					}
				
				}
			}
		}
		System.out.println("Titulos sem isbn: "+ titulosSemIsbn2.size());
	}
}
