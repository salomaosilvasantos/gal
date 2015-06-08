package br.ufc.npi.gal.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.inject.Named;

import jxl.Sheet;
import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.read.biff.BiffException;

import org.springframework.web.multipart.MultipartFile;

import br.ufc.npi.gal.model.AcervoDocumento;
import br.ufc.npi.gal.model.Exemplar;
import br.ufc.npi.gal.model.ExemplarConflitante;
import br.ufc.npi.gal.model.Titulo;
import br.ufc.npi.gal.repository.AcervoDocumentoRepository;
import br.ufc.npi.gal.repository.ExemplarConflitanteRepository;
import br.ufc.npi.gal.repository.ExemplarRepository;
import br.ufc.npi.gal.repository.TituloRespository;
import br.ufc.npi.gal.service.AcervoService;
import br.ufc.quixada.npi.service.impl.GenericServiceImpl;

@Named
public class AcervoServiceImpl extends GenericServiceImpl<ExemplarConflitante> implements AcervoService {
	private static final int COLUNA_ISBN = 45;
	private static final int COLUNA_COD_EXEMPLAR = 2;
	private static final int TIPO = 26;  //0 tipo = fisico - 1 midia digital
	//CAMPOS DO NOME TITULO
	private static final int COLUNA_AUTOR = 36;
	private static final int COLUNA_TITULO = 37;
	private static final int COLUNA_TITULO_N = 38;
	private static final int COLUNA_SUB_TITULO = 39;
	private static final int COLUNA_TITULO_REVISTA = 40;
	private static final int COLUNA_PAGINA = 41;
	private static final int COLUNA_REF_ARTIGO = 42;
	private static final int COLUNA_EDICAO = 43;
	private static final int COLUNA_PUBLICADOR = 46;
	
	@Inject
	private AcervoDocumentoRepository acervoDocumentoRepository;
	
	@Inject
	private ExemplarConflitanteRepository exemplarConflitanteReposiroty;
	@Inject
	private TituloRespository tituloRepository;
	@Inject
	private ExemplarRepository exemplarRepository;
	
	@Override 
	public void registrarAtualizacao(AcervoDocumento acervoDocumento){
		acervoDocumentoRepository.save(acervoDocumento);
	}
	
	@Override
	public void processarArquivo(MultipartFile multipartFile) {
		try {
			File arquivo = new File("temp.xls");
			multipartFile.transferTo(arquivo);
			realizarAtualização(arquivoParaLista(arquivo));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}		
	}

