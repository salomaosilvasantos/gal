package br.ufc.npi.gal.repository.jpa;

import javax.inject.Named;

import br.ufc.npi.gal.model.Bibliografia;
import br.ufc.npi.gal.repository.BibliografiaRepository;

@Named
public class JpaBibliografiaRepositoryImpl extends GenericRepositoryImpl<Bibliografia> implements BibliografiaRepository{


}
