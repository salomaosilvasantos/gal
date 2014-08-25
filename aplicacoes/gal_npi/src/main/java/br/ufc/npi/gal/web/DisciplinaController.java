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

import br.ufc.npi.gal.model.Bibliografia;
import br.ufc.npi.gal.model.Disciplina;
import br.ufc.npi.gal.service.DisciplinaService;

@Controller
@RequestMapping("/disciplina")
public class DisciplinaController {

	@Inject
	private DisciplinaService disciplinaService;

	@RequestMapping(value = "/listar")
	public String listar(ModelMap modelMap) {
		modelMap.addAttribute("disciplinas", this.disciplinaService.find(Disciplina.class));
		return "disciplina/listar";
	}

	@RequestMapping(value = "/{id}/editar", method = RequestMethod.GET)
	public String editar(@PathVariable("id") Integer id, ModelMap modelMap) {

		Disciplina disciplina = this.disciplinaService.find(Disciplina.class, id);

		if (disciplina == null) {
			return "redirect:/disciplina/listar";

		}
		modelMap.addAttribute("disciplina", disciplina);
		return "disciplina/editar";
	}

	@RequestMapping(value = "/editar", method = RequestMethod.POST)
	public String atualizar(@Valid Disciplina disciplina, BindingResult result, RedirectAttributes redirectAttributes) {
		if (result.hasErrors()) {
			return "disciplina/editar";
		}
		
		if(disciplinaService.getOutraDisciplinaByCodigo(disciplina.getId(), disciplina.getCodigo()) != null) {
			result.rejectValue("codigo", "Repeat.disciplina.codigo", "Já existe uma disciplina com esse código");
			return "disciplina/editar";
		}
		if(disciplinaService.getOutraDisciplinaByNome(disciplina.getId(), disciplina.getNome().toUpperCase()) != null) {
			result.rejectValue("nome", "Repeat.disciplina.nome", "Já existe uma disciplina com esse nome");
			return "disciplina/editar";
		}
		
		disciplina.setNome(disciplina.getNome().toUpperCase());
		disciplinaService.update(disciplina);
		redirectAttributes.addFlashAttribute("info", "Disciplina atualizada com sucesso.");
		return "redirect:/disciplina/listar";

	}
	
	@RequestMapping(value = "/{id}/excluir", method = RequestMethod.GET)
	public String excluir(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
		Disciplina disciplina = disciplinaService.find(Disciplina.class, id);
		if (disciplina != null) {
			this.disciplinaService.delete(disciplina);
			redirectAttributes.addFlashAttribute("info", "Disciplina removida com sucesso.");
		}
		return "redirect:/disciplina/listar";
	}

	@RequestMapping(value = "/adicionar")
	public String adicionar(ModelMap modelMap) {
		modelMap.addAttribute("disciplina", new Disciplina());
		return "disciplina/adicionar";
	}

	@RequestMapping(value = "/adicionar", method = RequestMethod.POST)
	public String adicionar(@Valid Disciplina disciplina, BindingResult result, RedirectAttributes redirectAttributes) {

		if (result.hasErrors()) {
			return "disciplina/adicionar";
		}
		
		if(disciplinaService.getDisciplinaByCodigo(disciplina.getCodigo()) != null) {
			result.rejectValue("codigo", "Repeat.disciplina.codigo", "Já existe uma disciplina com esse código");
			return "disciplina/adicionar";
		}
		if(disciplinaService.getDisciplinaByNome(disciplina.getNome().toUpperCase()) != null) {
			result.rejectValue("nome", "Repeat.disciplina.nome", "Já existe uma disciplina com esse nome");
			return "disciplina/adicionar";
		}
		
		disciplina.setNome(disciplina.getNome().toUpperCase());
		disciplinaService.save(disciplina);
		redirectAttributes.addFlashAttribute("info", "Disciplina adicionada com sucesso.");
		return "redirect:/disciplina/listar";
	}
	
	@RequestMapping(value = "/vincular_bibliografia")
	public String vincular_bibliografia(ModelMap modelMap) {
		modelMap.addAttribute("disciplina", this.disciplinaService.find(Disciplina.class));
		return "disciplina/vincular_bibliografia";
	}
}