	public List<Exemplar> arquivoParaLista(File planilha) {
		Workbook workbook;
		List<Exemplar> relatorioDeExemplares = new ArrayList<Exemplar>();
		try{
			
			WorkbookSettings configuracao =new WorkbookSettings();
			configuracao.setEncoding("Cp1252");
			workbook = Workbook.getWorkbook(planilha,configuracao);
			
			Sheet sheet = workbook.getSheet(0);
			int linhas = sheet.getRows();
			ExemplarConflitante exemplarConflitante = new ExemplarConflitante();
			for (int i = 1; i < linhas-1; i++) {
				
				exemplarConflitante = validarLinha(sheet,i);
				exemplarConflitante.setLinha(i);
				if(exemplarConflitante.getDescricaoErro().isEmpty() ){
					relatorioDeExemplares.add(formatarExemplar(sheet,i));
					
				}else{
					adicionarConflito(exemplarConflitante);
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
	
	private void realizarAtualização(List<Exemplar> listaDeExemplares) {
		for (Exemplar exemplar : listaDeExemplares) {
			//se ISBN ja existe no banco cadastra apenas o exemplar
			if(tituloRepository.getTituloByIsbn(exemplar.getTitulo().getIsbn()) != null){
				if (exemplarRepository.getExemplarByCodigo(exemplar.getCodigoExemplar()) == null) {
					exemplar.setTitulo(tituloRepository.getTituloByIsbn(exemplar.getTitulo().getIsbn()));
					exemplarRepository.save(exemplar);
				}
				
			}
			//se não, cadastrar titulo primeiro e o exemplar dps
			else{
				tituloRepository.save(exemplar.getTitulo());
				try{
					exemplarRepository.save(exemplar);
				}catch(Exception e){
					System.err.println("Exemplar ja existente! Código do exemplar: " +exemplar.getCodigoExemplar());
				}
			}
		}
	}
	
	private void realizarAtualização(Exemplar exemplar) {
		//se ISBN ja existe no banco cadastra apenas o exemplar
		if(tituloRepository.getTituloByIsbn(exemplar.getTitulo().getIsbn()) != null){
			if (exemplarRepository.getExemplarByCodigo(exemplar.getCodigoExemplar()) == null) {
				exemplar.setTitulo(tituloRepository.getTituloByIsbn(exemplar.getTitulo().getIsbn()));
				exemplarRepository.save(exemplar);
			}
			
		}
		//se não, cadastrar titulo primeiro e o exemplar dps
		else{
			tituloRepository.save(exemplar.getTitulo());
			try{
				exemplarRepository.save(exemplar);
			}catch(Exception e){
				System.err.println("Exemplar ja existente! Código do exemplar: " +exemplar.getCodigoExemplar());
			}
		}
	}
	
	private void adicionarConflito(ExemplarConflitante conflito) {
		try{
			exemplarConflitanteReposiroty.save(conflito);
		}catch(Exception e){
			System.err.println("Exemplar ja existente! Código do exemplar: " +conflito.getCodigoExemplar());
		}
	}

	private ExemplarConflitante validarLinha(Sheet sheet, int i) {
		ExemplarConflitante exemplarConflitante = new ExemplarConflitante();
		String erros = new String();
		
		String validadorTipo = validacaoDeTipo(sheet.getCell(TIPO,i).getContents());
		if(validadorTipo.equals("valido")){
			exemplarConflitante.setTipo(sheet.getCell(TIPO,i).getContents());
		}else{
			exemplarConflitante.setTipo(sheet.getCell(TIPO,i).getContents());
			erros = validadorTipo;
		}
				
		if(!formatarNomeTitulo(sheet,i).isEmpty()){
			exemplarConflitante = preencherCamposNomeTitulo(sheet,i,exemplarConflitante);
		}else {
			exemplarConflitante = preencherCamposNomeTitulo(sheet,i,exemplarConflitante);
			erros +=" Nome do título não especificado";
		}
		
		String validadorCodExemplar = formatarCodigoExemplar(sheet.getCell(COLUNA_COD_EXEMPLAR,i).getContents());
		if(validadorCodExemplar.equals("valido")){
			exemplarConflitante.setCodigoExemplar(sheet.getCell(COLUNA_COD_EXEMPLAR,i).getContents());
		}else{
			exemplarConflitante.setCodigoExemplar(sheet.getCell(COLUNA_COD_EXEMPLAR,i).getContents());
			erros+= " "+validadorCodExemplar;
		}
		
		String isbn = extrairIsbnDaCelula(sheet.getCell(COLUNA_ISBN,i).getContents());
		String validadorIsbn = formatarIsbn(isbn);
		if(validadorIsbn.equals("valido")){
			exemplarConflitante.setIsbn(isbn);
		}else{
			exemplarConflitante.setIsbn(isbn);
			erros+=" "+validadorIsbn;
		}
		exemplarConflitante.setDescricaoErro(erros);
		return exemplarConflitante;
		
	}

	private String formatarIsbn(String contents) {
		if(contents.matches("([0-9]{13})|([0-9]{9}X)|([0-9]{12}X)|([0-9]{10})")){
			return "valido";
		}
		return "ISBN inválido";
	}

	private String validacaoDeTipo(String tipo) {
		if(tipo.equals("0") || tipo.equals("1")){
			return "valido";
		}else if(tipo.equals("")){
			return "Tipo de exemplar não especificado";
		}
		return "Tipo de exemplar inválido";
	}

	private String extrairIsbnDaCelula(String isbnForaDeFormato) {
		isbnForaDeFormato = isbnForaDeFormato.replaceAll("\\.", "");
		isbnForaDeFormato = isbnForaDeFormato.replaceAll("ISBN", "");
		isbnForaDeFormato = isbnForaDeFormato.replaceAll("\\(.+", "");
		isbnForaDeFormato = isbnForaDeFormato.replaceAll("(v1)", "");
		isbnForaDeFormato = isbnForaDeFormato.replaceAll("(v2)", "");
		isbnForaDeFormato = isbnForaDeFormato.replaceAll("\\s+", "");
		isbnForaDeFormato = isbnForaDeFormato.replaceAll("-", "");
		isbnForaDeFormato = isbnForaDeFormato.replaceAll("\\[.+", "");
		isbnForaDeFormato = isbnForaDeFormato.replaceAll(" ", "");
		return isbnForaDeFormato;
	
	}

	private String formatarNomeTitulo(Sheet sheet, int i) {
		// concatena os campos que compoem o titulo
		return sheet.getCell(COLUNA_AUTOR, i).getContents() + " "+sheet.getCell(COLUNA_TITULO, i)+" "+ sheet.getCell(COLUNA_TITULO_N, i)+" "
				+sheet.getCell(COLUNA_SUB_TITULO,i) +" "+sheet.getCell(COLUNA_TITULO_REVISTA, i)+" "+sheet.getCell(COLUNA_PAGINA,i)
				+" "+sheet.getCell(COLUNA_REF_ARTIGO,i)+" "+sheet.getCell(COLUNA_EDICAO,i)+" "+sheet.getCell(COLUNA_PUBLICADOR,i);
	}
	
	private String formatarNomeTitulo(ExemplarConflitante exemplar) {
		return exemplar.getAutor() + " " + exemplar.getTitulo() + " " + exemplar.getTitulo_n() + " " +
				exemplar.getSubTitulo() + " " + exemplar.getTituloRevista() + " " + exemplar.getPagina() + " " +
				exemplar.getRefArtigo() + " " + exemplar.getEdicao() + " " + exemplar.getPublicador();
	}

	private Exemplar formatarExemplar(Sheet sheet, int i) {
		Titulo titulo = new Titulo();
		titulo.setIsbn(extrairIsbnDaCelula(sheet.getCell(COLUNA_ISBN, i).getContents()));
		System.out.println("isbn do titulo:" +titulo.getIsbn());
		titulo.setNome(formatarNomeTitulo(sheet,i));
		titulo.setTipo("Físico");
		Exemplar exemplar = new Exemplar();
		exemplar.setTitulo(titulo);
		exemplar.setCodigoExemplar(sheet.getCell(COLUNA_COD_EXEMPLAR, i).getContents());
		return exemplar;
	}
	
	private Exemplar formatarExemplar(ExemplarConflitante exemplarConflitante) {
		Exemplar exemplar = new Exemplar();
		Titulo titulo = new Titulo();
		titulo.setIsbn(exemplarConflitante.getIsbn());
		titulo.setNome(formatarNomeTitulo(exemplarConflitante));
		titulo.setTipo("Físico");
		exemplar.setTitulo(titulo);
		exemplar.setCodigoExemplar(exemplarConflitante.getCodigoExemplar());
		return exemplar;
	}
	
	private ExemplarConflitante preencherCamposNomeTitulo(Sheet sheet, int i,
			ExemplarConflitante exemplarConflitante) {
		exemplarConflitante.setAutor(sheet.getCell(COLUNA_AUTOR,i).getContents());
		exemplarConflitante.setEdicao(sheet.getCell(COLUNA_EDICAO,i).getContents());
		exemplarConflitante.setPagina(sheet.getCell(COLUNA_PAGINA,i).getContents());
		exemplarConflitante.setPublicador(sheet.getCell(COLUNA_PUBLICADOR,i).getContents());
		exemplarConflitante.setRefArtigo(sheet.getCell(COLUNA_REF_ARTIGO,i).getContents());
		exemplarConflitante.setSubTitulo(sheet.getCell(COLUNA_SUB_TITULO,i).getContents());
		exemplarConflitante.setTitulo(sheet.getCell(COLUNA_TITULO,i).getContents());
		exemplarConflitante.setTitulo_n(sheet.getCell(COLUNA_TITULO_N,i).getContents());
		exemplarConflitante.setTituloRevista(sheet.getCell(COLUNA_TITULO_REVISTA,i).getContents());
		return exemplarConflitante;
	}
	
	private String formatarCodigoExemplar(String contents) {
		if(contents.isEmpty()){
			return "Código do exemplar não especificado";
		}else if(!contents.matches("[0-9]+")){
			return "Código do exemplar inválido";
		}else
			return "valido";
	}
	
	public boolean submeterExemplarConflitante(ExemplarConflitante exemplarConflitante) {
		exemplarConflitante.setDescricaoErro("");
		String erros = new String();
		
		String validadorTipo = validacaoDeTipo(exemplarConflitante.getTipo());
		if(!validadorTipo.equals("valido")){
			erros = validadorTipo;
		}
		
		String validadorCodExemplar = formatarCodigoExemplar(exemplarConflitante.getCodigoExemplar());
		if(!validadorCodExemplar.equals("valido")){
			erros+= " "+validadorCodExemplar;
		}
		
		String isbn = extrairIsbnDaCelula(exemplarConflitante.getIsbn());
		String validadorIsbn = formatarIsbn(isbn);
		if(!validadorIsbn.equals("valido")){
			erros+=" "+validadorIsbn;
		}
		
		exemplarConflitante.setDescricaoErro(erros);
		if(exemplarConflitante.getDescricaoErro().equals("")) {
			Exemplar exemplar = formatarExemplar(exemplarConflitante);
			System.out.println("aqui");
			realizarAtualização(exemplar);
			exemplarConflitanteReposiroty.delete(exemplarConflitante);
			return true;
		} else {
			exemplarConflitanteReposiroty.update(exemplarConflitante);
			return false;
		}
		

	}
}
