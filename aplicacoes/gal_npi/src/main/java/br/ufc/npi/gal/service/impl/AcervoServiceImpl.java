package br.ufc.npi.gal.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Named;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.read.biff.BiffException;

import org.springframework.web.multipart.MultipartFile;

import br.ufc.npi.gal.model.Exemplar;
import br.ufc.npi.gal.model.Titulo;
import br.ufc.npi.gal.service.AcervoService;
@Named
public class AcervoServiceImpl implements AcervoService {
	private static final int COLUNA_ISBN = 45;
	private static final int COLUNA_COD_EXEMPLAR = 2;
	private static final int TIPO = 26;  //0 tipo = fisico - 1 midia digital
	//CAMPOS DO TITULO
	private static final int COLUNA_AUTOR = 36;
	private static final int COLUNA_TITULO = 37;
	private static final int COLUNA_TITULO_N = 38;
	private static final int COLUNA_SUB_TITULO = 39;
	private static final int COLUNA_TITULO_REVISTA = 40;
	private static final int COLUNA_PAGINA = 41;
	private static final int COLUNA_REF_ARTIGO = 42;
	private static final int COLUNA_EDICAO = 43;
	private static final int COLUNA_PUBLICADOR = 46;
	
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
			realizarAtualização(arquivoParaLista(arquivo));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}		
		
	}

	private void realizarAtualização(List<Exemplar> listaDeExemplares) {
		
		//se ISBN ja existe no banco cadastra apenas o exemplar
		
		//se não, cadastrar titulo primeiro e o exemplar dps
	}

	@Override
	public List<Exemplar> arquivoParaLista(File planilha) {
		// TODO Auto-generated method stub
		Workbook workbook;
		List<Exemplar> relatorioDeExemplares = new ArrayList<>();
		try{
			WorkbookSettings configuracao =new WorkbookSettings();
			configuracao.setEncoding("Cp1252");
			workbook = Workbook.getWorkbook(planilha,configuracao);
			
			Sheet sheet = workbook.getSheet(0);
			int colunas = sheet.getColumns();
			int linhas = sheet.getRows();
			Exemplar exemplar = new Exemplar();
			for (int i = 0; i < linhas; i++) {
				if(sheet.getCell(TIPO,i).equals("0")){
					Boolean isbnConhecido=false;
					Titulo titulo = new Titulo();
					titulo.setIsbn(new String(this.formataIsbn(sheet.getCell(COLUNA_ISBN, i))));
					titulo.setNome(formatarNome(sheet,i));
					titulo.setTipo("Físico");
					
					exemplar.setTitulo(titulo);
					exemplar.setCodigoExemplar(sheet.getCell(COLUNA_COD_EXEMPLAR, i).getContents());
				}
				
			}
		workbook.close();	
		} catch (BiffException e) {

			e.printStackTrace();
		} catch (IOException e) {

			e.printStackTrace();
		}
		return relatorioDeExemplares;
	}

	private String formataIsbn(Cell cell) {
		// TODO Auto-generated method stub
		return null;
	}

	private String formatarNome(Sheet sheet, int i) {
		// TERMINAR
		return sheet.getCell(COLUNA_AUTOR, i).getContents() + sheet.getCell(COLUNA_TITULO, i) + sheet.getCell(COLUNA_TITULO_N, i);
	}
	
}
