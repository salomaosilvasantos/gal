package br.ufc.npi.gal.web;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.ufc.npi.gal.model.Disciplina;
import br.ufc.npi.gal.service.DisciplinaService;

@Controller
public class DisciplinaController {

	@Autowired
	private DisciplinaService disciplinaService;

	@RequestMapping(value = "/listar_disciplinas.htm")
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String now = (new Date()).toString();

		Map<String, Object> myModel = new HashMap<String, Object>();
		myModel.put("now", now);
		myModel.put("products", this.disciplinaService.getDisciplinas());

		return new ModelAndView("listar_disciplinas", "disciplinas", this.disciplinaService.getDisciplinas());
	} 

	@RequestMapping(value = "/{id}/editDisciplina.htm", method = RequestMethod.GET)
	public String editDisciplina(@PathVariable("id") Integer id, Model model) {

		Disciplina disc = this.disciplinaService.findById(id);

		if (disc == null) {
			return "redirect:/";

		} else {
			model.addAttribute("disciplina", disc);
		}
			return "edit";
	}
	
	@RequestMapping(value = "/{id}/editDisciplinaForm.htm", method=RequestMethod.POST)
	public String updateDisciplina(@PathVariable("id") Integer id, @Valid Disciplina discUpdate, BindingResult result){
		
		if(result.hasErrors()){
			return "edit";
		}

		this.disciplinaService.updateDisciplina(discUpdate);
		return "redirect:/";
		
	}
	
	
	@RequestMapping(value = "/{id}/deleteDisciplina.htm", method = RequestMethod.GET)
	public String deleteDisciplina(@PathVariable("id") Integer id) {
		this.disciplinaService.deleteDisciplina(id);
		return "redirect:/listar_disciplinas.htm";
	}
	
	@RequestMapping("/disciplina-adicionada")
	public String confirm(){
		return "disciplina-adicionada";
	}
	
	@RequestMapping(value = "/adicionarDisciplina.htm")
	public String addDisciplina(ModelMap modelMap){
		modelMap.addAttribute("disciplina", new Disciplina());
		return "adicionarDisciplina";
	}
	
	@RequestMapping(value="/inserirDisciplina.htm",method = RequestMethod.POST)
	public String inserir(@Valid Disciplina disciplina, BindingResult result, final RedirectAttributes redirectAttributes) {
		
		if(result.hasErrors())
			return "adicionarDisciplina";
		
		if(disciplinaService.pesquisar(disciplina.getCodigoDisciplina(), disciplina.getNome()) == null) {
			disciplinaService.inserir(disciplina);
			System.out.println("Disciplina adicionada com sucesso");
			return "disciplina-adicionada";
		
		}else{
			redirectAttributes.addFlashAttribute("message", "Disciplina não pode ser adicionada pois já existe semelhante registrada");
			return "redirect:/adicionarDisciplina.htm";
		}
	}
	
	@RequestMapping("/buscar")
	public String buscar(ModelMap model, String disc) {
		model.addAttribute("disciplinas", disciplinaService.findByCod(disc));
		return "listar_disciplinas";
	}
	
	public void setProductManager(DisciplinaService productManager) {
		this.disciplinaService = productManager;
	}
}
