package br.ufc.npi.gal.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Named;

import jxl.Sheet;
import jxl.Workbook;
import jxl.WorkbookSettings;

import org.springframework.web.multipart.MultipartFile;

import br.ufc.npi.gal.service.AcervoService;
@Named
public class AcervoServiceImpl implements AcervoService {

	@Override
	public boolean atulizarAcervo() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void processarArquivo(MultipartFile multipartFile) {
		try {
			File arquivo = new File("/docs/atualizacoes_de_acervo");
			multipartFile.transferTo(arquivo);
			arquivoParaLista(arquivo);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}		
		
	}

	@Override
	public void arquivoParaLista(File planilha) {
		// TODO Auto-generated method stub
		Workbook workbook;
		
		try{
			WorkbookSettings configuracao =new WorkbookSettings();
			configuracao.setEncoding("Cp1252");
			workbook = Workbook.getWorkbook(planilha,configuracao);
			
			Sheet sheet = workbook.getSheet(0);
			int colunas = sheet.getColumns();
			int linhas = sheet.getRows();
			List<ExemplarDoRelatorio> relatorioDeExemplares = new ArrayList<>();
			
			if(sheet.getCell(26,i).equals("0"));
			
		workbook.close();	
		} catch (BiffException e) {

			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		}
	}
	

		
		
		String[][] teste = this.leXlsRetornaMatriz(arquivo);
		for(int i = 1; i < this.linhas; i++){
			
			if(teste[26][i].equals("0")){
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
			

		}
		return novo;
	}

}
