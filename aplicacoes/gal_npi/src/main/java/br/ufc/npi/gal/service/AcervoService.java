package br.ufc.npi.gal.service;

import org.springframework.web.multipart.MultipartFile;

import br.ufc.npi.gal.model.AcervoDocumento;
import br.ufc.npi.gal.model.ExemplarConflitante;
import br.ufc.quixada.npi.service.GenericService;


public interface AcervoService extends GenericService<ExemplarConflitante> {
	
	public abstract void processarArquivo(MultipartFile multipartFile);
	
	public boolean submeterExemplarConflitante(ExemplarConflitante exemplar);
	
	public void registrarAtualizacao(AcervoDocumento acervoDocumento);
	
}

