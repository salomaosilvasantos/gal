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

import br.ufc.npi.gal.model.Titulo;
import br.ufc.npi.gal.service.TituloService;

@Controller
@RequestMapping("titulo")
public class TituloController {
	
	@Inject
	private TituloService tituloService;
	
	@RequestMapping(value = "/listar", method = RequestMethod.GET)
	public String listar(ModelMap modelMap) {
		modelMap.addAttribute("titulos", this.tituloService.find(Titulo.class));
		return "titulo/listar";
	}
	
	@RequestMapping(value = "/adicionar", method = RequestMethod.GET)
	public String adicionar(ModelMap modelMap){
		modelMap.addAttribute("titulo", new Titulo());
		return "titulo/adicionar";
	}
	
	@RequestMapping(value="/adicionar",method = RequestMethod.POST)
	public String adicionar(@Valid Titulo titulo, BindingResult result, RedirectAttributes redirectAttributes) {
		if (result.hasErrors()) {
			return "titulo/adicionar";
		}
		
		if(tituloService.getTituloByIsbn(titulo.getIsbn()) != null) {
			result.rejectValue("isbn", "Repeat.titulo.isbn", "Já existe um título com esse isbn");
			return "titulo/adicionar";
		}
		if(tituloService.getTituloByNome(titulo.getNome()) != null) {
			result.rejectValue("nome", "Repeat.titulo.nome", "Já existe um título com esse nome");
			return "titulo/adicionar";
		}
		
		tituloService.save(titulo);
		redirectAttributes.addFlashAttribute("info", "Título adicionado com sucesso.");
		return "redirect:/titulo/listar";
		
	}
	
	@RequestMapping(value = "/{id}/editar", method = RequestMethod.GET)
	public String editar(@PathVariable("id") Integer id, ModelMap modelMap) {
		Titulo titulo = this.tituloService.find(Titulo.class, id);

		if (titulo == null) {
			return "redirect:/titulo/listar";
		}

		modelMap.addAttribute("titulo", titulo);
		return "titulo/editar";
	}
	
	@RequestMapping(value = "/editar", method=RequestMethod.POST)
	public String atualizar(@Valid Titulo titulo, BindingResult result, RedirectAttributes redirectAttributes){
		
		if (result.hasErrors()) {
			return "titulo/editar";
		}
		
		if(tituloService.getOutroTituloByIsbn(titulo.getId(), titulo.getIsbn()) != null) {
			result.rejectValue("isbn", "Repeat.titulo.isbn", "Já existe um título com esse isbn");
			return "titulo/editar";
		}
		if(tituloService.getOutroTituloByNome(titulo.getId(), titulo.getNome()) != null) {
			result.rejectValue("nome", "Repeat.titulo.nome", "Já existe um título com esse nome");
			return "titulo/editar";
		}
		
		tituloService.update(titulo);
		redirectAttributes.addFlashAttribute("info", "Título atualizado com sucesso.");
		return "redirect:/titulo/listar";
		
	}
	
	@RequestMapping(value = "/{id}/excluir", method = RequestMethod.GET)
	public String excluir(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
		Titulo titulo = tituloService.find(Titulo.class, id);
		if (titulo != null) {
			this.tituloService.delete(titulo);
			redirectAttributes.addFlashAttribute("info", "Título removido com sucesso.");
		}
		return "redirect:/titulo/listar";
	}

}
