package br.ufc.npi.gal.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import br.ufc.npi.gal.service.EstruturaCurricularService;

@Controller
@RequestMapping("estrutura")
public class EstruturaCurricularController {

	@Autowired	
	private EstruturaCurricularService estruturaCurricularService;
}
