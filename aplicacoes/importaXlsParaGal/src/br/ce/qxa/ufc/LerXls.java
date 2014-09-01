package br.ce.qxa.ufc;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jxl.Cell;
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
		try {
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
					//System.out.println("cel"+i+":"+j+": "+sheet.getCell(j, i).getContents());
					
				}
			}
		workbook.close();	
		} catch (BiffException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return xlsLido;
		
	}
	
	/*
	 * Formata uma string retirando dela tudo que for diferente de numero
	 */
	public String formataIsbn(String isbn) {
		String isbnFormatada = isbn.replaceAll("\\D", "");
		return isbnFormatada;
	}
	
	/*
	 * Le a matriz e a transforma em uma estrutura com nome do titulo, isbn e uma lista de codigos de exemplares
	 */
	public  List <TituloExemplarParaCadastroNoBanco> leMatrizRetornaEstruturaTitulo(String arquivo) {
		
		List <TituloExemplarParaCadastroNoBanco> novo = new ArrayList<TituloExemplarParaCadastroNoBanco>();
		String[][] teste = this.leXlsRetornaMatriz(arquivo);
		for(int i = 1; i < this.linhas; i++){
			//for (int j = 0; j < this.colunas; j++) {
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
//					System.out.println(novo.size()+": "+ outro.nomeTitulo);
//					System.out.println("ISBN: "+outro.isbn);
//					System.out.println("COD_EXEMPLAR: "+teste[2][i]);
				}
				//System.out.println("cel"+i+":"+j+": "+sheet.getCell(j, i).getContents());
				
		//	}
		}
		return novo;
	}
	
	public static void main(String[] args) {
		LerXls x=new LerXls();
		x.leMatrizRetornaEstruturaTitulo("Relatório exemplares jul 2014.xls");
	}

}
