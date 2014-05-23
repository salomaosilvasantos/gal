package br.ufc.npi.gal.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.ufc.npi.gal.model.IntegracaoCurricular;
import br.ufc.npi.gal.repository.IntegracaoCurricularRepository;
import br.ufc.npi.gal.service.IntegracaoCurricularService;

@Service
public class IntegracaoCurricularServiceimpl implements IntegracaoCurricularService{
	
	@Autowired
	private IntegracaoCurricularRepository integracaoRepository;
	
	public List<IntegracaoCurricular> listar() {
		// TODO Auto-generated method stub
		return null;
	}

}
