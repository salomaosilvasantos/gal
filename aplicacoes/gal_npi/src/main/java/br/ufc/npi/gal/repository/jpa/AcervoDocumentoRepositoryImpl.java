package br.ufc.npi.gal.repository.jpa;

import javax.inject.Named;

import br.ufc.npi.gal.model.AcervoDocumento;
import br.ufc.npi.gal.repository.AcervoDocumentoRepository;
import br.ufc.quixada.npi.repository.jpa.JpaGenericRepositoryImpl;

@Named
public class AcervoDocumentoRepositoryImpl extends JpaGenericRepositoryImpl<AcervoDocumento> implements AcervoDocumentoRepository{

}
