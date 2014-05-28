package br.ufc.npi.gal.web;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import br.ufc.npi.gal.model.Titulo;
import br.ufc.npi.gal.service.TituloService;

@Controller
@RequestMapping("titulo")
public class TituloController {
	
	@Autowired
	private TituloService tituloService;
	
	@RequestMapping(value = "/listar.htm", method = RequestMethod.GET)
	public String listar(ModelMap modelMap) {
		
		modelMap.addAttribute("titulos", this.tituloService.listar());
		return "titulo/listar";
		
	}
	
	@RequestMapping(value = "/adicionar.htm", method = RequestMethod.GET)
	public String adicionar(ModelMap modelMap){
		
		modelMap.addAttribute("titulo", new Titulo());
		return "titulo/adicionar";
		
	}
	
	@RequestMapping(value="/adicionar.htm",method = RequestMethod.POST)
	public String adicionar(@Valid Titulo titulo, BindingResult result, ModelMap modelMap) {
		
		if(result.hasErrors()) {
			return "titulo/adicionar";
		}
		
		List<Titulo> titulos = tituloService.findByIsbn(titulo.getIsbn());
		if(titulos == null || titulos.isEmpty()) {
			titulos = tituloService.findByNome(titulo.getNome());
			if(titulos == null || titulos.isEmpty()) {
				tituloService.adicionar(titulo);
				return "redirect:/titulo/listar.htm";
			} else {
				modelMap.addAttribute("error", "Já existe um título com o mesmo nome");
			}
		} else {
			modelMap.addAttribute("error", "Já existe um título com o mesmo ISBN");
		}
		
		
		return "titulo/adicionar";
		
	}
	
	@RequestMapping(value = "/{id}/editar.htm", method = RequestMethod.GET)
	public String editar(@PathVariable("id") Integer id, ModelMap modelMap) {

		Titulo titulo = this.tituloService.findById(id);

		if (titulo == null) {
			return "redirect:/";

		} else {
			modelMap.addAttribute("titulo", titulo);
		}
			return "titulo/editar";
	}
	
	@RequestMapping(value = "/editar.htm", method=RequestMethod.POST)
	public String atualizar(@Valid Titulo titulo, BindingResult result){
		
		if(result.hasErrors()){
			return "titulo/editar";
		}

		this.tituloService.atualizar(titulo);
		return "redirect:/titulo/listar.htm";
		
	}
	
	@RequestMapping(value = "/excluir.htm", method = RequestMethod.POST)
	//ResquestParam("id") where name = "id"
	public String excluir(@RequestParam("id") Integer id) {
		this.tituloService.excluir(id);
		return "redirect:/titulo/listar.htm";
	}
	
	/*
	@RequestMapping(value = "/{id}/excluir.htm", method = RequestMethod.GET)
	public String excluir(@PathVariable("id") Integer id, ModelMap modelMap) {

		this.tituloService.excluir(id);
		return "redirect:/titulo/listar.htm";
		
	}
*/
}
