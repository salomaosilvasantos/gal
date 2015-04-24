package br.ufc.npi.gal.web;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import br.ufc.npi.gal.model.Bibliografia;
import br.ufc.npi.gal.model.Disciplina;
import br.ufc.npi.gal.model.Titulo;
import br.ufc.npi.gal.service.DisciplinaService;
import br.ufc.npi.gal.service.TituloService;
import br.ufc.quixada.npi.service.GenericService;

@Controller
@RequestMapping("/disciplina")
public class DisciplinaController {

	@Inject
	private DisciplinaService disciplinaService;
	
	@Inject
	private TituloService tituloService;

	@Inject
	private GenericService<Bibliografia> bibliografiaService;
	
	private static final String COMPLEMENTAR = "Complementar";
	private static final String BASICA = "Básica";
	
	@RequestMapping(value = "/listar")
	public String listar(ModelMap modelMap, HttpSession session) {
		modelMap.addAttribute("disciplinas", this.disciplinaService.find(Disciplina.class));
		return "disciplina/listar";
	}

	@RequestMapping(value = "/{id}/editar", method = RequestMethod.GET)
	public String editar(@PathVariable("id") Integer id, ModelMap modelMap) {

		Disciplina disciplina = this.disciplinaService.find(Disciplina.class,
				id);

		if (disciplina == null) {
			return "redirect:/disciplina/listar";

		}
		modelMap.addAttribute("disciplina", disciplina);
		return "disciplina/editar";
	}

	@RequestMapping(value = "/editar", method = RequestMethod.POST)
	public String atualizar(@Valid Disciplina disciplina, BindingResult result,
			RedirectAttributes redirectAttributes) {
		if (result.hasErrors()) {
			return "disciplina/editar";
		}

		if (disciplinaService.getOutraDisciplinaByCodigo(disciplina.getId(),
				disciplina.getCodigo()) != null) {
			result.rejectValue("codigo", "Repeat.disciplina.codigo",
					"Já existe uma disciplina com esse código");
			return "disciplina/editar";
		}
		if (disciplinaService.getOutraDisciplinaByNome(disciplina.getId(),
				disciplina.getNome().toUpperCase()) != null) {
			result.rejectValue("nome", "Repeat.disciplina.nome",
					"Já existe uma disciplina com esse nome");
			return "disciplina/editar";
		}

		disciplina.setNome(disciplina.getNome().toUpperCase());
		disciplinaService.update(disciplina);
		redirectAttributes.addFlashAttribute("info",
				"Disciplina atualizada com sucesso.");
		return "redirect:/disciplina/listar";

	}

	@RequestMapping(value = "/{id}/excluir", method = RequestMethod.GET)
	public String excluir(@PathVariable("id") Integer id,
			RedirectAttributes redirectAttributes) {
		Disciplina disciplina = disciplinaService.find(Disciplina.class, id);
		if (disciplina != null) {
			this.disciplinaService.delete(disciplina);
			redirectAttributes.addFlashAttribute("info",
					"Disciplina removida com sucesso.");
		}
		return "redirect:/disciplina/listar";
	}

	@RequestMapping(value = "/adicionar")
	public String adicionar(ModelMap modelMap) {
		modelMap.addAttribute("disciplina", new Disciplina());
		return "disciplina/adicionar";
	}

	@RequestMapping(value = "/adicionar", method = RequestMethod.POST)
	public String adicionar(@Valid Disciplina disciplina, BindingResult result,
			RedirectAttributes redirectAttributes) {

		if (result.hasErrors()) {
			return "disciplina/adicionar";
		}

		if (disciplinaService.getDisciplinaByCodigo(disciplina.getCodigo()) != null) {
			result.rejectValue("codigo", "Repeat.disciplina.codigo",
					"Já existe uma disciplina com esse código");
			return "disciplina/adicionar";
		}
		if (disciplina.getNome().trim().isEmpty()) {
			result.rejectValue("nome", "Repeat.disciplina.nome",
					"Campo obrigatório.");
			return "disciplina/adicionar";
		}
		if (disciplinaService.getDisciplinaByNome(disciplina.getNome()
				.toUpperCase()) != null) {
			result.rejectValue("nome", "Repeat.disciplina.nome",
					"Já existe uma disciplina com esse nome");
			return "disciplina/adicionar";
		}

		disciplina.setNome(disciplina.getNome().toUpperCase());
		disciplinaService.save(disciplina);
		redirectAttributes.addFlashAttribute("info",
				"Disciplina adicionada com sucesso.");
		return "redirect:/disciplina/listar";
	}

