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
	private static final String PATH_REDIRECT_TITULO_LISTAR = "redirect:/titulo/listar";
	private static final String PATH_TITULO_ADICIONAR = "titulo/adicionar";
	private static final String PATH_TITULO_EDITAR = "titulo/editar";
	private static final String PATH_TITULO_LISTAR = "titulo/listar";
	
	@RequestMapping(value = "/listar", method = RequestMethod.GET)
	public String listar(ModelMap modelMap) {
		modelMap.addAttribute("titulos", this.tituloService.find(Titulo.class));
		return PATH_TITULO_LISTAR;
	}
	
	@RequestMapping(value = "/adicionar", method = RequestMethod.GET)
	public String adicionar(ModelMap modelMap){
		modelMap.addAttribute("titulo", new Titulo());
		return PATH_TITULO_ADICIONAR;
	}
	
	@RequestMapping(value="/adicionar",method = RequestMethod.POST)
	public String adicionar(@Valid Titulo titulo, BindingResult result, RedirectAttributes redirectAttributes) {
		if (result.hasErrors()) {
			return PATH_TITULO_ADICIONAR;
		}
		
		if(tituloService.getTituloByIsbn(titulo.getIsbn()) != null) {
			result.rejectValue("isbn", "Repeat.titulo.isbn", "Já existe um título com esse isbn");
			return PATH_TITULO_ADICIONAR;
		}
		if (titulo.getNome().trim().isEmpty()) {
			result.rejectValue("nome", "Repeat.titulo.nome",
					"Campo obrigatório.");
			return PATH_TITULO_ADICIONAR;
		}
		if(tituloService.getTituloByNome(titulo.getNome()) != null) {
			result.rejectValue("nome", "Repeat.titulo.nome", "Já existe um título com esse nome");
			return PATH_TITULO_ADICIONAR;
		}
		
		tituloService.save(titulo);
		redirectAttributes.addFlashAttribute("info", "Título adicionado com sucesso.");
		return PATH_REDIRECT_TITULO_LISTAR;
		
	}
	
	@RequestMapping(value = "/{id}/editar", method = RequestMethod.GET)
	public String editar(@PathVariable("id") Integer id, ModelMap modelMap) {
		Titulo titulo = this.tituloService.find(Titulo.class, id);

		if (titulo == null) {
			return PATH_REDIRECT_TITULO_LISTAR;
		}

		modelMap.addAttribute("titulo", titulo);
		return PATH_TITULO_EDITAR;
	}
	
	@RequestMapping(value = "/editar", method=RequestMethod.POST)
	public String atualizar(@Valid Titulo titulo, BindingResult result, RedirectAttributes redirectAttributes){
		
		if (result.hasErrors()) {
			return PATH_TITULO_EDITAR;
		}
		
		if(tituloService.getOutroTituloByIsbn(titulo.getId(), titulo.getIsbn()) != null) {
			result.rejectValue("isbn", "Repeat.titulo.isbn", "Já existe um título com esse isbn");
			return PATH_TITULO_EDITAR;
		}
		if(tituloService.getOutroTituloByNome(titulo.getId(), titulo.getNome()) != null) {
			result.rejectValue("nome", "Repeat.titulo.nome", "Já existe um título com esse nome");
			return PATH_TITULO_EDITAR;
		}
		
		tituloService.update(titulo);
		redirectAttributes.addFlashAttribute("info", "Título atualizado com sucesso.");
		return PATH_REDIRECT_TITULO_LISTAR;
		
	}
	
	@RequestMapping(value = "/{id}/excluir", method = RequestMethod.GET)
	public String excluir(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
		Titulo titulo = tituloService.find(Titulo.class, id);
		if (titulo != null) {
			this.tituloService.delete(titulo);
			redirectAttributes.addFlashAttribute("info", "Título removido com sucesso.");
		}
		return PATH_REDIRECT_TITULO_LISTAR;
	}

}
