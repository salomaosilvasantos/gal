package br.ufc.npi.gal.web;

import java.util.List;

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
	
	private List<ResultadoCalculo> resultado;

	@RequestMapping(value = "/listar", method = RequestMethod.GET)
	public String listar(ModelMap modelMap) {
		resultado = calculo.chamar();
		
		
		modelMap.addAttribute("resultados", resultado);
		return "teste/listar";
	}
	
	
}
