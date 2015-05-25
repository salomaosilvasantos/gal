package br.ufc.npi.gal.service.impl;

import java.util.List;

import javax.inject.Inject;
import javax.inject.Named;

import br.ufc.npi.gal.model.AcervoDocumento;
import br.ufc.npi.gal.model.Usuario;
import br.ufc.npi.gal.repository.AcervoDocumentoRepository;
import br.ufc.npi.gal.service.AcervoDocumentoService;
import br.ufc.quixada.npi.service.impl.GenericServiceImpl;

@Named
public class AcervoDocumentoServiceImpl extends GenericServiceImpl<AcervoDocumento> implements AcervoDocumentoService {

	@Inject
	AcervoDocumentoRepository acervoDocRepository;
	
	@Override
	public List<AcervoDocumento> atualizacoesPorUsuario(Usuario name) {
		return acervoDocRepository.findDocumentosByUsuario(name);
	}


}
