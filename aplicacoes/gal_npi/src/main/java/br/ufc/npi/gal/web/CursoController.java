package br.ufc.npi.gal.web;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.ufc.npi.gal.model.Curso;
import br.ufc.npi.gal.service.CursoService;

@Controller
@RequestMapping("curso")
public class CursoController {

	@Inject
	private CursoService cursoService;
	private static final String CURSO_REDIRECT_LISTAR = "redirect:/curso/listar";
	private static final String CURSO_ADICIONAR = "curso/adicionar";

	@RequestMapping(value = "/listar")
	public String listar(ModelMap modelMap) {
		modelMap.addAttribute("cursos", this.cursoService.find(Curso.class));
		return "curso/listar";
	}

	@RequestMapping(value = "/{id}/editar", method = RequestMethod.GET)
	public String editar(@PathVariable("id") Integer id, Model model) {
		Curso curso = this.cursoService.find(Curso.class, id);

		if (curso == null) {
			return CURSO_REDIRECT_LISTAR;
		}
		model.addAttribute("curso", curso);
		return "curso/editar";
	}

	@RequestMapping(value = "/editar", method = RequestMethod.POST)
	public String atualizar(@Valid Curso curso, BindingResult result,
			RedirectAttributes redirectAttributes) {
		String codigo = "codigo";
		
		if (result.hasErrors()) {
			return "curso/editar";
		}
		
		if (result.hasFieldErrors(codigo)) {
			return "curso/editar";
		}

		if (cursoService
				.getOutroCursoByCodigo(curso.getId(), curso.getCodigo()) != null) {
			result.rejectValue(codigo, "Repeat.curso.codigo",
					"Já existe um curso com esse código");
			return "curso/editar";
		}
		if (cursoService.getOutroCursoBySigla(curso.getId(), curso.getSigla()
				.toUpperCase()) != null) {
			result.rejectValue("sigla", "Repeat.curso.sigla",
					"Já existe um curso com essa sigla");
			return "curso/editar";
		}

		curso.setSigla(curso.getSigla().toUpperCase());
		cursoService.update(curso);
		redirectAttributes.addFlashAttribute("info",
				"Curso atualizado com sucesso.");
		return CURSO_REDIRECT_LISTAR;

	}

	@RequestMapping(value = "/{id}/excluir", method = RequestMethod.GET)
	public String excluir(@PathVariable("id") Integer id,
			RedirectAttributes redirectAttributes) {
		Curso curso = cursoService.find(Curso.class, id);
		if (curso != null) {
			this.cursoService.delete(curso);
			redirectAttributes.addFlashAttribute("info",
					"Curso removido com sucesso.");
		}
		return CURSO_REDIRECT_LISTAR;
	}

	@RequestMapping(value = "/adicionar")
	public String adicionar(ModelMap modelMap) {
		modelMap.addAttribute("curso", new Curso());
		return CURSO_ADICIONAR;
	}

	@RequestMapping(value = "/adicionar", method = RequestMethod.POST)
	public String adicionar(@Valid Curso curso, BindingResult result,
			final RedirectAttributes redirectAttributes) {
		if (result.hasErrors()) {
			return CURSO_ADICIONAR;
		}

		if (cursoService.getCursoByCodigo(curso.getCodigo()) != null) {
			result.rejectValue("codigo", "Repeat.curso.codigo",
					"Já existe um curso com esse código");
			return CURSO_ADICIONAR;
		}
		if (curso.getNome().trim().isEmpty()) {
			result.rejectValue("codigo", "Repeat.curso.nome",
					"Campo obrigatório.");
			return CURSO_ADICIONAR;
		}
		if (cursoService.getCursoBySigla(curso.getSigla().toUpperCase()) != null) {
			result.rejectValue("sigla", "Repeat.sigla.sigla",
					"Já existe um curso com essa sigla");
			return CURSO_ADICIONAR;
		}

		curso.setSigla(curso.getSigla().toUpperCase());
		cursoService.save(curso);
		redirectAttributes.addFlashAttribute("info",
				"Curso adicionado com sucesso.");
		return CURSO_REDIRECT_LISTAR;
	}

}