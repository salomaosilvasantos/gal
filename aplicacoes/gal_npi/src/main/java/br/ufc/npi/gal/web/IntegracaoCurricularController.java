package br.ufc.npi.gal.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import br.ufc.npi.gal.service.IntegracaoCurricularService;

@Controller
public class IntegracaoCurricularController {
	@Autowired
	private IntegracaoCurricularService integracaoService;
}