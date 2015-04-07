package br.ufc.npi.gal.service;

import java.io.File;

import org.springframework.web.multipart.MultipartFile;


public interface AcervoService {
	
	public abstract boolean atulizarAcervo();

	public abstract void arquivoParaLista(File planilha);

	public abstract void processarArquivo(MultipartFile multipartFile);
	
}
