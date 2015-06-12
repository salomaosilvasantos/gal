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
import br.ufc.npi.gal.model.EstruturaCurricular;
import br.ufc.npi.gal.model.IntegracaoCurricular;
import br.ufc.npi.gal.service.CursoService;
import br.ufc.npi.gal.service.EstruturaCurricularService;

@Controller
@RequestMapping("curso")
public class CursoController {

	@Inject
	private CursoService cursoService;
	private static final String PATH_REDIRECT_CURSO_LISTAR = "redirect:/curso/listar";
	private static final String PATH_CURSO_ADICIONAR = "curso/adicionar";
	private static final String PATH_CURSO_LISTAR = "curso/listar";
	private static final String PATH_CURSO_EDITAR = "curso/editar";
	@Inject
	private EstruturaCurricularService estruturaService;

	@RequestMapping(value = "/listar")
	public String listar(ModelMap modelMap) {
		modelMap.addAttribute("integracao", new IntegracaoCurricular());
		modelMap.addAttribute("cursos", this.cursoService.find(Curso.class));
		modelMap.addAttribute("estruturas", this.estruturaService.find(EstruturaCurricular.class));
		return "curso/listar";
	}
	
	@RequestMapping(value = "{codigo}/visualizar")
	public String visualizar(@PathVariable("codigo") Integer codigo, ModelMap modelMap) {
		modelMap.addAttribute("curso", this.cursoService.getCursoByCodigo(codigo));
		modelMap.addAttribute("integracao", new IntegracaoCurricular());
		modelMap.addAttribute("estruturas", this.estruturaService.find(EstruturaCurricular.class));
		return "curso/visualizar";
	}
	
	@RequestMapping(value = "/{id}/editar", method = RequestMethod.GET)
	public String editar(@PathVariable("id") Integer id, Model model) {
		Curso curso = this.cursoService.find(Curso.class, id);

		if (curso == null) {
			return PATH_REDIRECT_CURSO_LISTAR;
		}
		model.addAttribute("curso", curso);
		return PATH_CURSO_EDITAR;
	}

	@RequestMapping(value = "/editar", method = RequestMethod.POST)
	public String atualizar(@Valid Curso curso, BindingResult result,
			RedirectAttributes redirectAttributes) {
		if (result.hasErrors()) {
			return PATH_CURSO_EDITAR;
		}
		
		if (cursoService
				.getOutroCursoByCodigo(curso.getId(), curso.getCodigo()) != null) {
			result.rejectValue("codigo", "Repeat.curso.codigo",
					"Já existe um curso com esse código");
			return PATH_CURSO_EDITAR;
		}
		if (cursoService.getOutroCursoBySigla(curso.getId(), curso.getSigla()
				.toUpperCase()) != null) {
			result.rejectValue("sigla", "Repeat.curso.sigla",
					"Já existe um curso com essa sigla");
			return PATH_CURSO_EDITAR;
		}

		curso.setSigla(curso.getSigla().toUpperCase());
		cursoService.update(curso);
		redirectAttributes.addFlashAttribute("info",
				"Curso atualizado com sucesso.");
		return PATH_REDIRECT_CURSO_LISTAR;

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
		return PATH_REDIRECT_CURSO_LISTAR;
	}

	@RequestMapping(value = "/adicionar")
	public String adicionar(ModelMap modelMap) {
		modelMap.addAttribute("curso", new Curso());
		return PATH_CURSO_ADICIONAR;
	}

	@RequestMapping(value = "/adicionar", method = RequestMethod.POST)
	public String adicionar(@Valid Curso curso, BindingResult result,
			final RedirectAttributes redirectAttributes) {
		if (result.hasErrors()) {
			return PATH_CURSO_ADICIONAR;
		}

		if (cursoService.getCursoByCodigo(curso.getCodigo()) != null) {
			result.rejectValue("codigo", "Repeat.curso.codigo",
					"Já existe um curso com esse código");
			return PATH_CURSO_ADICIONAR;
		}
		if (curso.getNome().trim().isEmpty()) {
			result.rejectValue("codigo", "Repeat.curso.nome",
					"Campo obrigatório.");
			return PATH_CURSO_ADICIONAR;
		}
		if (cursoService.getCursoBySigla(curso.getSigla().toUpperCase()) != null) {
			result.rejectValue("sigla", "Repeat.sigla.sigla",
					"Já existe um curso com essa sigla");
			return PATH_CURSO_ADICIONAR;
		}

		curso.setSigla(curso.getSigla().toUpperCase());
		cursoService.save(curso);
		redirectAttributes.addFlashAttribute("info",
				"Curso adicionado com sucesso.");
		return PATH_REDIRECT_CURSO_LISTAR;
	}

}
