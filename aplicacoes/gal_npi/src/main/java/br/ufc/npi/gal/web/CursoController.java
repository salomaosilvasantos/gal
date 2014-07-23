package br.ufc.npi.gal.web;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.ufc.npi.gal.model.Curso;
import br.ufc.npi.gal.service.CursoService;

@Controller
@RequestMapping("curso")
public class CursoController {

	@Autowired
	private CursoService cursoService;

	@RequestMapping(value = "/listar")
	public String listar(ModelMap modelMap) {
		modelMap.addAttribute("cursos", this.cursoService.listar());

		return "curso/listar";
	} 

	@RequestMapping(value = "/{id}/editar", method = RequestMethod.GET)
	public String editar(@PathVariable("id") Integer id, Model model) {

		Curso curso = this.cursoService.findById(id);

		if (curso == null) {
			return "curso/editar";

		} else {
			model.addAttribute("curso", curso);
		}
			return "curso/editar";
	}
	
	@RequestMapping(value = "/editar", method=RequestMethod.POST)
	public String atualizar(@Valid Curso curso, BindingResult result){
		
		if(result.hasErrors()){
			return "curso/editar";
		}

		this.cursoService.atualizar(curso);
		return "redirect:/curso/listar";
		
	}
	
	@RequestMapping(value = "/excluir", method = RequestMethod.POST)
	//ResquestParam("id") where name = "id"
	public String excluir(@RequestParam("id") Integer id) {
		this.cursoService.excluir(id);
		return "redirect:/curso/listar";
	}
	
	@RequestMapping("/adicionado")
	public String confirm(){
		return "redirect:/curso/listar";
	}
	
	@RequestMapping(value = "/adicionar")
	public String adicionar(ModelMap modelMap){
		modelMap.addAttribute("curso", new Curso());
		return "curso/adicionar";
	}
	
	@RequestMapping(value="/adicionar",method = RequestMethod.POST)
	public String adicionar(@Valid Curso curso, BindingResult result, final RedirectAttributes redirectAttributes) {
		
		if(result.hasErrors())
			return "curso/adicionar";
		
		if(cursoService.buscar(curso.getSigla(), curso.getCodigo()) == null) {
			cursoService.adicionar(curso);
			return "redirect:/curso/listar";
		
		} else {
			redirectAttributes.addFlashAttribute("message", "Curso não pode ser adicionado pois já existe semelhante registrada");
			return "redirect:/curso/adicionar";
		}
	}
	
	/*@RequestMapping(value="/adicionar",method = RequestMethod.POST)
	public @ResponseBody Curso adicionar(@RequestBody Curso curso, BindingResult result, SessionStatus status) {
		
		ModelMap modelMap = new ModelMap();
		if(result.hasErrors()) {
			modelMap.addAttribute("status", "ERROR");
			return curso;
		}
		
		if(cursoService.buscar(curso.getSigla(), curso.getCodigo()) == null) {
			cursoService.adicionar(curso);
			modelMap.addAttribute("status", "SUCESS");
		
		} else {
			modelMap.addAttribute("status", "ERROR");
		}
		return curso;
	}*/
	
	@RequestMapping("/buscar")
	public String buscar(ModelMap model, Integer codigo) {
		model.addAttribute("cursos", cursoService.findByCodigoList(codigo));
		return "cursos/listar";
	}
	
	public void setProductManager(CursoService productManager) {
		this.cursoService = productManager;
	}
}