	@RequestMapping(value = "/{id}/vincular", method = RequestMethod.GET)
	public String vincular(@PathVariable("id") Integer id, ModelMap modelMap) {
		List<Titulo> listaIdTitulo;
		List<Titulo> complementar;
		Disciplina disciplina = this.disciplinaService.find(Disciplina.class,
				id);
		List<Titulo> titulos = this.tituloService.find(Titulo.class);
		if (disciplina == null) {
			return "redirect:/disciplina/listar";

		}
		List<Bibliografia> bibliografias = disciplina.getBibliografias();
		listaIdTitulo = new ArrayList<Titulo>();
		complementar = new ArrayList<Titulo>();
		for (Bibliografia b : bibliografias) {
			if (b.getTipoBibliografia().equals(DisciplinaController.BASICA)) {
				listaIdTitulo.add(b.getTitulo());
				titulos.remove(b.getTitulo());
			} else if (b.getTipoBibliografia().equals(DisciplinaController.COMPLEMENTAR)) {
				complementar.add(b.getTitulo());
				titulos.remove(b.getTitulo());
			}
		}
		modelMap.addAttribute("titulo", titulos);
		modelMap.addAttribute("basica", listaIdTitulo);
		modelMap.addAttribute("complementar", complementar);
		modelMap.addAttribute("disciplina", disciplina);
		return "disciplina/vincularBibliografia";
	}


	public List<Bibliografia> atualizaOuCriaBibligrafia (String[] listaIdTitulo, List<Bibliografia> bibliografiasAseremModificadas, Disciplina disciplina, String tipoBibliografia){
		int id_titulo;
		
		if(!listaIdTitulo[0].isEmpty()){
		for (int i = 0; i < listaIdTitulo.length; i++) {
			id_titulo = Integer.parseInt(listaIdTitulo[i]);
			for (int j = 0; j < bibliografiasAseremModificadas.size(); j++) {
				if (bibliografiasAseremModificadas.get(j).getTitulo().getId() == id_titulo) {
					if (!bibliografiasAseremModificadas.get(j).getTipoBibliografia().equals(tipoBibliografia)) {
						bibliografiasAseremModificadas.get(j).setTipoBibliografia(tipoBibliografia);
						bibliografiaService.update(bibliografiasAseremModificadas.get(j));
						bibliografiasAseremModificadas.remove(bibliografiasAseremModificadas.get(j));
						listaIdTitulo[i]=null;
						j=bibliografiasAseremModificadas.size()+1;
						
					}else{
						bibliografiasAseremModificadas.remove(bibliografiasAseremModificadas.get(j));
						listaIdTitulo[i]=null;
					}
					
				} 
			}
			if (listaIdTitulo[i]!=null){
				Bibliografia biblio = new Bibliografia();
				biblio.setDisciplina(disciplina);
				biblio.setTitulo(tituloService.find(Titulo.class, id_titulo));
				biblio.setTipoBibliografia(tipoBibliografia);
				bibliografiaService.save(biblio);
			}
		}
		}
		return bibliografiasAseremModificadas;
	}
	
	@RequestMapping(value = "/vincular")
	public String vincular(@RequestParam("basica") String basica, @RequestParam("complementar") String complementar, @RequestParam("idDiciplina") Integer idDiciplina) {

		String[] basicaArray = basica.split(",");
		
		String[] complementarArray = complementar.split(",");


		Disciplina disciplina = this.disciplinaService.find(Disciplina.class,idDiciplina);
		List<Bibliografia> bibliografiaLista = disciplina.getBibliografias();
		
		bibliografiaLista = atualizaOuCriaBibligrafia(basicaArray, bibliografiaLista, disciplina, DisciplinaController.BASICA);
		bibliografiaLista = atualizaOuCriaBibligrafia(complementarArray, bibliografiaLista, disciplina, DisciplinaController.COMPLEMENTAR);
		for (int i = 0; i < bibliografiaLista.size(); i++) {
			bibliografiaService.delete(bibliografiaLista.get(i));
		}
		return "/gal_npi/disciplina/listar";
	}

}