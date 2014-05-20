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

import br.ufc.npi.gal.model.Curso;
import br.ufc.npi.gal.service.CursoService;

@Controller
public class CursoController {

	@Autowired
	private CursoService cursoService;

	@RequestMapping(value = "/listar_cursos.htm")
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String now = (new Date()).toString();

		Map<String, Object> myModel = new HashMap<String, Object>();
		myModel.put("now", now);
		myModel.put("products", this.cursoService.getCursos());

		return new ModelAndView("listar_cursos", "cursos", this.cursoService.getCursos());
	} 

	@RequestMapping(value = "/{cod}/editCurso.htm", method = RequestMethod.GET)
	public String editCurso(@PathVariable("cod") Integer cod, Model model) {

		Curso disc = this.cursoService.findByCod(cod);

		if (disc == null) {
			return "redirect:/";

		} else {
			model.addAttribute("curso", disc);
		}
			return "edit";
	}
	
	@RequestMapping(value = "/{cod}/editCursoForm.htm", method=RequestMethod.POST)
	public String updateCurso(@PathVariable("cod") Integer cod, @Valid Curso discUpdate, BindingResult result){
		
		if(result.hasErrors()){
			return "edit";
		}

		this.cursoService.updateCurso(discUpdate);
		return "redirect:/";
		
	}
	
	
	@RequestMapping(value = "/{cod}/deleteCurso.htm", method = RequestMethod.GET)
	public String deleteCurso(@PathVariable("cod") Integer cod) {
		this.cursoService.deleteCurso(cod);
		return "redirect:/listar_cursos.htm";
	}
	
	@RequestMapping("/curso-adicionado")
	public String confirm(){
		return "curso-adicionado";
	}
	
	@RequestMapping(value = "/adicionarCurso.htm")
	public String addCurso(ModelMap modelMap){
		modelMap.addAttribute("curso", new Curso());
		return "adicionarCurso";
	}
	
	@RequestMapping(value="/inserirCurso.htm",method = RequestMethod.POST)
	public String inserir(@Valid Curso curso, BindingResult result, final RedirectAttributes redirectAttributes) {
		
		if(result.hasErrors())
			return "adicionarCurso";
		
		if(cursoService.pesquisar(curso.getSigla(), curso.getNome(), curso.getCod()) == null) {
			cursoService.inserir(curso);
			System.out.println("Curso adicionado com sucesso");
			return "curso-adicionado";
		
		}else{
			redirectAttributes.addFlashAttribute("message", "Curso não pode ser adicionado pois já existe semelhante registrada");
			return "redirect:/adicionarCurso.htm";
		}
	}
	
	@RequestMapping("/buscarCurso")
	public String buscar(ModelMap model, String disc) {
		model.addAttribute("cursos", cursoService.findByCod(disc));
		return "listar_cursos";
	}
	
	public void setProductManager(CursoService productManager) {
		this.cursoService = productManager;
	}
}
