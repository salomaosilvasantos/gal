package br.ufc.npi.gal.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import br.ufc.npi.gal.service.IntegracaoCurricularService;

@Controller
@RequestMapping("integracao")
public class IntegracaoCurricularController {
	@Autowired
	private IntegracaoCurricularService integracaoService;
	
	@RequestMapping(value = "/listar.htm")
	public String listar(ModelMap modelMap) {
		modelMap.addAttribute("integracao", this.integracaoService.listar());
		return "integracao/listar";
	} 
}
