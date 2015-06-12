package br.ufc.npi.gal.repository;

import java.util.List;

import br.ufc.npi.gal.model.AcervoDocumento;
import br.ufc.npi.gal.model.Usuario;
import br.ufc.quixada.npi.repository.GenericRepository;

public interface AcervoDocumentoRepository extends GenericRepository<AcervoDocumento>{

	List<AcervoDocumento> findDocumentosByUsuario(Usuario name);

}
