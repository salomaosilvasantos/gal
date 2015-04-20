package br.ufc.npi.gal.repository.jpa;

import javax.inject.Named;

import br.ufc.npi.gal.model.AcervoDocumento;
import br.ufc.npi.gal.model.ExemplarConflitante;
import br.ufc.npi.gal.repository.AcervoDocumentoRepository;

@Named
public class AcervoDocumentoRepositoryImpl extends GenericRepositoryImpl<AcervoDocumento> implements AcervoDocumentoRepository{

}
