package br.ufc.npi.gal.service;

import javax.inject.Named;

import org.springframework.web.multipart.MultipartFile;


public interface AcervoService {
	
	public abstract boolean atulizarAcervo();

	public abstract void analisarArquivo(MultipartFile multipartFile);
	
}
