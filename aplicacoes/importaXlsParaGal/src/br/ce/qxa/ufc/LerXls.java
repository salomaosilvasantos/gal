package br.ce.qxa.ufc;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

import jxl.Sheet;
import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.read.biff.BiffException;

public class LerXls {
	String[][] xlsLido;
	int colunas;
	int linhas;
	
	/*
	 * Lê arquivo do tipo *.xls retornando uma matriz dos dados das celulas
	 */
	public String[][] leXlsRetornaMatriz(String arquivoXls){
		Workbook workbook;
		xlsLido=null;
		try{
			WorkbookSettings configuracao =new WorkbookSettings();
			configuracao.setEncoding("Cp1252");
			workbook = Workbook.getWorkbook(new File(arquivoXls),configuracao);
			
			Sheet sheet = workbook.getSheet(0);
			colunas=sheet.getColumns();
			linhas=sheet.getRows();
			xlsLido = new String[colunas][linhas];
			for(int i = 0; i < linhas; i++){
				for (int j = 0; j < colunas; j++) {
					xlsLido[j][i]=sheet.getCell(j, i).getContents();

					
				}
			}
		workbook.close();	
		} catch (BiffException e) {

			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		}
		return xlsLido;
		
	}
	
	/*
	 * Formata uma string retirando dela tudo que for diferente de numero
	 * \\. retira todos os pontos
	 * ISBN retira o nome isbn que vem na celula
	 * \\(.+ retira tudo que vem depois que um parentese é aberto.
	 * (v1) retura todos os v1 que encontra
	 * \\s retira espaços
	 */
	public String formataIsbn(String isbn) {
		
		isbn = isbn.replaceAll("\\.", "");
		isbn = isbn.replaceAll("ISBN", "");
		isbn = isbn.replaceAll("\\(.+", "");
		isbn = isbn.replaceAll("(v1)", "");
		isbn = isbn.replaceAll("(v2)", "");
		isbn = isbn.replaceAll("\\s+", "");
		isbn = isbn.replaceAll(" ", "");
		
		
		return isbn;
	}
	
	/*
	 * Le a matriz e a transforma em uma estrutura com nome do titulo, isbn e uma lista de codigos de exemplares
	 * Os numeros que aparecem como o 45 é considerando que o isbn encontra-se na coluna 45, 2 é considerendo que 
	 * o codigo de exemplares estão na coluna 2, e os numeros de 36 a 43 são as colunas necessarias para formar o titulo. 
	 * 
	 */
	public  List <TituloExemplarParaCadastroNoBanco> leMatrizRetornaEstruturaTitulo(String arquivo) {
		
		List <TituloExemplarParaCadastroNoBanco> novo = new ArrayList<TituloExemplarParaCadastroNoBanco>();
		String[][] teste = this.leXlsRetornaMatriz(arquivo);
		for(int i = 1; i < this.linhas; i++){
				Boolean isbnConhecido=false;
				String isbn = new String(this.formataIsbn(teste[45][i]));
				for (int j2 = 0; j2 < novo.size(); j2++) {
					if (isbn.equals(novo.get(j2).isbn)){
						novo.get(j2).codExemplares.add(teste[2][i]);
						
						isbnConhecido=true;
					}
					
				}
				if(!isbnConhecido) {
					TituloExemplarParaCadastroNoBanco outro= new TituloExemplarParaCadastroNoBanco();
					outro.isbn= new String(isbn) ;
					outro.codExemplares = new ArrayList<String>();
					outro.codExemplares.add(teste[2][i]);
					outro.nomeTitulo=new String(teste[36][i]+teste[37][i]+teste[38][i]+teste[39][i]+teste[40][i]+teste[41][i]+teste[42][i]+teste[43][i]);
					novo.add(outro);
				}

		}
		return novo;
	}
	
	public static void main(String[] args) {
		LerXls x=new LerXls();
		JFileChooser janela = new JFileChooser();
        janela.setFileSelectionMode(JFileChooser.FILES_AND_DIRECTORIES);
        JOptionPane.showMessageDialog(null, "Selecione o arquivo para atualiza o banco."); 
        int res = janela.showOpenDialog(null);
        
        if(res == JFileChooser.APPROVE_OPTION){
            File diretorio = janela.getSelectedFile();
            try {
        		x.leMatrizRetornaEstruturaTitulo(diretorio.getCanonicalPath());
				JOptionPane.showMessageDialog(null, "Voce escolheu o diretório: " + diretorio.getCanonicalPath());
			} catch (Exception e) {
				JOptionPane.showMessageDialog(null, "Erro ao preencher o banco. Erro: "+ e.getMessage());
			}
        }
        else JOptionPane.showMessageDialog(null, "Voce nao selecionou nenhum diretorio."); 
 


	}

}