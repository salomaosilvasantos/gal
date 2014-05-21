package br.ufc.npi.gal.web;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.ufc.npi.gal.model.Disciplina;
import br.ufc.npi.gal.service.DisciplinaService;

@Controller
@RequestMapping("/disciplina")
public class DisciplinaController {

	@Autowired
	private DisciplinaService disciplinaService;

	@RequestMapping(value = "/listar.htm")
	public String listar(ModelMap modelMap) {
		modelMap.addAttribute("disciplinas", this.disciplinaService.listar());
		return "disciplina/listar";
	} 

	@RequestMapping(value = "/{id}/editar.htm", method = RequestMethod.GET)
	public String editar(@PathVariable("id") Integer id, ModelMap modelMap) {

		Disciplina disciplina = this.disciplinaService.findById(id);

		if (disciplina == null) {
			return "redirect:/";

		} else {
			modelMap.addAttribute("disciplina", disciplina);
		}
			return "disciplina/editar";
	}
	
	@RequestMapping(value = "/{id}/excluir.htm", method = RequestMethod.GET)
	public String excluir(@PathVariable("id") Integer id, ModelMap modelMap) {

		this.disciplinaService.excluir(id);
		return "redirect:/disciplina/listar.htm";
	}
	
	@RequestMapping(value = "/editar.htm", method=RequestMethod.POST)
	public String atualizar(@Valid Disciplina disciplina, BindingResult result){
		
		if(result.hasErrors()){
			return "disciplina/editar";
		}

		this.disciplinaService.atualizar(disciplina);
		return "redirect:/disciplina/listar.htm";
		
	}
	
	@RequestMapping("/adicionada.htm")
	public String confirm(){
		return "disciplina/adicionada";
	}
	
	@RequestMapping(value = "/adicionar.htm")
	public String adicionar(ModelMap modelMap){
		modelMap.addAttribute("disciplina", new Disciplina());
		return "disciplina/adicionar";
	}
	
	@RequestMapping(value="/adicionar.htm",method = RequestMethod.POST)
	public String adicionar(@Valid Disciplina disciplina, BindingResult result, final RedirectAttributes redirectAttributes) {
		
		if(result.hasErrors())
			return "disciplina/adicionar";
		
		if(disciplinaService.buscar(disciplina.getCodigo(), disciplina.getNome()) == null) {
			disciplinaService.adicionar(disciplina);
			return "disciplina/adicionada";
		
		} else {
			redirectAttributes.addFlashAttribute("message", "Disciplina não pode ser adicionada pois já existe semelhante registrada");
			return "redirect:/disciplina/adicionar.htm";
		}
	}
	
	@RequestMapping("/buscar.htm")
	public String buscar(ModelMap model, String disc) {
		model.addAttribute("disciplinas", disciplinaService.findByCodigo(disc));
		return "disciplina/listar";
	}
	
	public void setProductManager(DisciplinaService productManager) {
		this.disciplinaService = productManager;
	}
}
