package br.ufc.npi.gal.web;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import br.ufc.npi.gal.model.EstruturaCurricular;
import br.ufc.npi.gal.service.EstruturaCurricularService;

@Controller
@RequestMapping("estrutura")
public class EstruturaCurricularController {

	@Inject
	private EstruturaCurricularService estruturaCurricularService;
	
	@RequestMapping(value = "/listar")
	public String listar(ModelMap modelMap) {
		modelMap.addAttribute("estruturas", this.estruturaCurricularService.find(EstruturaCurricular.class));
		return "estrutura/listar";
	}
}
