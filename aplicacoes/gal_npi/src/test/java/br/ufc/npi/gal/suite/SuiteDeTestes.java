package br.ufc.npi.gal.suite;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

import br.ufc.npi.gal.model.CursoTeste;
import br.ufc.npi.gal.model.DisciplinaTeste;
import br.ufc.npi.gal.model.TituloTeste;
import br.ufc.npi.gal.service.CalculoMetaServiceTeste;
import br.ufc.npi.gal.service.CursoServiceTeste;

@RunWith(Suite.class)
@SuiteClasses({ CalculoMetaServiceTeste.class, CursoServiceTeste.class,
		CursoTeste.class, DisciplinaTeste.class, TituloTeste.class })
public class SuiteDeTestes {

}
