package br.ufc.npi.gal.web;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.ufc.npi.gal.model.IntegracaoCurricular;
import br.ufc.npi.gal.service.IntegracaoCurricularService;

@Controller
@RequestMapping("integracao")
public class IntegracaoCurricularController {
	
	@Inject
	private IntegracaoCurricularService integracaoService;
	
	@RequestMapping(value = "/listar")
	public String listar(ModelMap modelMap) {
		modelMap.addAttribute("integracao", this.integracaoService.find(IntegracaoCurricular.class));
		return "integracao/listar";
	}
	
	@RequestMapping(value = "/excluir", method = RequestMethod.GET)
	public String excluir(RedirectAttributes redirectAttributes) {
		IntegracaoCurricular integracao = integracaoService.getIntegracaoByDoisIds(1, 4);
		if (integracao != null) {
			this.integracaoService.delete(integracao);
			redirectAttributes.addFlashAttribute("info",
					"Disciplina removida com sucesso.");
		}
		return "redirect:/integracao/listar";
	}
	
	@RequestMapping(value = "/adicionar")
	public String adicionar(ModelMap modelMap) {
		modelMap.addAttribute("integracao", new IntegracaoCurricular());
		return "integracao/adicionar";
	}

	@RequestMapping(value = "/adicionar", method = RequestMethod.POST)
	public String adicionar(@Valid IntegracaoCurricular integracao, BindingResult result, final RedirectAttributes redirectAttributes) {
		if (result.hasErrors()) {
			return "integracao/adicionar";
		}
		integracaoService.save(integracao);
		redirectAttributes.addFlashAttribute("info",
				"Integracao Curricular adicionada com sucesso.");
		return "redirect:/integracao/listar";
	}
	
}