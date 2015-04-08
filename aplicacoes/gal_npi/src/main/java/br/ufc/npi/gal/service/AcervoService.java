package br.ufc.npi.gal.service;

import java.io.File;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import br.ufc.npi.gal.model.Exemplar;


public interface AcervoService {
	
	public abstract boolean atulizarAcervo();

	public abstract List<Exemplar> arquivoParaLista(File planilha);

	public abstract void processarArquivo(MultipartFile multipartFile);
	
}
