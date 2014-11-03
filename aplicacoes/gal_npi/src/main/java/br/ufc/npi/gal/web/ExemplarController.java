package br.ufc.npi.gal.web;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.ufc.npi.gal.model.Exemplar;
import br.ufc.npi.gal.model.Titulo;
import br.ufc.npi.gal.service.ExemplarService;
import br.ufc.npi.gal.service.TituloService;

@Controller
@RequestMapping("exemplar")
public class ExemplarController {
	
	@Inject
	private ExemplarService exemplarService;
	
	@Inject
	private TituloService tituloService;

	
	@RequestMapping(value = "/{id}/listar", method = RequestMethod.GET)
	public String listar(@PathVariable("id") Integer id,ModelMap modelMap) {
		Titulo titulo = this.tituloService.find(Titulo.class, id);
		modelMap.addAttribute("exemplares",titulo.getExemplares());
		modelMap.addAttribute("titulo",titulo);
		return "exemplar/listar";
	}
	
	@RequestMapping(value = "/{id}/adicionar", method = RequestMethod.GET)
	public String adicionar(@PathVariable("id") Integer id,ModelMap modelMap){
		Titulo titulo = this.tituloService.find(Titulo.class, id);
		modelMap.addAttribute("titulo",titulo);
		modelMap.addAttribute("exemplar", new Exemplar());
		return "exemplar/adicionar";
	}
	
	@RequestMapping(value="/{id}/adicionar",method = RequestMethod.POST)
	public String adicionar(@Valid Exemplar exemplar, BindingResult result, RedirectAttributes redirectAttributes,ModelMap modelMap,@PathVariable("id")Integer id) {
		Titulo titulo = this.tituloService.find(Titulo.class, id);
		modelMap.addAttribute("titulo",titulo);
		if (result.hasErrors()) {
			return "exemplar/adicionar";
		}
		
		exemplar.setId(null);
		exemplar.setTitulo(titulo);	
		exemplarService.save(exemplar);
		redirectAttributes.addFlashAttribute("info", "Exemplar adicionado com sucesso.");
		return "redirect:/exemplar/"+exemplar.getTitulo().getId()+"/listar";
		
	}
	
	@RequestMapping(value = "/{id}/editar", method = RequestMethod.GET)
	public String editar(@PathVariable("id") Integer id, ModelMap modelMap) {
		Exemplar exemplar = this.exemplarService.find(Exemplar.class, id);
		modelMap.addAttribute("exemplar", exemplar);
		return "exemplar/editar";
	}
	
	@RequestMapping(value = "/{id}/editar", method=RequestMethod.POST)
	public String atualizar( @Valid Exemplar exemplar, BindingResult result, RedirectAttributes redirectAttributes,@PathVariable("id") Integer id){
		Titulo titulo = this.tituloService.find(Titulo.class, id);
		if (result.hasErrors()) {
			return "exemplar/editar";
		}

		if (exemplarService.getExemplarByCodigo(exemplar.getCodigoExemplar())!= null) {
			result.rejectValue("codigoExemplar", "Repeat.exemplar.codigoExemplar",
					"Já existe um exemplar com esse codigo");
			return "exemplar/editar";
		}
		
		exemplar.setTitulo(titulo);
		exemplarService.update(exemplar);
		redirectAttributes.addFlashAttribute("info",
				"Exemplar atualizado com sucesso.");
		return "redirect:/exemplar/"+exemplar.getTitulo().getId()+"/listar";	
	}
	
	@RequestMapping(value = "/{id}/excluir", method = RequestMethod.GET)
	public String excluir(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
		Exemplar exemplar = this.exemplarService.find(Exemplar.class, id);
		if (exemplar != null) {
			this.exemplarService.delete(exemplar);
			redirectAttributes.addFlashAttribute("info", "Exemplar removido com sucesso.");
		}
		
		return "redirect:/exemplar/"+exemplar.getTitulo().getId()+"/listar";
	}

}
