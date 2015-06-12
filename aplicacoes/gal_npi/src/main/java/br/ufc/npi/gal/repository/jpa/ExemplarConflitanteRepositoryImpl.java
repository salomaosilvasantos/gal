package br.ufc.npi.gal.repository.jpa;

import javax.inject.Named;

import br.ufc.npi.gal.model.ExemplarConflitante;
import br.ufc.npi.gal.repository.ExemplarConflitanteRepository;
import br.ufc.quixada.npi.repository.jpa.JpaGenericRepositoryImpl;

@Named
public class ExemplarConflitanteRepositoryImpl extends JpaGenericRepositoryImpl<ExemplarConflitante> implements ExemplarConflitanteRepository{

}

