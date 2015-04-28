package br.ufc.npi.gal.web;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.ufc.npi.gal.model.ExemplarConflitante;
import br.ufc.npi.gal.service.AcervoService;

@Controller
@RequestMapping("acervo")
public class AcervoController {

	@Inject
	private AcervoService acervoService;

	@RequestMapping(value = "/atualizar_acervo", method = RequestMethod.GET)
	public String atualizarAcervo(ModelMap modelMap) {
		return "acervo/atualizar";
	}
	
	@RequestMapping(value = "/resolver_conflitos", method = RequestMethod.GET)
	public String resolverConflitos(ModelMap modelMap) {
		
		modelMap.addAttribute("exemplares", acervoService.find(ExemplarConflitante.class));
		return "acervo/conflitos";
	}

	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public String uploadDoArquivoXls(MultipartHttpServletRequest request) {
		//validar se foi enviado o arquivo
		if(request != null){	
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultipartFile multipartFile = multipartRequest.getFile("file"); 
			acervoService.processarArquivo(multipartFile);
		}else{
			//msg de erro, sem arquivo
		}
		return "/resolver_conflitos";

	}
	
	@RequestMapping(value = "/{id}/editar", method = RequestMethod.GET)
	public String editar(@PathVariable("id") Integer id, ModelMap modelMap) {
		
		ExemplarConflitante exemplar = this.acervoService.find(ExemplarConflitante.class,id);
		
		if(exemplar == null) {
			return "/acervo/conflitos";
		}
		modelMap.addAttribute("exemplar", exemplar);
		return "acervo/editar";
	}
	
	@RequestMapping(value = "/editar", method = RequestMethod.POST)
	public String atualizar(@Valid ExemplarConflitante exemplar, BindingResult result,
			RedirectAttributes redirectAttributes) {
		if (acervoService.submeterExemplarConflitante(exemplar)) {
			return "redirect:/acervo/resolver_conflitos";	
		} else {
			return "redirect:/acervo/resolver_conflitos";
		}
		
	}
}
