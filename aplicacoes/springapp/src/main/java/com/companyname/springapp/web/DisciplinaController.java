package com.companyname.springapp.web;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.companyname.springapp.domain.Disciplina;
import com.companyname.springapp.service.ProductManager;

//anotación controlador
@Controller
public class DisciplinaController {

	protected final Log logger = LogFactory.getLog(getClass());

	// vou armazenar uma referência de ProductManager dentro do meu controlador
	// para que ele possa passar as VIEWS informaçoes
	// sobre os produtos.
	@Autowired
	private ProductManager productManager;

	@RequestMapping(value = "/listar_disciplinas.htm")
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String now = (new Date()).toString();
		// msg console
		logger.info("Returning hello view with " + now);

		Map<String, Object> myModel = new HashMap<String, Object>();
		myModel.put("now", now);
		myModel.put("products", this.productManager.getDisciplinas());
		// vou retornar um hashmap com quantos campos eu quiser.
		// view + chave + valor

		return new ModelAndView("listar_disciplinas", "disciplinas", this.productManager.getDisciplinas());
	} 

	@RequestMapping(value = "/{id}/editDisciplina.htm", method = RequestMethod.GET)
	public String editDisciplina(@PathVariable("id") Integer id, Model model) {

		Disciplina disc = this.productManager.findById(id);

		if (disc == null) {

			return "redirect:/";

		} else {
			//inserindo no meu map model o objeto disc.
			model.addAttribute("editDisciplina", disc);
		}
			// retornando meu disc para a view "edit"
			return "edit";
	}
	
	@RequestMapping(value = "/{id}/editDisciplinaForm.htm", method=RequestMethod.POST)
	public String updateDisciplina(@PathVariable("id") Integer id, @ModelAttribute(value="editDisciplina") Disciplina discUpdate,BindingResult result){
		
		this.productManager.updateDisciplina(discUpdate);
		
		return "redirect:/";
	}
	
	
	@RequestMapping(value = "/{id}/deleteDisciplina.htm", method = RequestMethod.GET)
	public String deleteDisciplina(@PathVariable("id") Integer id) {

		this.productManager.deleteDisciplina(id);

		return "redirect:/listar_disciplinas.htm";
	}
	
	@RequestMapping("/disciplina-adicionada")
	public String confirm(){
		return "disciplina-adicionada";
	}
	
	@RequestMapping(value = "/adicionarDisciplina.htm")
	public String addDisciplina(){

		return "adicionarDisciplina";
	}
	
	@RequestMapping(value="/inserirDisciplina.htm",method = RequestMethod.POST)
	public String inserir(@Valid Disciplina disciplina, BindingResult result, final RedirectAttributes redirectAttributes) {
		
		if(result.hasErrors())
			return "adicionarDisciplina";
		
		if(productManager.pesquisar(disciplina.getCode(), disciplina.getNome()) == null) {
			
			productManager.inserir(disciplina);
			System.out.println("Disciplina adicionada com sucesso");
			
			return "disciplina-adicionada";
		
		}else{
			
			redirectAttributes.addFlashAttribute("message", "Disciplina não pode ser adicionada pois já existe semelhante registrada");
			
			return "redirect:/adicionarDisciplina.htm";
		}
	}
	
	@RequestMapping("/buscar")
	public String buscar(ModelMap model, String disc) {
		model.addAttribute("disciplinas", productManager.findByCod(disc));
		return "listar_disciplinas";
	}
	
	public void setProductManager(ProductManager productManager) {
		this.productManager = productManager;
	}
	
}
