package br.ufc.npi.gal.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.ufc.npi.gal.model.EstruturaCurricular;
import br.ufc.npi.gal.repository.EstruturaCurricularRepository;


@Service
public class EstruturaCurricularServiceImpl implements EstruturaCurricularService{
	@Autowired
	private EstruturaCurricularRepository estruturaCurricularRepository;
	
	
	public void inserirEstruturaCurricular(
			EstruturaCurricular estruturaCurricular) {
		// TODO Auto-generated method stub
		
	}

	public List<EstruturaCurricular> listarCurriculos() {
		
		return estruturaCurricularRepository.listarCurriculos();
	}

}
