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

import br.ufc.npi.gal.model.Curso;
import br.ufc.npi.gal.model.EstruturaCurricular;
import br.ufc.npi.gal.service.CursoService;
import br.ufc.npi.gal.service.EstruturaCurricularService;

@Controller
@RequestMapping("estrutura")
public class EstruturaCurricularController {

	@Inject
	private EstruturaCurricularService estruturaCurricularService;
	@Inject
	private CursoService cursoService;
	
	
	@RequestMapping(value = "/listar")
	public String listar(ModelMap modelMap) {
		modelMap.addAttribute("estrutura", this.estruturaCurricularService.find(EstruturaCurricular.class));
		return "estrutura/listar";
	}

	@RequestMapping(value="/{id}/editar",method = RequestMethod.GET)
	public String editar(@PathVariable("id") Integer id, ModelMap modelMap){
		EstruturaCurricular estruturaCurricular = this.estruturaCurricularService.find(EstruturaCurricular.class, id);
		if(estruturaCurricular == null){
			return "curso/listar";
		}
		modelMap.addAttribute("curso", estruturaCurricular.getCurso());
		modelMap.addAttribute("estruturaCurricular", estruturaCurricular);
		System.out.println(estruturaCurricular);
		return "estrutura/editar";
	}
	
	@RequestMapping(value="/{id}/editar", method=RequestMethod.POST)
	public String atualizar(@Valid EstruturaCurricular estrutura,BindingResult result, RedirectAttributes redirectAttributes,@PathVariable("id") Integer id){
		
		if(result.hasErrors()){
			return "estrutura/editar";
		}
		
		Curso curso = cursoService.find(Curso.class, id);
		estrutura.setCurso(curso);
		
		estruturaCurricularService.update(estrutura);
		redirectAttributes.addFlashAttribute("info","Estrutura Curricular atualizada com sucesso");
		return "redirect:/curso/listar";
	}
	
	@RequestMapping(value="/{id}/excluir")
	public String excluir(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes){
		EstruturaCurricular estruturaCurricular = estruturaCurricularService.find(EstruturaCurricular.class, id);
		
		if(estruturaCurricular != null){
			this.estruturaCurricularService.delete(estruturaCurricular);
			
		}
		redirectAttributes.addFlashAttribute("info","Estrutura Curricular removida com sucesso");
		return "redirect:/curso/listar";
	}
	
	@RequestMapping(value="/{id}/adicionar",method = RequestMethod.GET)
	public String adicionar(@PathVariable("id") Integer id,ModelMap modelMap){
		
		Curso curso = this.cursoService.find(Curso.class, id);
		modelMap.addAttribute("curso",curso);
		modelMap.addAttribute("estruturaCurricular", new EstruturaCurricular());
		return "estrutura/adicionar";
	}
	
	@RequestMapping(value="/{id}/adicionar", method = RequestMethod.POST)
	public String adicionar(@Valid EstruturaCurricular estruturaCurricular, BindingResult result, @PathVariable("id") Integer id,
			RedirectAttributes redirectAttributes, ModelMap modelMap) {
		
		if (result.hasErrors()) {
			return "estrutura/adicionar";
		}
		
		if (estruturaCurricular.getAnoSemestre().trim().isEmpty()) {
			result.rejectValue("anoSemestre", "Repeat.estrutura.anoSemestre",
					"Campo obrigatório.");
			return "estrutura/adicionar";
		}
		
		
		if(estruturaCurricularService.getOutraEstruturaCurricularByAnoSemestre(id, estruturaCurricular.getAnoSemestre())!=null){
			result.rejectValue("anoSemestre", "Repeat.estruturas.anoSemestre","Ano e Semestre já existe para curso");
			return "estrutura/adicionar";
		}
		
		Curso curso = this.cursoService.find(Curso.class, id);
		modelMap.addAttribute("curso",curso);
		
		estruturaCurricular.setCurso(curso);
		estruturaCurricular.setId(null);
			
		estruturaCurricularService.save(estruturaCurricular);
		
		redirectAttributes.addFlashAttribute("info",
				"Estrutura Curricular adicionada com sucesso.");
		return "redirect:/curso/listar";
	}
}
