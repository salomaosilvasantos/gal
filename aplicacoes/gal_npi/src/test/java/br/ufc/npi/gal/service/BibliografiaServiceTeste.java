package br.ufc.npi.gal.service;

import java.util.ArrayList;
import java.util.Collection;

import javax.inject.Inject;

import org.junit.Test;

import br.ufc.npi.gal.model.Bibliografia;

public class BibliografiaServiceTeste {

	@Inject
	private BibliografiaService bibliografiaService;
	
	
	@Test
	public void test() {
		
		
		System.out.println(Bibliografia.class);
		Collection<Bibliografia> bibliografia =  bibliografiaService.find(Bibliografia.class);
		
		System.out.println(bibliografia);
	}

}
