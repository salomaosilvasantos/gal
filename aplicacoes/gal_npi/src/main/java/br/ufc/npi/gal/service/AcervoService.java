package br.ufc.npi.gal.service;

import java.io.File;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import br.ufc.npi.gal.model.Disciplina;
import br.ufc.npi.gal.model.Exemplar;
import br.ufc.npi.gal.model.ExemplarConflitante;


public interface AcervoService extends GenericService<ExemplarConflitante> {
	
	public abstract boolean atulizarAcervo();

	public abstract List<Exemplar> arquivoParaLista(File planilha);

	public abstract void processarArquivo(MultipartFile multipartFile);
	
}
