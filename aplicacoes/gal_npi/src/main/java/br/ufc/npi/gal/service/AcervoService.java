package br.ufc.npi.gal.service;

import org.springframework.web.multipart.MultipartFile;

import br.ufc.npi.gal.model.ExemplarConflitante;


public interface AcervoService extends GenericService<ExemplarConflitante> {
	
	public abstract void processarArquivo(MultipartFile multipartFile);
	
}
