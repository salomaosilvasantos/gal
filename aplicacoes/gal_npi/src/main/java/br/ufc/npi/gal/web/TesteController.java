package br.ufc.npi.gal.web;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import br.ufc.npi.gal.service.CalculoMetaService;
import br.ufc.npi.gal.service.ResultadoCalculo;

@Controller
@RequestMapping("teste")
public class TesteController {

	@Inject
	private CalculoMetaService calculo;
	

	@RequestMapping(value = "/listar", method = RequestMethod.GET)
	public String listar(ModelMap modelMap) {
		modelMap.addAttribute("resultado", calculo.chamar());
		return "teste/listar";
	}
	
	
}
