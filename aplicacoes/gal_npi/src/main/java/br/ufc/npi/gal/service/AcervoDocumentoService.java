package br.ufc.npi.gal.service;

import java.util.List;

import br.ufc.npi.gal.model.AcervoDocumento;
import br.ufc.npi.gal.model.Usuario;
import br.ufc.quixada.npi.service.GenericService;

public interface AcervoDocumentoService extends GenericService<AcervoDocumento>{

	List<AcervoDocumento> atualizacoesPorUsuario(Usuario usuario);

}
