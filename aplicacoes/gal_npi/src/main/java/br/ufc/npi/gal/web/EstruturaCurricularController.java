package br.ufc.npi.gal.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import br.ufc.npi.gal.service.EstruturaCurricularService;

@Controller
@RequestMapping("estrutura")
public class EstruturaCurricularController {

	@Autowired	
	private EstruturaCurricularService estruturaCurricularService;
	
	@RequestMapping(value = "/listar.htm")
	public String listar(ModelMap modelMap) {
		modelMap.addAttribute("estruturas", this.estruturaCurricularService.listar());
		return "estrutura/listar";
	} 
}
